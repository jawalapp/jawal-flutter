package com.yastack.jawal_flutter;

import static android.content.pm.PackageManager.PERMISSION_DENIED;
import static android.content.pm.PackageManager.PERMISSION_GRANTED;

import androidx.annotation.NonNull;

import com.yastack.jawal.JawalUtils;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class LocationPermissionResultListener implements PluginRegistry.RequestPermissionsResultListener {
    MethodChannel channel;

    LocationPermissionResultListener(MethodChannel channel) {
        this.channel = channel;
    }

    @Override
    public boolean onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        int status = 2;
        String method = null;
        if(grantResults.length > 0) {
            if(requestCode == JawalUtils.PERMISSION_FOREGROUND_LOCATION) {
                method = "onLocationPermissionResult";
            } else if (requestCode == JawalUtils.PERMISSION_BACKGROUND_LOCATION) {
                method = "onBackgroundLocationPermissionResult";
            }
            if(method != null) {
                if(grantResults[0] == PERMISSION_GRANTED) {
                    status = 0;
                }else if(grantResults[0] == PERMISSION_DENIED) {
                    status = 1;
                }
                channel.invokeMethod(method, "{\"status\": " + status + "}");
            }
        }
        return true;
    }
}
