# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="The secret chronicles of Dr. M."
HOMEPAGE="TSC"
SRC_URI="https://github.com/Secretchronicles/${PN}/archive/v${PV}.tar.gz -> ${PF}.tar.gz"

LICENSE="custom"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc nls"

DEPEND="dev-ruby/rake
	doc? ( media-gfx/graphviz
	dev-ruby/kramdown
	dev-ruby/coderay
	app-doc/doxygen
	dev-ruby/rdoc )
	${RDEPEND}"
RDEPEND="
	>=dev-games/cegui-0.7
	media-libs/devil
	nls? ( sys-devel/gettext )
	dev-libs/libpng:0
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	dev-libs/libpcre
	dev-cpp/libxmlpp:2.6
	media-libs/freetype
	dev-libs/boost[threads]
	media-libs/glew
	virtual/opengl
	x11-libs/libX11
	"

S="${WORKDIR}/TSC-${PV}/tsc"

src_configure() {
	local mycmakeargs=(
		-DFIXED_DATA_DIR="${EPREFIX}/usr/share/tsc/"
		-DBINARY_DIR="${EPREFIX}/usr/bin/"
		-DPREFIX="${EPREFIX}/usr"
		$(cmake-utils_use_enable nls)
	)

	cmake-utils_src_configure
}
