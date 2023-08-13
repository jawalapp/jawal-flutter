package com.yastack.jawal_flutter;

import android.app.Activity;
import android.os.Handler;
import android.os.Looper;
import androidx.annotation.NonNull;
import com.yastack.jawal.Jawal;
import com.yastack.jawal.JawalConfig;
import com.yastack.jawal.JawalUtils;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class JawalMethodCallsHandler implements MethodChannel.MethodCallHandler {

    private final MethodChannel channel;
    private final Activity activity;

    public JawalMethodCallsHandler(MethodChannel channel, Activity activity) {
        this.channel = channel;
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "init":
                init(call, result);
                break;
            case "startTracking":
                Jawal.startTracking();
                result.success(null);
                break;
            case "stopTracking":
                Jawal.stopTracking();
                result.success(null);
                break;
            case "isTracking":
                boolean isTracking = Jawal.isTracking();
                result.success(isTracking);
                break;
            case "askForLocationPermission":
                JawalUtils.askForForegroundLocationPermission(activity);
                result.success(null);
                break;
            case "askForBackgroundLocationPermission":
                JawalUtils.askForBackgroundLocationPermission(activity);
                result.success(null);
                break;
            case "getLocationPermissionStatus":
                int fstatus = JawalUtils.getForegroundLocationPermissionStatus(activity);
                result.success("{\"status\": " + fstatus + "}");
                break;
            case "getBackgroundLocationPermissionStatus":
                int bstatus = JawalUtils.getBackgroundLocationPermissionStatus(activity);
                result.success("{\"status\": " + bstatus + "}");
                break;
            default:
                result.notImplemented();
                break;
        }
    }


    private void init(MethodCall call, MethodChannel.Result result) {
        String sdkKey = call.argument("sdkKey");
        String userId = call.argument("userId");
        String userDescription = call.argument("userDescription");

        JawalConfig config  = new JawalConfig.Builder()
                .setSdkKey(sdkKey)
                .setUserId(userId)
                .setUserDescription(userDescription)
                .setOnInitResultListener(i -> {
                    new Handler(Looper.getMainLooper()).post(() -> channel.invokeMethod("onInitResult", i.toJson()));
                }).build();

        Jawal.init(activity, config);
        Jawal.onLocationChange(l -> {
            new Handler(Looper.getMainLooper()).post(() -> channel.invokeMethod("onLocationChange", l.toJson()));
        });
        result.success(null);
    }
}
