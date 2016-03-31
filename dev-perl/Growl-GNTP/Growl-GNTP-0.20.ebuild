# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DIST_AUTHOR=MATTN
DIST_VERSION=0.20
inherit perl-module

DESCRIPTION="Perl implementation of GNTP Protocol (Client Part)"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Data-UUID
	dev-perl/Crypt-CBC
	virtual/perl-Digest-MD5
	virtual/perl-Digest-SHA
	virtual/perl-Encode
	virtual/perl-IO"
DEPEND="${RDEPEND}
	dev-perl/Module-Build
	virtual/perl-File-Spec
	virtual/perl-CPAN-Meta"

SRC_TEST=do
