# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils flag-o-matic games

MY_P=${P/o-a/oa}

DESCRIPTION="UFO: Alien Invasion - X-COM inspired strategy game"
HOMEPAGE="http://ufoai.sourceforge.net/"
SRC_URI="mirror://sourceforge/ufoai/${MY_P}-source.tar.bz2
	mirror://sourceforge/ufoai/${MY_P}-data.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug dedicated editor profile sdl2 server static-libs sse test"

# Dependencies and more instructions can be found here:
# http://ufoai.ninex.info/wiki/index.php/Compile_for_Linux
DEPEND="
		dev-libs/libxml2
		dev-libs/mini-xml
		media-libs/openal
		media-libs/libogg
		media-libs/libtheora
		media-libs/libvorbis
		media-libs/xvid
		virtual/jpeg:0
		(
			( media-libs/sdl-image[jpeg,png]
				media-libs/libsdl
				media-libs/sdl-mixer
				media-libs/sdl-ttf )
			|| ( media-libs/sdl2-image[jpeg,png]
				media-libs/libsdl2
				media-libs/sdl2-mixer
				media-libs/sdl2-ttf
			)
		)
		editor? (
			x11-libs/gtk+:2
			x11-libs/gtkglext
			x11-libs/gtksourceview:2.0
		)
		net-misc/curl
		virtual/glu
		virtual/opengl
		x11-proto/xf86vidmodeproto
		sys-devel/gettext
		sys-libs/zlib
		test? ( dev-util/cunit )
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}-source

pkg_setup() {
	if use profile; then
		ewarn "USE=\"profile\" is incompatible with the hardened profile's -pie flag."
	fi
}

src_unpack() {
	unpack ${MY_P}-source.tar.bz2
	cd "${S}" || die
	unpack ${MY_P}-data.tar
}

src_configure() {
	local myconf="
		--enable-game
		--disable-memory
		$(use_enable !debug release)
		$(use_enable debug execinfo)
		$(use_enable debug signals)
		$(use_enable dedicated cgame-campaign)
		$(use_enable dedicated cgame-multiplayer)
		$(use_enable dedicated cgame-skirmish)
		$(use_enable !dedicated ufo)
		$(use_enable editor ufo2map)
		$(use_enable editor ufomodel)
		$(use_enable editor ufoslicer)
		$(use_enable editor uforadiant)
		$(use_enable profile profiling)
		$(use_enable server ufoded)
		$(use_enable static-libs hardlinkedgame)
		$(use_enable static-libs hardlinkedcgame)
		$(use_enable static-libs static)
		$(use_enable sse)
		$(use_enable test testall)
		--disable-paranoid
		--bindir=${GAMES_BINDIR}
		--libdir=$(games_get_libdir)
		--datadir=${GAMES_DATADIR}/${PN/-}
		--localedir=${EPREFIX}/usr/share/locale/
		--prefix=${GAMES_PREFIX}
	"
	if use !sdl2; then
		myconf=${myconf}"
		--disable-sdl2"
	fi

	echo "./configure ${myconf}"
	./configure ${myconf} || die
	echo ${PWD}
}

src_compile() {
	echo ${PWD}
	emake || die
	emake lang || die

	if use editor; then
		emake uforadiant || die
	fi
}

src_install() {
	newicon src/ports/linux/ufo.png ${PN}.png || die
	if use server; then
		dobin ufoded || die
		make_desktop_entry ufoded "UFO: Alien Invasion Server" ${PN}
	fi
	if not use dedicated; then
		dobin ufo || die
		make_desktop_entry ufo "UFO: Alien Invasion" ${PN}
	fi

	if use editor; then
		dobin ufo2map ufomodel ufoslicer uforadiant ^|| die
	fi

	# install data
	insinto "${GAMES_DATADIR}"/${PN/-}
	doins -r base || die
	rm -rf "${ED}/${GAMES_DATADIR}/${PN/-}/base/game.so"
	dogameslib base/game.so

	# move translations where they belong
	dodir "${GAMES_DATADIR_BASE}/locale" || die
	mv "${ED}/${GAMES_DATADIR}/${PN/-}/base/i18n/"* \
		"${ED}/${GAMES_DATADIR_BASE}/locale/" || die
	rm -rf "${ED}/${GAMES_DATADIR}/${PN/-}/base/i18n/" || die

	prepgamesdirs
}
