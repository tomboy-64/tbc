# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
OASIS_BUILD_DOCS=1

inherit oasis

DESCRIPTION="QuickCheck inspired property-based testing for OCaml"
HOMEPAGE="https://github.com/c-cube/qcheck"
SRC_URI="https://github.com/c-cube/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ounit"

RDEPEND="
	!<dev-ml/ounit-2
	ounit? ( dev-ml/ounit )
"
DEPEND="
	${RDEPEND}
"

oasis_configure_opts="
	$(oasis_use_enable ounit ounit)
"

DOCS=( CHANGELOG.md README.md )
