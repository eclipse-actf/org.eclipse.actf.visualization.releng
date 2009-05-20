#!/bin/bash
#====================================================================================
#  Copyright (c) 2008 The Eclipse Foundation and others.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#====================================================================================

if [ -f /opt/ibm/java2-ppc-50/bin/java ]; then
	# We're running on the build server. Configure the environment for there.
	buildRoot=${HOME}/build/root
else
	# running on Desktop.
	buildRoot=${HOME}/eclipse.actf.build
fi

buildDirectory=${buildRoot}/workspace

rm -f ${buildDirectory}/*.*
rm -rf ${buildDirectory}/plugins
rm -rf ${buildDirectory}/features
rm -rf ${buildDirectory}/repository/*
