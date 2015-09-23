# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils java-pkg-2 java-ant-2 versionator

SLOT="0"

#MY_PN="intellij-community"
MY_PN="idea"

RESTRICT="strip"
QA_TEXTRELS="opt/idea-${PV}/bin/libbreakgen.so"

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
	dev-java/commons-httpclient:3
	dev-java/eclipse-ecj:4.4
	dev-java/freemarker:2.3
	dev-java/guava:17
	dev-java/hamcrest-core:1.3
	dev-java/hamcrest-library:1.3
	dev-java/commons-net:0
	dev-java/guava:18
	dev-java/gson:2.2.2
	dev-java/jcip-annotations:0
	dev-java/jgoodies-common:0
	dev-java/jgoodies-looks:2.0
	dev-java/jna:0
	dev-java/jsch:0
	dev-java/jsr173:0
	dev-java/jsr305:0
	dev-java/jaxen:1.1
	dev-java/jzlib:1.1
	dev-java/kryo:2
	dev-java/log4j:0
	dev-java/microba:0
	dev-java/miglayout:0
	dev-java/minlog:0
	dev-java/nanoxml:0
	dev-java/reflectasm:0
	dev-java/nekohtml:0
	dev-libs/protobuf:0[java]
	dev-java/reflectasm:0
	dev-java/xml-commons-resolver:0
	dev-java/rhino:1.7
	dev-java/slf4j-api:0
	dev-java/slf4j-log4j12:0
	dev-java/slf4j-simple:0
	|| ( dev-java/jython:2.7 dev-java/jython:2.5 )
	dev-java/jflex:0
	dev-java/xpp3:0
	dev-java/commons-io:1
	dev-java/commons-logging:0
	dev-java/wsdl4j:0
	dev-java/commons-discovery:0
	dev-java/iso-relax:0
"
DEPEND="
	dev-java/antlr:0[java]
	dev-java/commons-cli:1
	dev-java/easymock:3.2
	dev-java/easymock-classextension:3.2
	dev-java/hamcrest-core:0
	dev-java/hamcrest-library:0
	dev-java/jarjar:1
	dev-java/objenesis:0
	dev-java/jansi:0
	dev-java/jline:0
	dev-java/jaxb:2
	>=virtual/jdk-1.7
	${CDEPEND}
	"
RDEPEND="
	>=virtual/jre-1.7
	${CDEPEND}
"
# Notes:
# - saxon depends on jdom:1.0 - don't we want jdom:0? be it as may be, we don't have the right saxon - somehow.

S="${WORKDIR}/intellij-community-${PV}"

EANT_BUILD_TARGET="build"
EANT_GENTOO_CLASSPATH=""
JAVA_REWRITE_CLASSPATH=1

java_prepare() {
	local dts="
		./lib/groovy/lib/commons-cli-1.2.jar
		./build/lib/commons-cli-1.2.jar
		./build/lib/jarjar-1.0.jar
		./lib/dev/easymockclassextension.jar
		./lib/dev/easymock.jar
		./lib/hamcrest-library-1.3.jar
		./lib/hamcrest-core-1.3.jar
		./lib/dev/hamcrest-library-1.1.jar
		./lib/dev/hamcrest-core-1.1.jar
		./lib/objenesis-1.2.jar
		./lib/dev/objenesis-1.0.jar
		./lib/groovy/lib/antlr-2.7.7.jar
		./plugins/svn4idea/lib/antlr.jar
		./lib/groovy/lib/jansi-1.6.jar
		./lib/groovy/lib/jline-1.0.jar
		./lib/jaxb-impl.jar
		./lib/jaxb-api.jar
		./lib/jaxen-1.1.3.jar
		./lib/ant/lib/ant.jar
		./lib/ant/lib/ant-testutil.jar
		./lib/ant/lib/ant-swing.jar
		./lib/ant/lib/ant-netrexx.jar
		./lib/ant/lib/ant-launcher.jar
		./lib/ant/lib/ant-junit4.jar
		./lib/ant/lib/ant-junit.jar
		./lib/ant/lib/ant-jsch.jar
		./lib/ant/lib/ant-jmf.jar
		./lib/ant/lib/ant-jdepend.jar
		./lib/ant/lib/ant-javamail.jar
		./lib/ant/lib/ant-jai.jar
		./lib/ant/lib/ant-commons-net.jar
		./lib/ant/lib/ant-commons-logging.jar
		./lib/ant/lib/ant-apache-xalan2.jar
		./lib/ant/lib/ant-apache-resolver.jar
		./lib/ant/lib/ant-apache-regexp.jar
		./lib/ant/lib/ant-apache-oro.jar
		./lib/ant/lib/ant-apache-log4j.jar
		./lib/ant/lib/ant-apache-bsf.jar
		./lib/ant/lib/ant-apache-bcel.jar
		./lib/ant/lib/ant-antlr.jar
		./lib/asm.jar
		./lib/asm-commons.jar
		./lib/groovy/lib/asm-4.0.jar
		./lib/commons-net-3.3.jar
		./lib/src/commons-net-3.3-sources.jar
		./lib/commons-logging-1.1.3.jar
		./lib/ecj-4.4.jar
		./lib/freemarker.jar
		./lib/guava-17.0.jar
		./lib/src/guava-17.0-sources.jar
		./plugins/maven/maven32-server-impl/lib/maven32/lib/guava-18.0.jar
		./lib/gson-2.3.jar
		./lib/src/gson-2.3-sources.jar
		./lib/jcip-annotations.jar
		./lib/jgoodies-looks-2.4.2.jar
		./lib/jgoodies-common-1.2.1.jar
		./lib/jsch-0.1.51.jar
		./lib/jsr173_1.0_api.jar
		./plugins/gradle/lib/jsr305-1.3.9.jar
		./lib/jsr305.jar
		./lib/src/jzlib-1.1.1.zip
		./lib/jzlib-1.1.1.jar
		./lib/src/kryo-src.zip
		./lib/kryo-2.22.jar
		./lib/src/log4j.zip
		./lib/src/microba-src.zip
		./lib/microba.jar
		./lib/src/miglayout-sources.jar
		./lib/miglayout-swing.jar
		./lib/minlog-1.2.jar
		./lib/src/nanoxml.zip
		./lib/nanoxml-2.2.3.jar
		./lib/nekohtml-1.9.14.jar
		./lib/protobuf-2.5.0.jar
		./lib/resolver.jar
		./lib/rhino-js-1_7R4.jar
		./lib/slf4j-api-1.7.10.jar
		./lib/slf4j-log4j12-1.7.10.jar
		./plugins/maven/maven32-server-impl/lib/maven32/lib/slf4j-api-1.7.5.jar
		./plugins/maven/maven32-server-impl/lib/maven32/lib/slf4j-simple-1.7.5.jar
		./lib/src/xpp3-1.1.4-min-src.jar
		./lib/xpp3-1.1.4-min.jar
		./python/ipnb/lib/commons-io-1.4.jar
		./plugins/maven/maven32-server-impl/lib/maven32/lib/commons-io-2.2.jar
		./plugins/maven/maven30-server-impl/lib/maven3/lib/commons-io-2.2.jar
		./plugins/gradle/lib/commons-io-1.4.jar
		./plugins/gradle/lib/jna-3.2.7.jar
		./lib/jna.jar
		./lib/src/jna-src.zip
		./plugins/tasks/tasks-core/lib/wsdl4j-1.4.jar
		./lib/jna-utils.jar
	    ./plugins/tasks/tasks-core/lib/commons-discovery-0.4.jar
	    ./xml/relaxng/lib/isorelax.jar
	"
	for i in ${dts}; do
		java-pkg_rm_files ${i} || die
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
	java-pkg_jar-from --build-only --into "${S}/lib" objenesis objenesis.jar objenesis-1.2.jar
	java-pkg_jar-from --build-only --into "${S}/lib/dev" objenesis objenesis.jar objenesis-1.0.jar
	java-pkg_jar-from --build-only --into "${S}/lib/groovy/lib" antlr
	#java-pkg_jar-from --build-only --into "${S}/lib/dev" mockobjects mockobjects-core.jar mockobjects-core-0.09.jar # old, broken, in my case, barfing at gnu-classpath
	java-pkg_jar-from --build-only --into "${S}/lib/groovy/lib" jansi
	java-pkg_jar-from --build-only --into "${S}/lib/groovy/lib" jline
	java-pkg_jar-from --build-only --into "${S}/lib" jaxb-2
	java-pkg_jar-from --build-only --into "${S}/lib" reflectasm
	java-pkg_jar-from --build-only --into "${S}/plugins/maven/maven32-server-impl/lib/maven32/lib" slf4j-api
	java-pkg_jar-from --build-only --into "${S}/plugins/maven/maven32-server-impl/lib/maven32/lib" slf4j-simple slf4j-simple.jar slf4j-simple-1.7.5.jar
	java-pkg_jar-from --build-only --into "${S}/python/lib" jython-2.7
	java-pkg_jar-from --build-only --into "${S}/tools/lexer/jflex-1.4/lib" jflex

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
	java-pkg_jar-from --into "${S}/lib" commons-net # they have 3.3, we have 3.2
	java-pkg_jar-from --into "${S}/lib" commons-logging commons-logging.jar commons-logging-1.1.3.jar
	#java-pkg_jar-from --into "${S}/lib/" commons-httpclient-3 # they made the effort to rename it to "patched"; both are 3.1
	#java-pkg_jar-from --into "${S}/lib/" commons-codec # they have 1.9, we have 1.7; our's is too old
	java-pkg_jar-from --into "${S}/lib" hamcrest-core-1.3 hamcrest-core.jar hamcrest-core-1.3.jar
	java-pkg_jar-from --into "${S}/lib" hamcrest-library-1.3 hamcrest-library.jar hamcrest-library-1.3.jar
	java-pkg_jar-from --into "${S}/lib" eclipse-ecj-4.4
	java-pkg_jar-from --into "${S}/lib" freemarker-2.3
	java-pkg_jar-from --into "${S}/lib" guava-17 guava.jar guava-17.0.jar
	java-pkg_jar-from --into "${S}/plugins/maven/maven32-server-impl/lib/maven32/lib" guava-18 guava.jar guava-18.0.jar
	java-pkg_jar-from --into "${S}/plugins/gradle/lib" guava-17 guava.jar guava-jdk5-17.0.jar # do we really wanna pose as jdk5?
	java-pkg_jar-from --into "${S}/lib" gson-2.2.2 gson.jar gson-2.3.jar
	java-pkg_jar-from --into "${S}/lib" jcip-annotations
	java-pkg_jar-from --into "${S}/lib" jgoodies-common
	#java-pkg_jar-from --into "${S}/lib" jgoodies-forms
	java-pkg_jar-from --into "${S}/lib" jgoodies-looks-2.0 looks.jar jgoodies-looks-2.4.2.jar
	java-pkg_jar-from --into "${S}/lib" jna
	java-pkg_jar-from --into "${S}/plugins/gradle/lib" jna
	java-pkg_jar-from --into "${S}/lib" jsch
	java-pkg_jar-from --into "${S}/lib" jsr173
	java-pkg_jar-from --into "${S}/lib" jsr305
	java-pkg_jar-from --into "${S}/plugins/gradle/lib" jsr305
	java-pkg_jar-from --into "${S}/lib" jaxen-1.1 jaxen.jar jaxen-1.1.3.jar
	java-pkg_jar-from --into "${S}/lib" jzlib-1.1
	java-pkg_jar-from --into "${S}/lib" kryo-2 kryo.jar kryo-2.22.jar
	#java-pkg_jar-from --into "${S}/lib" junit
	#java-pkg_jar-from --into "${S}/lib" junit-4 junit.jar junit-4.12.jar
	#java-pkg_jar-from --into "${S}/lib" log4j # somehow our version is incompatible?
	java-pkg_jar-from --into "${S}/lib" microba
	java-pkg_jar-from --into "${S}/lib" miglayout miglayout.jar miglayout-swing.jar
	java-pkg_jar-from --into "${S}/lib" minlog minlog.jar minlog-1.2.jar
	java-pkg_jar-from --into "${S}/lib" nanoxml nanoxml.jar nanoxml-2.2.3.jar
	java-pkg_jar-from --into "${S}/lib" nekohtml nekohtml.jar nekohtml-1.9.14.jar
	#java-pkg_jar-from --into "${S}/lib" picocontainer-1 # weird stuffs. just try it man, i dare ya!
	java-pkg_jar-from --into "${S}/lib" protobuf protobuf.jar protobuf-2.5.0.jar
	java-pkg_jar-from --into "${S}/lib" reflectasm
	java-pkg_jar-from --into "${S}/lib" xml-commons-resolver xml-commons-resolver.jar resolver.jar
	java-pkg_jar-from --into "${S}/lib" rhino-1.7 js.jar rhino-js-1_7R4.jar
	java-pkg_jar-from --into "${S}/lib" slf4j-api slf4j-api.jar slf4j-api-1.7.10.jar
	java-pkg_jar-from --into "${S}/lib" slf4j-log4j12 slf4j-log4j12.jar slf4j-log4j12-1.7.10.jar
	#java-pkg_jar-from --into "${S}/lib" snappy-1.0 snappy.jar snappy-in-java-0.3.1.jar # they use some random implementation by iq80?
	#java-pkg_jar-from --into "${S}/lib" trove trove.jar trove4j.jar # apparently it's trove:0 - but J00 DOIN WEIRD STUFFZ, M8!
	java-pkg_jar-from --into "${S}/lib" xpp3 xpp3.jar xpp3-1.1.4-min.jar
	#java-pkg_jar-from --into "${S}/lib" velocity # somehow this contains classes from commons-collections
	#java-pkg_jar-from --into "${S}/lib" swingx-1.6 swingx.jar swingx-core-1.6.2.jar # really needs 1.6.2 - our 1.6.4 has different jar structure
	#java-pkg_jar-from --into "${S}/lib" xbeans-2 xbeans.jar xbean.jar # jetbrains-pimped
	#java-pkg_jar-from --into "${S}/lib" xerces-1.3
	#java-pkg_jar-from --into "${S}/lib" xerces-2 # something in between needed
	#java-pkg_jar-from --into "${S}/lib" xmlrpc-3 xmlrpc-client.jar xmlrpc-2.0.jar # they want xmlrpc:2 - which is not in the tree anymore
	#java-pkg_jar-from --into "${S}/lib" xstream xstream.jar xstream-1.4.3.jar # they want 1.4.3 - our's is too old
	#java-pkg_jar-from --into "${S}/plugins/devkit/lib" dtdparser-1.21 dtdparser.jar dtdparser-113.jar # custom jetbrains version
	java-pkg_jar-from --into "${S}/python/ipnb/lib" commons-io-1
	java-pkg_jar-from --into "${S}/plugins/maven/maven32-server-impl/lib/maven32/lib" commons-io-1
	java-pkg_jar-from --into "${S}/plugins/maven/maven30-server-impl/lib/maven3/lib" commons-io-1
	java-pkg_jar-from --into "${S}/plugins/gradle/lib" commons-io-1
	java-pkg_jar-from --into "${S}/plugins/gradle/lib" jna jna.jar jna-3.2.7.jar
	java-pkg_jar-from --into "${S}/lib" jna
	java-pkg_jar-from --into "${S}/lib" jna platform.jar jna-utils.jar
	#java-pkg_jar-from --into "${S}/plugins/testng/lib" testng # wrong version
	java-pkg_jar-from --into "${S}/plugins/tasks/tasks-core/lib" wsdl4j wsdl4j.jar wsdl4j-1.4.jar
	java-pkg_jar-from --into "${S}/plugins/tasks/tasks-core/lib" commons-discovery
	java-pkg_jar-from --into "${S}/xml/relaxng/lib" iso-relax
	#java-pkg_jar-from --into "${S}/xml/relaxng/lib" nokogiri jing.jar # nokogiri doesn't register with java. who needs ruby anyway?
	#java-pkg_jar-from --into "${S}/xml/relaxng/lib" trang-core.jar # crappy crap's not building

	# cucumber-{java,core} and gherkin need java-packages. seriuosly, who wants ruby?
	# groovy is way outdated, wanting 2.0.4 and 2.3.9
}

src_install() {
	local final_dest="/opt/${MY_PN}-${PV}"
	local destination="${ED}/${final_dest}"
	local tarball="ideaIC-${PV}.SNAPSHOT.tar.gz"
	local tardir=$(tar -tzf ${S}/out/artifacts/${tarball} | head -n1 | awk -F / '{ print $1 }')

	mkdir -p "${destination}" || die "Can't create directory: ${dir}"
	cd "${destination}" || die "Directory not there: ${dir}"
	tar xzvf "${S}/out/artifacts/${tarball}" --transform 's/\/\?'${tardir}'\///' || die "Moving idea to image directory unsuccessful."
	fperms 755 "${final_dest}/bin/idea.sh" "${final_dest}/bin/fsnotifier" "${final_dest}/bin/fsnotifier64"

	java-pkg_dolauncher "idea_launcher" --java_args "-XX:ErrorFile=\$HOME/java_error_in_IDEA_%p.log -Djb.restart.code=88 -Didea.paths.selector=IdeaIC14" --main "com.intellij.idea.Main"
	make_desktop_entry "/usr/bin/idea_launcher" "IntelliJ IDEA" "/opt/idea-141/bin/idea.png"

	# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	mkdir -p "${ED}/etc/sysctl.d/"
	echo "fs.inotify.max_user_watches = 524288" > "${ED}/etc/sysctl.d/30-idea-inotify-watches.conf"
}
