#!/bin/bash
#====================================================================================
#  Copyright (c) 2008 The Eclipse Foundation and others.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#====================================================================================

	buildRoot=/shared/technology/actf/build/root

buildDirectory=${buildRoot}/workspace

rm -f ${buildDirectory}/*.*
rm -rf ${buildDirectory}/plugins
rm -rf ${buildDirectory}/features
rm -rf ${buildDirectory}/repository/*
rm -rf ${buildDirectory}/scmCache/*
rm -rf /shared/technology/actf/base/eclipse/plugins/*/scripts/scmCache/*

