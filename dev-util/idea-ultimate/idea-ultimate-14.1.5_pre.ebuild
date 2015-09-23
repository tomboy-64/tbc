# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils versionator

SLOT="0"
PV_STRING="141.2735.5" # Needs to be adjusted for each release.
MY_PV="$(echo ${PV} | sed -e 's/_pre//')" # Always name EAP-versions with '_pre' for clarity!
MY_PN="idea"

DESCRIPTION="A complete toolset for web, mobile and enterprise development"
HOMEPAGE="http://www.jetbrains.com/idea"
SRC_URI="https://download.jetbrains.com/idea/${MY_PN}IU-${MY_PV}.tar.gz"

LICENSE="IDEA IDEA_Academic IDEA_Classroom IDEA_OpenSource IDEA_Personal"
IUSE=""
KEYWORDS="" # No keywords for EAP versions. Code quality sucks.

DEPEND="!dev-util/idea-ultimate:14
	!dev-util/idea-ultimate:15"
RDEPEND="${DEPEND}
	>=virtual/jdk-1.7"
S="${WORKDIR}/${MY_PN}-IU-${PV_STRING}"

QA_TEXTRELS="opt/idea-${MY_PV}/bin/libbreakgen.so"

src_install() {
	local dir="/opt/${PN}-${MY_PV}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}"/bin/{idea.sh,fsnotifier{,64}}

	make_wrapper "${PN}" "${dir}/bin/${MY_PN}.sh"

	# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	mkdir -p "${D}/etc/sysctl.d/"
	echo "fs.inotify.max_user_watches = 524288" > "${D}/etc/sysctl.d/30-idea-inotify-watches.conf"
}
