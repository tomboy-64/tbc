# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DIST_AUTHOR="KRYDE"
DIST_VERSION="122"

inherit perl-module

DESCRIPTION="Mathematical paths through the 2-D plane"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	dev-perl/Math-Libm
	>=dev-perl/constant-defer-5.0.0
	virtual/perl-Scalar-List-Utils
"

DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		virtual/perl-Test
	)
"

SRC_TEST="do"
