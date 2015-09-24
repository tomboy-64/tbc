# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils versionator

SLOT="0"
PV_STRING="$(get_version_component_range 4-6)" # Always name EAP-versions with '_pre' for clarity!
MY_PV="$(get_version_component_range 1-3)"
MY_PN="idea"

DESCRIPTION="A complete toolset for web, mobile and enterprise development"
HOMEPAGE="http://www.jetbrains.com/idea"
SRC_URI="https://download.jetbrains.com/idea/${MY_PN}IU-${MY_PV}.tar.gz"

LICENSE="IDEA IDEA_Academic IDEA_Classroom IDEA_OpenSource IDEA_Personal"
IUSE=""
KEYWORDS="~amd64 ~x86" # No keywords for EAP versions. Code quality sucks.

DEPEND="!dev-util/idea-ultimate:14
	!dev-util/idea-ultimate:15"
RDEPEND="${DEPEND}
	>=virtual/jdk-1.7"
S="${WORKDIR}/${MY_PN}-IU-${PV_STRING}"

QA_TEXTRELS="opt/idea-ultimate-${MY_PV}/bin/libbreakgen.so"
QA_PRESTRIPPED="opt/idea-ultimate-14.1.4/lib/libpty/linux/x86/libpty.so
	opt/idea-ultimate-14.1.4/lib/libpty/linux/x86_64/libpty.so
	opt/idea-ultimate-14.1.4/bin/libyjpagent-linux.so
	opt/idea-ultimate-14.1.4/bin/libyjpagent-linux64.so"

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

pkg_postinst() {
	if [[ "$(get_version_component_range 7)x" = "prex" ]]
	then
		einfo "Be aware, this is a release from their EAP. According to JetBrains, the code"
		einfo "quality of such releases may be considerably below of what you might usually"
		einfo "be used to from beta releases."
		einfo "Don't use it for critical tasks. You have been warned."
	fi
}
