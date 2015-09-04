# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

OASIS_BUILD_TESTS=1

inherit oasis

DESCRIPTION="Optimised functions to read and write int16/32/64 from strings, bytes and bigarrays, based on primitives added in version 4.01"
HOMEPAGE="https://github.com/OCamlPro/ocplib-endian"
SRC_URI="https://github.com/OCamlPro/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-ml/cppo
	${RDEPEND}
"
RDEPEND=""

DOCS=( CHANGES.md COPYING.txt README.md )
