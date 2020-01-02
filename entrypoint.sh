#!/bin/bash

if [[ ${PXC_CFGFILE} ]]; then
  cp -v ${PXC_CFGFILE} /etc/mysql/percona-xtradb-cluster.conf.d/
fi

PIDFILE=${PIDFILE:-/var/run/mysqld/mysqld.pid}
LOGFILE=${LOGFILE:-/var/log/pxc/*.log}

case ${1} in
  start|bootstrap-pxc)
    /etc/init.d/mysql ${1}
    sleep 5
    tail -f $LOGFILE --pid=$(cat $PIDFILE)
    ;;
  *)
    $*
    ;;
esac
