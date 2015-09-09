# Copyright open-overlay 2015 by Alex

EAPI=5
inherit eutils java-pkg-2 java-ant-2 versionator

SLOT="0"

MY_PN="intellij-community"

RESTRICT="strip"
QA_TEXTRELS="opt/${P}/bin/libbreakgen.so"

DESCRIPTION="IntelliJ IDEA is an intelligent Java IDE (Community Edition)"
HOMEPAGE="http://jetbrains.com/idea/"
SRC_URI="https://github.com/JetBrains/intellij-community/archive/141.zip"
LICENSE="Apache-2.0"
IUSE=""
KEYWORDS="~amd64 ~x86"

CDEPEND="
	dev-java/ant-antlr:0
	dev-java/ant-apache-bcel:0
	dev-java/ant-apache-bsf:0
	dev-java/ant-apache-log4j:0
	dev-java/ant-apache-oro:0
	dev-java/ant-apache-regexp:0
	dev-java/ant-apache-resolver:0
	dev-java/ant-apache-xalan2:0
	dev-java/ant-commons-logging:0
	dev-java/ant-commons-net:0
	dev-java/ant-core:0
	dev-java/ant-jai:0
	dev-java/ant-javamail:0
	dev-java/ant-jdepend:0
	dev-java/ant-jmf:0
	dev-java/ant-jsch:0
	dev-java/ant-junit:0
	dev-java/ant-junit4:0
	dev-java/ant-swing:0
	dev-java/ant-testutil:0
	dev-java/asm:3
	dev-java/asm:4
	dev-java/cglib:3
	dev-java/commons-commons:0
	dev-java/commons-logging:0
	dev-java/commons-httpclient:3
	dev-java/eclipse-ecj:4.4
	dev-java/freemarker:2.3
	dev-java/hamcrest-core:1.3
	dev-java/hamcrest-library:1.3
"
DEPEND="
	dev-java/antlr:0[java]
	dev-java/commons-cli:1
	dev-java/easymock:3.2
	dev-java/easymock-classextension:3.2
	dev-java/hamcrest-core:0
	dev-java/hamcrest-library:0
	dev-java/jarjar:1
	>=virtual/jdk-1.7
	${CDEPEND}
	"
RDEPEND="
	>=virtual/jre-1.7
	${CDEPEND}
"
# Notes:
# - saxon depends on jdom:1.0 - don't we want jdom:0? be it as may be, we don't have the right saxon - somehow.

S="${WORKDIR}/${MY_PN}-${PV}"

EANT_BUILD_TARGET="build"
EANT_GENTOO_CLASSPATH=""
JAVA_REWRITE_CLASSPATH=1

java_prepare() {
	local dts="
		./build/lib/commons-cli-1.2.jar
		./lib/groovy/lib/commons-cli-1.2.jar
		./build/lib/jarjar-1.0.jar
		./lib/dev/easymockclassextension.jar
		./lib/dev/easymock.jar
		./lib/dev/hamcrest-core-1.1.jar
		./lib/dev/hamcrest-library-1.1.jar
		./lib/objenesis-1.2.jar
		./lib/dev/objenesis-1.0.jar
		./lib/groovy/lib/antlr-2.7.7.jar
	"	
	for i in $dts; do
		java-pkg_rm_files ${i} || die "wanted to rm ${i} but couldn't find it"
	done
	java-pkg_jar-from --build-only --into "${S}/build/lib" commons-cli-1
	java-pkg_jar-from --build-only --into "${S}/lib/groovy/lib" commons-cli-1
	java-pkg_jar-from --build-only --into "${S}/build/lib" jarjar-1 # jb's file has util -> ext_util and weird asm built in?
	java-pkg_jar-from --build-only --into "${S}/lib/dev" easymock-3.2
	java-pkg_jar-from --build-only --into "${S}/lib/dev" easymock-classextension-3.2
	java-pkg_jar-from --build-only --into "${S}/lib/dev" hamcrest-core hamcrest-core.jar hamcrest-core-1.1.jar
	java-pkg_jar-from --build-only --into "${S}/lib/dev" hamcrest-library hamcrest-library.jar hamcrest-library-1.1.jar
	#java-pkg_jar-from --build-only --into "${S}/lib/dev" jmock-1.0 jmock.jar jmock-1.jar # since those are only build-deps i'm not gonna replace them.
	#java-pkg_jar-from --build-only --into "${S}/lib/dev" jmock-2 jmock.jar jmock-2.jar
	java-pkg_jar-from --build-only --into "${S}/lib" objenesis
	java-pkg_jar-from --build-only --into "${S}/lib/dev" objenesis
	java-pkg_jar-from --build-only --into "${S}/lib/groovy/lib" antlr

	local dts="
		./lib/ant/lib/ant.jar
		./lib/ant/lib/ant-launcher.jar
		./lib/ant/lib/ant-antlr.jar
		./lib/ant/lib/ant-apache-bcel.jar
		./lib/ant/lib/ant-apache-bsf.jar
		./lib/ant/lib/ant-apache-log4j.jar
		./lib/ant/lib/ant-apache-oro.jar
		./lib/ant/lib/ant-apache-regexp.jar
		./lib/ant/lib/ant-apache-resolver.jar
		./lib/ant/lib/ant-apache-xalan2.jar
		./lib/ant/lib/ant-commons-logging.jar
		./lib/ant/lib/ant-commons-net.jar
		./lib/ant/lib/ant-jai.jar
		./lib/ant/lib/ant-javamail.jar
		./lib/ant/lib/ant-jdepend.jar
		./lib/ant/lib/ant-jmf.jar
		./lib/ant/lib/ant-jsch.jar
		./lib/ant/lib/ant-junit.jar
		./lib/ant/lib/ant-junit4.jar
		./lib/ant/lib/ant-swing.jar
		./lib/ant/lib/ant-testutil.jar
		./lib/groovy/lib/asm-4.0.jar
		./lib/asm.jar
		./lib/asm-commons.jar
		./lib/commons-net-3.3.jar
		./lib/commons-logging-1.1.3.jar
		./lib/hamcrest-core-1.3.jar
		./lib/hamcrest-library-1.3.jar
		./lib/ecj-4.4.jar
		./lib/freemarker.jar
	"
	for i in ${dts}; do
		java-pkg_rm_files ${i} || die "wanted to rm ${i} but couldn't find it"
	done
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-core ant.jar
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-core ant-launcher.jar
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-antlr
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-apache-bcel
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-apache-bsf
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-apache-log4j
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-apache-oro
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-apache-regexp
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-apache-resolver
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-apache-xalan2
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-commons-logging
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-commons-net
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-jai
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-javamail
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-jdepend
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-jmf
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-jsch
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-junit
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-junit4
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-swing
	java-pkg_jar-from --into "${S}/lib/ant/lib" ant-testutil
	java-pkg_jar-from --into "${S}/lib" asm-3 asm.jar
	java-pkg_jar-from --into "${S}/lib" asm-3 asm-commons.jar
	java-pkg_jar-from --into "${S}/lib/groovy/lib" asm-4 asm.jar asm-4.0.jar
	#java-pkg_jar-from --into "${S}/lib/" cglib-3 cglib.jar cglib-2.2.2.jar # our's is too new.
	java-pkg_jar-from --into "${S}/lib/" commons-net # they have 3.3, we have 3.2
	java-pkg_jar-from --into "${S}/lib/" commons-logging
	#java-pkg_jar-from --into "${S}/lib/" commons-httpclient-3 # they made the effort to rename it to "patched"; both are 3.1
	#java-pkg_jar-from --into "${S}/lib/" commons-codec # they have 1.9, we have 1.7; our's is too old
	java-pkg_jar-from --into "${S}/lib" hamcrest-core-1.3 hamcrest-core.jar hamcrest-core-1.3.jar
	java-pkg_jar-from --into "${S}/lib" hamcrest-library-1.3 hamcrest-library.jar hamcrest-library-1.3.jar
	java-pkg_jar-from --into "${S}/lib/" eclipse-ecj-4.4
	java-pkg_jar-from --into "${S}/lib/" freemarker-2.3
	
	# cucumber{,-core} and gherkin need java-packages. who wants ruby?
	# groovy is way outdated, wanting 2.0.4 and 2.3.9
}

#java_unpack() {
#	java-ant_rewrite-classpath
#}

#src_install() {
#	local dir="/opt/${PN}"
#
#	insinto "${dir}"
#	doins -r *
#	fperms 755 "${dir}/bin/${MY_PN}.sh" "${dir}/bin/fsnotifier" "${dir}/bin/fsnotifier64"
#
#	newicon "bin/idea.png" "${PN}.png"
#	make_wrapper ${PN} ${dir}/bin/${MY_PN}.sh
#	make_desktop_entry ${PN} "IntelliJ IDEA(Community Edition)" ${PN} "Development;IDE"
#}
