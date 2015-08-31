# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="Skylable LibreS3 - Amazon S3 compatible server"
HOMEPAGE="http://www.skylable.com/products/libres3"
EGIT_REPO_URI="https://github.com/sx-mirror/libres3.git"
#EGIT_COMMIT="52c83a469395b7c5341b97b5250c9eb91b4b66ab"
EGIT_COMMIT="1.1"

LICENSE="GPL-2 LGPL-2.1 openssl"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-ml/camlp4
	>=dev-ml/findlib-1.5.5
	>dev-lang/ocaml-4
	dev-ml/pcre-ocaml
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
EGIT_CHECKOUT_DIR=${S}

src_configure() {
	./configure --prefix=${D}
}

src_install() {
	src_install

	dodoc ${S}/libres3/README.md
}
