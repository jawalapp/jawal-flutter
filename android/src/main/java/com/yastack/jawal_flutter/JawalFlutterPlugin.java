package com.yastack.jawal_flutter;

import static android.content.pm.PackageManager.PERMISSION_DENIED;
import static android.content.pm.PackageManager.PERMISSION_GRANTED;

import android.app.Activity;
import androidx.annotation.NonNull;

import com.yastack.jawal.JawalUtils;

import java.security.Permission;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMethodCodec;

/** JawalFlutterPlugin */
public class JawalFlutterPlugin implements FlutterPlugin, ActivityAware {

  private MethodChannel channel;
  private Activity activity;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    BinaryMessenger messenger = flutterPluginBinding.getBinaryMessenger();
    BinaryMessenger.TaskQueue taskQueue = messenger.makeBackgroundTaskQueue();
    channel = new MethodChannel(messenger, "jawal_flutter", StandardMethodCodec.INSTANCE, taskQueue);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
    binding.addRequestPermissionsResultListener(new LocationPermissionResultListener(channel));
    channel.setMethodCallHandler(new JawalMethodCallsHandler(channel, activity));
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    this.activity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    this.activity = null;
  }

}
