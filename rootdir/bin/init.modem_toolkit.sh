#!/vendor/bin/sh

PROP_LOG_PATH="persist.vendor.log.toolkit.log_path"
PROP_LOG_DIR="vendor.log.toolkit.current_log_dir"
PROP_LOG_PREFIX="persist.vendor.log.toolkit.log_prefix"
PROP_LOG_MASK="vendor.log.toolkit.diag_mask"
PROP_STATUS_DIAG_MDLOGD="persist.vendor.log.toolkit.diag_log_enable"

DEFAULT_LOG_PATH="/data/vendor/logtoolkit/vendor_logs"

toMakeDir=
toChmod=
toRemoveLog=
toSetupQDSS=
toRestoreQDSS=

function print_usage() {
    print_log "$0:"
    print_log "    --mkdir        to make new log directory named by the current time"
    print_log "    --chmod        to allow all files to be readable by system"
    print_log "    --clean        to clean all log files"
    print_log "    --setupQDSS    to remove useless log from QDSS"
    print_log "    --restoreQDSS  to restore settings for QDSS"
}

function print_log {
    /vendor/bin/log -t "ModemToolkit" "$@"
    /vendor/bin/echo "$@"
}

print_log "$0 $1 $2 $3 $4"
# Loop until all parameters are used up
while (( "$#" )); do
    case "$1" in
        --mkdir)
            toMakeDir=true
            shift
            ;;
        --clean)
            toRemoveLog=true
            shift
            ;;
        --setupQDSS)
            toSetupQDSS=true
            shift
            ;;
        --restoreQDSS)
            toRestoreQDSS=true
            shift
            ;;
        --chmod)
            toChmod=true
            shift
            ;;
        *)
            print_usage
            exit
            ;;
    esac
done


LogRoot=`/vendor/bin/getprop $PROP_LOG_PATH`
[ "$LogRoot" == "" ] && LogRoot=$DEFAULT_LOG_PATH

if [[ $toMakeDir ]]; then
    DirNamePrefix=`/vendor/bin/getprop $PROP_LOG_PREFIX`
    if [ ! -z "$DirNamePrefix" ]; then
        DirNamePrefix="${DirNamePrefix}_"
    fi

    DirName=`/vendor/bin/getprop $PROP_LOG_DIR`
    if [[ "$DirName" == "" ]]; then
        DirName=`/vendor/bin/date -u +%Y%m%d-%H%M%S.%s`
        DirName=$DirNamePrefix$DirName
        /vendor/bin/setprop $PROP_LOG_DIR $DirName
    else
        OldTime="`echo $DirName | /vendor/bin/sed 's|^.*\.||'`"
        NowTime="`/vendor/bin/date +%s`"

        TimeDiff=`expr $NowTime - $OldTime`
        print_log "Now $NowTime, Old $OldTime, Diff $TimeDiff"
        if [[ "$TimeDiff" == "" ||  $TimeDiff -lt 0 || $TimeDiff -ge 5 ]]; then
            DirName=`/vendor/bin/date -u +%Y%m%d-%H%M%S.%s`
            DirName=$DirNamePrefix$DirName
            /vendor/bin/setprop $PROP_LOG_DIR $DirName
        fi
    fi

    if [[ -d $LogRoot/$DirName ]]; then
        print_log "$LogRoot/$DirName already exists"
    else
        print_log "`/vendor/bin/mkdir -m 2770 -v -p $LogRoot/$DirName 2>&1`"
    fi

    # Setup log mask for diag logs
    if [[ -f $LogRoot/diag.cfg ]]; then
        /vendor/bin/setprop $PROP_LOG_MASK $LogRoot/$DirName/diag.cfg
        print_log "`/vendor/bin/cp $LogRoot/diag.cfg $LogRoot/$DirName/diag.cfg 2>&1`"
    else
        print_log "Log Mask not found, use the default one"
        /vendor/bin/setprop $PROP_LOG_MASK ""
    fi
fi

if [[ $toRemoveLog ]]; then
    [ `/vendor/bin/getprop $PROP_STATUS_DIAG_MDLOGD` == "true" ] && print_log "$PROP_STATUS_DIAG_MDLOGD is running" && exit

    if [ -d $LogRoot ]; then
        print_log "`/vendor/bin/rm -rf $LogRoot 2>&1`"
        print_log "$LogRoot was removed"
    else
        print_log "$LogRoot doesn't exist"
    fi
fi

if [[ $toSetupQDSS ]]; then
    print_log "reset_source_sink"
    print_log "`echo 1 > /sys/bus/coresight/reset_source_sink`"

    print_log "port_select 0x10000003"
    print_log "`echo 0x10000003 > /sys/bus/coresight/devices/coresight-stm/port_select`"
fi

if [[ $toRestoreQDSS ]]; then
    print_log "port_select 0"
    print_log "`echo 0 > /sys/bus/coresight/devices/coresight-stm/port_select`"
fi

if [[ $toChmod ]]; then
    print_log "`/vendor/bin/find $LogRoot -type d -exec /vendor/bin/chmod g+x {} + 2>&1`"
    print_log "`/vendor/bin/chmod -R g+rw $LogRoot 2>&1`"
fi
