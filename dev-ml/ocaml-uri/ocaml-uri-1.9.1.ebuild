# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

OASIS_BUILD_TESTS=1

inherit oasis findlib

DESCRIPTION="RFC3986 URI parsing library for OCaml" 
HOMEPAGE="https://github.com/mirage/ocaml-uri"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-ml/ocaml-re:=
	>=dev-ml/sexplib-109.53.00:=
	dev-ml/stringext:=
	dev-ml/type-conv:=
"
DEPEND="
	${RDEPEND}
"

DOCS=( CHANGES README.md )
