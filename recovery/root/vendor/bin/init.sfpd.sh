#!/vendor/bin/sh

function create_symlink {
    sfpd_loc=$1
    persist_loc=$2

    exists = $(test -e ${sfpd_loc})
    if [ $exists -eq 1 ]; then
        return
    fi

    ln -sf ${sfpd_loc} ${persist_loc}
}

function set_ownership {
    user=$1
    group=$2
    res=$3
    chown $user:$group $res
}

function set_perms() {
    #Usage set_perms <filename> <ownership> <permission>
    chown -h $2 $1
    chmod $3 $1
}

function copy_sensor_files() {
    sfpd_loc=$1
    persist_loc=$2

    cp ${sfpd_loc} ${persist_loc}
    set_perms ${persist_loc} system.system 0660
}

function copy_drm_keys() {
    src=$1
    dst=$2

    current=`pwd`
    cd $src
    for d in */ ; do
        d=${d%*/}
        if [ ! -d $dst/$d ]; then
            cp -r $d $dst
            break
        fi;

        for f in $d/*
        do
            remote_file=$dst/$f
            if [ ! -f $remote_file ]
            then
                cp $f $remote_file
            fi
        done
    done
    cd $current
}

# Copy Widevine, Attestation, WLAN, BT, Sensors
if [ "$#" -eq 1 ] && [ "$1" == "early" ]; then
log -t init.sfpd.sh "Copying after early mount"
# Widevine
copy_drm_keys /vendor/sfpd/widevine /mnt/vendor/persist/data

# Attestation
copy_drm_keys /vendor/sfpd/attestation /mnt/vendor/persist/data

# section to map sfpd files that go into read-write partitions
cp /vendor/sfpd/wlan/wlan_mac.bin /mnt/vendor/persist/
set_perms  /mnt/vendor/persist/wlan_mac.bin root.root 0660
cp /vendor/sfpd/bt/.bt_nv.bin /mnt/vendor/persist/bluetooth/.bt_nv.bin
set_perms /mnt/vendor/persist/bluetooth/.bt_nv.bin bluetooth.bluetooth 0660
# No sar calibration files are stored

# Sensor calibration section
copy_sensor_files /vendor/sfpd/sensors/ak0991x_0_platform.mag.fac_cal /mnt/vendor/persist/sensors/registry/registry/ak0991x_0_platform.mag.fac_cal
copy_sensor_files /vendor/sfpd/sensors/ak0991x_0_platform.mag.fac_cal.bias /mnt/vendor/persist/sensors/registry/registry/ak0991x_0_platform.mag.fac_cal.bias
copy_sensor_files /vendor/sfpd/sensors/ak0991x_0_platform.mag.fac_cal.corr_mat /mnt/vendor/persist/sensors/registry/registry/ak0991x_0_platform.mag.fac_cal.corr_mat
copy_sensor_files /vendor/sfpd/sensors/ak0991x_0_platform.mag.fac_cal_2 /mnt/vendor/persist/sensors/registry/registry/ak0991x_0_platform.mag.fac_cal_2
copy_sensor_files /vendor/sfpd/sensors/ak0991x_0_platform.mag.fac_cal_2.bias /mnt/vendor/persist/sensors/registry/registry/ak0991x_0_platform.mag.fac_cal_2.bias
copy_sensor_files /vendor/sfpd/sensors/ak0991x_0_platform.mag.fac_cal_2.corr_mat /mnt/vendor/persist/sensors/registry/registry/ak0991x_0_platform.mag.fac_cal_2.corr_mat
copy_sensor_files /vendor/sfpd/sensors/ak0991x_1_platform.mag.fac_cal /mnt/vendor/persist/sensors/registry/registry/ak0991x_1_platform.mag.fac_cal
copy_sensor_files /vendor/sfpd/sensors/ak0991x_1_platform.mag.fac_cal.bias /mnt/vendor/persist/sensors/registry/registry/ak0991x_1_platform.mag.fac_cal.bias
copy_sensor_files /vendor/sfpd/sensors/ak0991x_1_platform.mag.fac_cal.corr_mat /mnt/vendor/persist/sensors/registry/registry/ak0991x_1_platform.mag.fac_cal.corr_mat
copy_sensor_files /vendor/sfpd/sensors/ak0991x_1_platform.mag.fac_cal_2 /mnt/vendor/persist/sensors/registry/registry/ak0991x_1_platform.mag.fac_cal_2
copy_sensor_files /vendor/sfpd/sensors/ak0991x_1_platform.mag.fac_cal_2.bias /mnt/vendor/persist/sensors/registry/registry/ak0991x_1_platform.mag.fac_cal_2.bias
copy_sensor_files /vendor/sfpd/sensors/ak0991x_1_platform.mag.fac_cal_2.corr_mat /mnt/vendor/persist/sensors/registry/registry/ak0991x_1_platform.mag.fac_cal_2.corr_mat
copy_sensor_files /vendor/sfpd/sensors/default_sensors.accel_cal /mnt/vendor/persist/sensors/registry/registry/default_sensors.accel_cal
copy_sensor_files /vendor/sfpd/sensors/default_sensors.accel_cal.attr_0 /mnt/vendor/persist/sensors/registry/registry/default_sensors.accel_cal.attr_0
copy_sensor_files /vendor/sfpd/sensors/default_sensors.gyro_cal /mnt/vendor/persist/sensors/registry/registry/default_sensors.gyro_cal
copy_sensor_files /vendor/sfpd/sensors/default_sensors.gyro_cal.attr_0 /mnt/vendor/persist/sensors/registry/registry/default_sensors.gyro_cal.attr_0
copy_sensor_files /vendor/sfpd/sensors/default_sensors.mag_cal /mnt/vendor/persist/sensors/registry/registry/default_sensors.mag_cal
copy_sensor_files /vendor/sfpd/sensors/default_sensors.mag_cal.attr_0 /mnt/vendor/persist/sensors/registry/registry/default_sensors.mag_cal.attr_0
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_0_platform.accel.fac_cal /mnt/vendor/persist/sensors/registry/registry/lsm6dso_0_platform.accel.fac_cal
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_0_platform.accel.fac_cal.bias /mnt/vendor/persist/sensors/registry/registry/lsm6dso_0_platform.accel.fac_cal.bias
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_0_platform.accel.fac_cal.corr_mat /mnt/vendor/persist/sensors/registry/registry/lsm6dso_0_platform.accel.fac_cal.corr_mat
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_0_platform.gyro.fac_cal /mnt/vendor/persist/sensors/registry/registry/lsm6dso_0_platform.gyro.fac_cal
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_0_platform.gyro.fac_cal.bias /mnt/vendor/persist/sensors/registry/registry/lsm6dso_0_platform.gyro.fac_cal.bias
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_0_platform.gyro.fac_cal.corr_mat /mnt/vendor/persist/sensors/registry/registry/lsm6dso_0_platform.gyro.fac_cal.corr_mat
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_0_platform.temp.fac_cal /mnt/vendor/persist/sensors/registry/registry/lsm6dso_0_platform.temp.fac_cal
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_0_platform.temp.fac_cal.bias /mnt/vendor/persist/sensors/registry/registry/lsm6dso_0_platform.temp.fac_cal.bias
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_0_platform.temp.fac_cal.scale /mnt/vendor/persist/sensors/registry/registry/lsm6dso_0_platform.temp.fac_cal.scale
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_1_platform.accel.fac_cal /mnt/vendor/persist/sensors/registry/registry/lsm6dso_1_platform.accel.fac_cal
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_1_platform.accel.fac_cal.bias /mnt/vendor/persist/sensors/registry/registry/lsm6dso_1_platform.accel.fac_cal.bias
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_1_platform.accel.fac_cal.corr_mat /mnt/vendor/persist/sensors/registry/registry/lsm6dso_1_platform.accel.fac_cal.corr_mat
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_1_platform.gyro.fac_cal /mnt/vendor/persist/sensors/registry/registry/lsm6dso_1_platform.gyro.fac_cal
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_1_platform.gyro.fac_cal.bias /mnt/vendor/persist/sensors/registry/registry/lsm6dso_1_platform.gyro.fac_cal.bias
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_1_platform.gyro.fac_cal.corr_mat /mnt/vendor/persist/sensors/registry/registry/lsm6dso_1_platform.gyro.fac_cal.corr_mat
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_1_platform.temp.fac_cal /mnt/vendor/persist/sensors/registry/registry/lsm6dso_1_platform.temp.fac_cal
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_1_platform.temp.fac_cal.bias /mnt/vendor/persist/sensors/registry/registry/lsm6dso_1_platform.temp.fac_cal.bias
copy_sensor_files /vendor/sfpd/sensors/lsm6dso_1_platform.temp.fac_cal.scale /mnt/vendor/persist/sensors/registry/registry/lsm6dso_1_platform.temp.fac_cal.scale
copy_sensor_files /vendor/sfpd/sensors/sns_gyro_cal_config /mnt/vendor/persist/sensors/registry/registry/sns_gyro_cal_config
copy_sensor_files /vendor/sfpd/sensors/sns_mag_cal_config /mnt/vendor/persist/sensors/registry/registry/sns_mag_cal_config
copy_sensor_files /vendor/sfpd/sensors/txc_0_platform.als.fac_cal /mnt/vendor/persist/sensors/registry/registry/txc_0_platform.als.fac_cal
copy_sensor_files /vendor/sfpd/sensors/txc_0_platform.prx.fac_cal /mnt/vendor/persist/sensors/registry/registry/txc_0_platform.prx.fac_cal
copy_sensor_files /vendor/sfpd/sensors/txc_1_platform.als.fac_cal /mnt/vendor/persist/sensors/registry/registry/txc_1_platform.als.fac_cal
copy_sensor_files /vendor/sfpd/sensors/txc_1_platform.prx.fac_cal /mnt/vendor/persist/sensors/registry/registry/txc_1_platform.prx.fac_cal
copy_sensor_files /vendor/sfpd/sensors/txc_0_platform.als.fac_cal.adc_factor /mnt/vendor/persist/sensors/registry/registry/txc_0_platform.als.fac_cal.adc_factor
copy_sensor_files /vendor/sfpd/sensors/txc_0_platform.als.fac_cal.cal_lux /mnt/vendor/persist/sensors/registry/registry/txc_0_platform.als.fac_cal.cal_lux
copy_sensor_files /vendor/sfpd/sensors/txc_1_platform.als.fac_cal.adc_factor /mnt/vendor/persist/sensors/registry/registry/txc_1_platform.als.fac_cal.adc_factor
copy_sensor_files /vendor/sfpd/sensors/txc_1_platform.als.fac_cal.cal_lux /mnt/vendor/persist/sensors/registry/registry/txc_1_platform.als.fac_cal.cal_lux
fi
# End - Copy Widevine, Attestation, WLAN, BT, Sensors

# Display
if [ "$#" -eq 1 ] && [ "$1" == "display" ]; then
    log -t init.sfpd.sh "Copying display files"
    cp /vendor/sfpd/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_C3.xml /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_C3.xml
    cp /vendor/sfpd/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_R2.xml /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_R2.xml
    cp /vendor/sfpd/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_C3.xml /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_C3_ev1_5.xml
    cp /vendor/sfpd/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_R2.xml /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_R2_ev1_5.xml
    cp /vendor/sfpd/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_C3.xml /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_C3_ev2.xml
    cp /vendor/sfpd/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_R2.xml /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_R2_ev2.xml
    cp /vendor/sfpd/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_C3.xml /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_C3_dv.xml
    cp /vendor/sfpd/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_R2.xml /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_R2_dv.xml
    set_perms /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_C3.xml system.system 0664
    set_perms /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_R2.xml system.system 0664
    set_perms /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_C3_ev1_5.xml system.system 0664
    set_perms /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_R2_ev1_5.xml system.system 0664
    set_perms /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_C3_ev2.xml system.system 0664
    set_perms /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_R2_ev2.xml system.system 0664
    set_perms /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_C3_dv.xml system.system 0664
    set_perms /data/vendor/display/disp_user_calib_data_dsi_panel_lg_v2_amoled_cmd_R2_dv.xml system.system 0664
fi
