# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="Skylable SX - a distributed object-storage software for data clusters."
HOMEPAGE="http://www.skylable.com/products/sx"
EGIT_REPO_URI="https://github.com/sx-mirror/sx.git"
EGIT_COMMIT="${PV}"

LICENSE="GPL-2 LGPL-2.1 openssl"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/fcgi
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
EGIT_CHECKOUT_DIR=${S}

src_configure() {
	./configure --prefix=${D} \
				--enable-dependency-tracking \
				--disable-silent-rules \
				--with-system-libs || die "Configure failed."
}

src_install() {
	src_install
}
