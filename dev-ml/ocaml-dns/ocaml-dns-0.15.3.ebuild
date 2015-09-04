# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

OASIS_BUILD_TESTS=1

inherit oasis

DESCRIPTION="A pure OCaml implementation of the DNS protocol" 
HOMEPAGE="https://github.com/mirage/ocaml-dns"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2 LGPL-2.1-with-linking-exception ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-ml/async:=
	>=dev-ml/ocaml-base64-2.0.0:=
	dev-ml/cmdliner:=
	>=dev-ml/lwt-2.4.7:=
	dev-ml/mirage-profile:=
	>=dev-ml/ocaml-cstruct-1.0.1:=
	>=dev-ml/ocaml-ipaddr-2.6.0:=
	dev-ml/ocaml-re:=
	>=dev-ml/ocaml-uri-1.7.0:=
	dev-ml/async:=
	!dev-ml/odns
"
DEPEND="
	>=dev-lang/ocaml-4:=
	${RDEPEND}
"

DOCS=( CHANGES README.md TODO.md )
