# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DIST_AUTHOR="KRYDE"
DIST_VERSION="6"
inherit perl-module

DESCRIPTION="constant subs with deferred value calculation"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-perl/B-Utils
	dev-perl/Sub-Identify
	virtual/perl-Carp
	virtual/perl-Data-Dumper
	virtual/perl-Memoize
	virtual/perl-Package-Constants
	virtual/perl-Pod-Simple"
DEPEND="virtual/perl-ExtUtils-MakeMaker
	virtual/perl-Exporter
	test? ( dev-perl/File-Slurp
		virtual/perl-ExtUtils-Manifest
		virtual/perl-Test
		virtual/perl-Test-Simple )"

SRC_TEST="do"
