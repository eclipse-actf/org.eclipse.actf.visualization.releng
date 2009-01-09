#!/bin/bash
#====================================================================================
#  Copyright (c) 2008 The Eclipse Foundation and others.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#====================================================================================

BUILD_DATE=`date +%Y%m%d`
BUILD_TIME=`date +%H%M`
TIMESTAMP=${BUILD_DATE}${BUILD_TIME}

if [ -f /opt/ibm/java2-ppc-50/bin/java ]; then
	# We're running on the build server. Configure the environment for there.
	java=/opt/ibm/java2-ppc-50/bin/java
	sharedDir=/shared/technology/actf
	base=${sharedDir}/base/eclipse-SDK-3.4.1-win32
	eclipseRoot=${base}/eclipse
	configurationFolder=${HOME}/build/org.eclipse.actf.visualization.releng
	buildRoot=${HOME}/build/root
	updateSite=${buildRoot}/repository
else
	# running on Desktop. 
	java=java
	sharedDir=${HOME}
	base=${HOME}
	eclipseRoot=${base}/eclipse
	configurationFolder=${HOME}/build/org.eclipse.actf.visualization.releng
	buildRoot=${HOME}/eclipse.actf.build
	updateSite=${buildRoot}/repository
fi

# Find the launcher JAR and PDE Build Plugin directory for the current platform.
launcherJar=`find ${eclipseRoot} -type f -name 'org.eclipse.equinox.launcher_*.jar' -print0`
pdeBuildPlugin=`find ${eclipseRoot} -type d -name 'org.eclipse.pde.build_*' -print0`

tempDir=${buildRoot}/temp
buildDirectory=${buildRoot}/workspace
prereqDir=/pre-req

# What feature are we building?
featureId=org.eclipse.actf.visualization

${java} -jar ${launcherJar} \
	-application org.eclipse.ant.core.antRunner \
	-buildfile ${pdeBuildPlugin}/scripts/build.xml \
	-DbuildDirectory=${buildDirectory} \
	-Dbuilder=${configurationFolder} \
        -DbuildId=${TIMESTAMP} \
        -DbuildType=I \
        -Dtimestamp=${TIMESTAMP} \
	-Dbase=${base} \
        -DupdateSite=${updateSite} \
	-DtempDir=${tempDir} \
	-DfeatureId=${featureId} \
	-DlauncherJar=${launcherJar} \
 	-DOOO_HOME=${prereqDir}/OOo

