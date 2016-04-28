#!/bin/bash

# This is a personal script by tomboy64.
# Copyright 2016 tomboy64.
# Published under the BSD-3-Clause.

# v1.0

function helpprint() {
  echo
  echo "Usage:"
  echo "ARCH=(arm|arm64|x86|x86_64) chroot-here.sh STAGE3FILE"
  echo "STAGE3FILE can be any stage3-tarball."
  echo "ARCH must be one of arm, arm64, x86 or x86_64."
  echo
  echo "In general it may name any specific arch you have support for in /etc/binfmt.d."
  echo "(In case you add more, DO NOT ADD YOUR HOSTS ARCH THERE!"
  echo
  echo "BEWARE: THIS SCRIPT GIVES THE CHOICE TO ERASE THE CWD!"
  echo
  exit 0
}

function quit() {
  echo
  echo -n "Fatal error: "
  echo "$@"
  exit 1
}

function cntdwn() {
  local start=10
  if [[ $1 -ge 0 ]]
  then
    start=$1
  fi
  echo
  for i in $(seq "${start}" -1 0)
  do
    echo -n "${i} "
    sleep 1s
  done
  echo
}

function mountDir() {
  local dir=$1
  echo -n "Checking ${dir} ... "
  if [[ ! -d "./${dir}" ]]
  then
    echo -n "creating ... "
    mkdir -p "${dir}" || quit "Creation of ${dir} failed."
  fi
  if [[ $(mount | grep "${PWD}" | grep -c "${dir} type") -ge 1 ]]
  then
    echo "already mounted."
  else
    echo -n "mounting ... "
    mount --bind "/${dir}" "${dir}" || quit "Couldn't mount ${dir}."
    echo "done."
  fi
}

function umountDir() {
  local dir=$1
  echo -n "Unmounting ${dir} ... "
  umount "${PWD}/${dir}" 2&>/dev/null
  echo "done."
}

if [[ $(echo "$@" | grep -c "\-\-help") -gt 0 ]]; then
  helpprint
fi

case ${ARCH} in
  arm)
    ARCH_FULL=arm
    ;;
  arm64)
    ARCH_FULL=aarch64
    ;;
  x86)
    ARCH_FULL=x86
    ;;
  amd64)
    ARCH_FULL=x86_64
    ;;
  *)
    quit "No suitable ARCH given: ${ARCH}."
    ;;
esac

STAGE3_PATH=$(dirname "$1")
STAGE3_FILE=$(basename "$1")

# various preliminary checks
if [[ ${ARCH_FULL} == x86 || ${ARCH} == amd64 ]]; then
  echo "No binfmt support necessary."
elif [[ $(mount | grep -c '^binfmt_misc') -eq 0 ]]
then
  quit "binfmt_misc support missing."
elif [[ $(grep -c ":${ARCH_FULL}:" /etc/binfmt.d/*) -eq 0 ]]
then
  quit "Can't find support for ${ARCH_FULL} in /etc/binfmt.d/."
elif [[ $(grep -c ":${ARCH_FULL}:" /etc/binfmt.d/*) -gt 1 ]]
then
  quit "Support for ${ARCH_FULL} ambiguous in /etc/binfmt.d/."
else
  QEMU_BIN=$(grep ":${ARCH_FULL}:" /etc/binfmt.d/* | awk -F ':' '{print $7}')
fi

if [[ ${ARCH_FULL} == x86 || ${ARCH} == amd64 ]]; then
  echo "No Qemu needed either."
elif [[ ! -f "${QEMU_BIN}" ]]
then
  quit "Can't find ${QEMU_BIN}. Is it available?"
elif [[ $(LC_ALL=C ldd "${QEMU_BIN}" | grep -c "not a dynamic executable") -ne 1 ]]
then
  quit "The qemu executable (${QEMU_BIN}) is not statically linked."
elif [[ ${PWD} == '/' ]]
then
  quit "You a mad fella. Don't run this in '/'!"
fi

if [[ ${EUID} -ne 0 ]]
then
  quit "You need to run this as root."
fi

if [[ -z "${STAGE3_PATH}" ]]
then
  STAGE3_PATH="${PWD}"
fi
if [[ -z "${STAGE3_FILE}" ]]
then
  echo -n "No stage3 given; attempt to locate newest available in ${STAGE3_PATH} ..."
  STAGE3_FILE=$(basename "$(find "${STAGE3_PATH}" -name 'stage3-'"${ARCH}"'-*.tar.bz2' | sort -r | head -n1)")
  echo " done."
fi
if [[ ! -f "${STAGE3_PATH}/${STAGE3_FILE}" ]]
then
  echo "No stage3 available (${STAGE3_PATH}/${STAGE3_FILE})."
fi

# MAKE SURE NONE OF THOSE PATHS IS PREPENDED WITH A /!
MOUNT_PATHS=( usr/portage proc sys dev dev/pts dev/shm )

#if [[ -d "./${ARCH}-chroot" ]]
#then
  echo -n "Erase './'? [y/N] "
  read -n1 -r response
  if [[ "${response}" == "y" ]]
  then
    echo

    idx=$(( ${#MOUNT_PATHS[@]} - 1 ))
    while [[ ${idx} -ge 0 ]]
    do
      umountDir "./${MOUNT_PATHS[idx]}"
      idx=$(( idx - 1 ))
    done

    if [[ $(mount | grep -c "${PWD}") -gt 0 ]]
    then
      quit "Not all mounts from ${PWD} removed."
    fi

    if [[ $(find . | head -n2 | wc -l) -gt 1 ]]; then
      echo -n "Erasing ... "
        rm -r ./* || quit "Erasing ${PWD} failed."
      echo "done."
    fi

    #mkdir "${ARCH}-chroot" || quit "mkdir ${ARCH}-chroot"
    #cd "${ARCH}-chroot" || quit "${ARCH}-chroot could not be entered."
    #echo "Entered ${PWD}"

    if [[ -f "${STAGE3_PATH}/${STAGE3_FILE}" ]]; then
      echo -n "Extracting stage3 ... "
      tar xf "${STAGE3_PATH}/${STAGE3_FILE}" || quit "Extraction of ${STAGE3_PATH}/${STAGE3_FILE} failed."
     echo "done."
    fi

  fi
#  else

#    cd "${ARCH}-chroot" || quit "${ARCH}-chroot could not be entered."
#    echo "Entered ${PWD}"
#  fi
#fi


for i in "${MOUNT_PATHS[@]}"
do
  mountDir "${i}"
done

cp -v /etc/resolv.conf etc/ || quit "Couldn't copy resolv.conf"
if [[ ${ARCH_FULL} != x86 && ${ARCH} != amd64 ]]; then
  cp -v "${QEMU_BIN}" ".$(dirname "${QEMU_BIN}")" || quit "Couldn't copy qemu binary."
fi
  cat <<EOF >> etc/portage/make.conf || quit "Couldn't write to etc/portage/make.conf."
MAKEOPTS="-j5"
EMERGE_DEFAULT_OPTS="--verbose --autounmask-write --nospinner --keep-going -j5 --load-average=5 --verbose-conflict"
PYTHON_SINGLE_TARGET="python3_4"
PYTHON_TARGETS="python2_7 python3_3 python3_4 python3_5 pypy pypy2"
EOF
if [[ ${ARCH_FULL} == x86 ]]; then
  PS1="chroot${PS1}" linux32 chroot ./ /bin/bash --login || quit "Chrooting failed."
else
  chroot ./ /bin/bash --login || quit "Chrooting failed."
fi

idx=$(( ${#MOUNT_PATHS[@]}-1 ))
while [[ ${idx} -ge 0 ]]
do
  umountDir "${MOUNT_PATHS[idx]}"
  idx=$(( idx - 1 ))
done
