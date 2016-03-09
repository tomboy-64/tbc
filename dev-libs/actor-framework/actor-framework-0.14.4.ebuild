# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils cmake-multilib flag-o-matic

DESCRIPTION="An Open Source Implementation of the Actor Model in C++"
HOMEPAGE="http://actor-framework.org/"
SRC_URI="https://github.com/actor-framework/actor-framework/archive/${PV}.tar.gz"

LICENSE="Boost-1.0 BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="boost debug doc examples +mem_management opencl +riac static test"

DEPEND="${RDEPEND}
		app-doc/doxygen
		doc? ( dev-texlive/texlive-latex 
			dev-tex/hevea )
"
RDEPEND="boost? ( dev-libs/boost[${MULTILIB_USEDEP}] )
		net-misc/curl[${MULTILIB_USEDEP}]
		opencl? ( virtual/opencl[${MULTILIB_USEDEP}] )
"

CXXFLAGS="${CXXFLAGS} -std=c++11 -Wextra -Wall -pedantic"
CFLAGS="${CFLAGS} -std=c11 -Wextra -Wall -pedantic"

src_prepare() {
	find "${S}" -name CMakeLists.txt \
		-exec sed -i 's#\(install(.* DESTINATION \)lib#\1${LIBRARY_OUTPUT_PATH}#g' \{\} \; \
		|| die
	rm examples/CMakeLists.txt || die

	cmake-utils_src_prepare
}

multilib_src_configure() {
	mycmakeargs+=(
		-DCAF_NO_EXAMPLES=ON
		-DCAF_USE_ASIO=$(usex boost)
		-DCAF_LOG_LEVEL=$(usex debug 3 0)
		-DCAF_ENABLE_RUNTIME_CHECKS=$(usex debug)
		-DCAF_ENABLE_ADDRESS_SANITIZER=$(usex debug)
		-DCAF_NO_MEM_MANAGEMENT=$(usex mem_management OFF ON)
		-DCAF_NO_OPENCL=$(usex opencl OFF ON)
		-DCAF_BUILD_STATIC=$(usex static)
		-DCAF_NO_UNIT_TESTS=$(usex test OFF ON )
		-DLIBRARY_OUTPUT_PATH="$(get_libdir)"
	)

	cmake-utils_src_configure
}

multilib_src_compile() {
	cmake-utils_src_compile
	
	if use doc; then
		cd "${S}/manual/build-pdf"
		make
		cd "${S}/manual/build-html"
		make
	fi
}

multilib_src_install() {
	DOCS=( README.md )
	use examples && DOCS+=( "${S}/examples" )
	use doc && HTML_DOCS+=( "${S}/manual/build-html/manual.html" )
	use doc && DOCS+=( "${S}/manual/build-pdf/manual.pdf" )

	cmake-utils_src_install
}
