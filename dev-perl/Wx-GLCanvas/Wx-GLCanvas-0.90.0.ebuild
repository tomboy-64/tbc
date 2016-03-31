# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DIST_AUTHOR="MBARBON"
DIST_VERSION="0.09"
inherit perl-module

DESCRIPTION="interface to wxWidgets' OpenGL canvas"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/OpenGL
	>=dev-perl/Wx-0.570.0"
DEPEND="${RDEPEND}
	virtual/perl-Exporter
	virtual/perl-ExtUtils-MakeMaker
"

# Tests fail due to needing access to an active X11 session, virtualx doesn't suffice
RESTRICT="test"

SRC_TEST="do"
