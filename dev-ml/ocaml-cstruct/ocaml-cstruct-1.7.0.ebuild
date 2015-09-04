# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

OASIS_BUILD_TESTS=1

inherit oasis findlib

DESCRIPTION="Map OCaml arrays onto C-like structs"
HOMEPAGE="https://github.com/mirage/ocaml-cstruct"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-ml/async:=
	dev-ml/camlp4:=
	dev-ml/lwt:=
	dev-ml/ocplib-endian:=
	dev-ml/sexplib:=
	dev-ml/type-conv:=
"
DEPEND="
	>=dev-lang/ocaml-4.01
	${RDEPEND}
"

DOCS=( CHANGES README.md TODO.md )
