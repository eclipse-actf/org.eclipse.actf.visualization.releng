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
BUILD_TYPE=I

if [ -f /opt/ibm/java2-ppc-50/bin/java ]; then
	# We're running on the build server. Configure the environment for there.
	java=/opt/ibm/java2-ppc-50/bin/java
	sharedDir=/shared/technology/actf
	base=${sharedDir}/base
	eclipseRoot=${base}/eclipse
	configurationFolder=${HOME}/build/org.eclipse.actf.visualization.releng
	buildRoot=${HOME}/build/root
else
	# running on Desktop. 
	java=java
	sharedDir=${HOME}
	base=${HOME}
	eclipseRoot=${base}/eclipse
	configurationFolder=${HOME}/build/org.eclipse.actf.visualization.releng
	buildRoot=${HOME}/eclipse.actf.build
fi

# Find the launcher JAR and PDE Build Plugin directory for the current platform.
launcherJar=`find ${eclipseRoot} -type f -name 'org.eclipse.equinox.launcher_*.jar' -print0`
pdeBuildPlugin=`find ${eclipseRoot} -type d -name 'org.eclipse.pde.build_*' -print0`

tempDir=${buildRoot}/temp
buildDirectory=${buildRoot}/workspace
prereqDir=${sharedDir}/pre-req
updateSite=${buildDirectory}/repository


# What feature are we building?
featureId=org.eclipse.actf.visualization.sdk

${java} -jar ${launcherJar} \
	-application org.eclipse.ant.core.antRunner \
	-buildfile ${pdeBuildPlugin}/scripts/build.xml \
	-DbuildDirectory=${buildDirectory} \
	-Dbuilder=${configurationFolder} \
	-DbuildId=${TIMESTAMP} \
	-DbuildType=${BUILD_TYPE} \
	-Dtimestamp=${TIMESTAMP} \
	-Dbase=${base} \
	-DupdateSite=${updateSite} \
	-DtempDir=${tempDir} \
	-DfeatureId=${featureId} \
	-DlauncherJar=${launcherJar} \
	-DOOO_HOME=${prereqDir}/OOo

${java} -jar ${launcherJar} \
   -application org.eclipse.equinox.p2.metadata.generator.EclipseGenerator \
   -updateSite ${updateSite}/ \
   -site file:${buildDirectory}/repository/site.xml \
   -metadataRepository file:${updateSite}/ \
   -metadataRepositoryName "ACTF Update Site" \
   -artifactRepository file:${updateSite}/ \
   -artifactRepositoryName "ACTF Artifacts" \
   -reusePack200Files \
   -compress \
   -noDefaultIUs \
   -vmargs -Xmx256m