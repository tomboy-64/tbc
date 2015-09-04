# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

OASIS_BUILD_TESTS=1

inherit oasis findlib

DESCRIPTION="IO memory page library for Mirage backends"
HOMEPAGE="https://github.com/mirage/io-page"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-ml/ocaml-cstruct-1.1.0:=
"
#	Supposedly there's an optional dependency on mirage-xen-ocaml, but couldn't find the package.

DEPEND="
	>=dev-lang/ocaml-4:=
	${RDEPEND}
"

DOCS=( CHANGES README.md )
