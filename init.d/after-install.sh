#!/bin/bash
# shim
# package post installation script
# This script is run by the package management system after the shim
# package is installed.

/opt/scidb/XXX_SCIDB_VER_XXX/shim/setup-conf.sh

if test -n "$(which systemctl 2>/dev/null)"; then
# SystemD
  cp /opt/scidb/XXX_SCIDB_VER_XXX/shim/shimsvc.service /lib/systemd/system/shimsvc.service
  systemctl daemon-reload
  systemctl enable shim
  systemctl start shim
elif test -n "$(which update-rc.d 2>/dev/null)"; then
# Ubuntu
  cp /opt/scidb/XXX_SCIDB_VER_XXX/shim/shimsvc.initd /etc/init.d/shimsvc
  chmod 0755 /etc/init.d/shimsvc
  update-rc.d shimsvc defaults
  /etc/init.d/shimsvc start
elif test -n "$(which chkconfig 2>/dev/null)"; then
# RHEL sysV
  cp /opt/scidb/XXX_SCIDB_VER_XXX/shim/shimsvc.initd /etc/init.d/shimsvc
  chmod 0755 /etc/init.d/shimsvc
  chkconfig --add shimsvc && chkconfig shimsvc on
  /etc/init.d/shimsvc start
fi
