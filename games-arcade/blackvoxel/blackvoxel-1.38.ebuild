# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games

DESCRIPTION="a"
HOMEPAGE="b"
SRC_URI="https://github.com/Blackvoxel/Blackvoxel/archive/v${PV}.tar.gz -> ${PF}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/Blackvoxel-${PV}"

src_prepare() {
	sed -i 's/\(CFLAGS\)=\(.*\)/\1+=\2/g' Makefile || die
	sed -i 's/\(CFLAGS.*\)-O3/\1/g' Makefile || die
	sed -i '/Licence/d' Makefile || die
}

src_install() {
	emake specialinstall=1 \
		DESTDIR="${D}" \
		bindir="${D}/usr/bin/" \
		icondir="${D}/usr/share/icons/" \
		icondir2="${D}/usr/share/icons/" \
		desktopdir="${D}/usr/share/applications/" \
		blackvoxeldatadir="${D}/usr/share/${PF}/"
		install
}
