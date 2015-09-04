# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit oasis findlib

DESCRIPTION="Skylable LibreS3 - Amazon S3 compatible server"
HOMEPAGE="http://www.skylable.com/products/libres3"
SRC_URI="http://cdn.skylable.com/source/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1 openssl"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/libpcre
	dev-libs/openssl:0
	dev-ml/camlp4
	>=dev-lang/ocaml-3.12.1
	dev-ml/ocaml-ipaddr
	dev-ml/jsonm
	dev-ml/lwt[react,ssl]
	dev-ml/ocaml-base64
	dev-ml/ocaml-dns
	dev-ml/ocaml-re
	dev-ml/ocaml-ssl
	dev-ml/ocamlnet[cryptokit,httpd,pcre]
	dev-ml/optcomp
	dev-ml/ounit
	dev-ml/pcre-ocaml
	dev-ml/tyxml
	dev-ml/uutf
	dev-ml/xmlm
	net-misc/sx
	sys-devel/make
	sys-libs/zlib
	www-servers/ocsigenserver
"
DEPEND="
	sys-devel/m4
	virtual/pkgconfig
	${RDEPEND}
"

S="${S}/libres3"
