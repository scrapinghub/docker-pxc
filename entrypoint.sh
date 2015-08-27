#!/bin/bash

if [[ ${PXC_CFGFILE} ]]; then
  cp ${PXC_CFGFILE} /etc/mysql/conf.d
fi

PIDFILE=${PIDFILE:-/var/run/mysqld/mysqld.pid}
LOGFILE=${LOGFILE:-/var/log/mysql/error.log}

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
