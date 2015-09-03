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
	dev-libs/libpcre
	dev-libs/openssl:0
	dev-ml/camlp4
	>=dev-ml/findlib-1.5.5
	>=dev-lang/ocaml-3.12.1
	dev-ml/ocaml-ipaddr
	dev-ml/jsonm
	dev-ml/ocamlnet[cryptokit,httpd,pcre]
	dev-ml/ocaml-base64
	dev-ml/ocaml-re
	dev-ml/ocaml-ssl
	dev-ml/odns
	dev-ml/optcomp
	dev-ml/ounit
	dev-ml/pcre-ocaml
	dev-ml/react
	dev-ml/tyxml
	dev-ml/uutf
	dev-ml/xmlm
	sys-devel/m4
	sys-devel/make
	sys-libs/zlib
	virtual/pkgconfig
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
EGIT_CHECKOUT_DIR=${S}

src_configure() {
	./configure --prefix=/usr/
}

