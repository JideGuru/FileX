package dev.jideguru.filex

import android.os.Build
import android.os.Environment
import android.os.StatFs
import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import androidx.core.content.ContextCompat.*
import java.io.File


class MainActivity: FlutterActivity() {
    private val CHANNEL = "dev.jideguru.filex/storage"
    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call, result ->
                    when {
                        call.method == "getStorageFreeSpace" -> result.success(getStorageFreeSpace())
                        call.method == "getStorageTotalSpace" -> result.success(getStorageTotalSpace())
                        call.method == "getExternalStorageTotalSpace" -> result.success(getExternalStorageTotalSpace())
                        call.method == "getExternalStorageFreeSpace" -> result.success(getExternalStorageFreeSpace())
                    }
                }
    }


    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    fun getStorageTotalSpace(): Long{
        val path = Environment.getDataDirectory()
        val stat = StatFs(path.path)
        return stat.totalBytes
    }
    
    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    fun getStorageFreeSpace(): Long{
        val path = Environment.getDataDirectory()
        val stat = StatFs(path.path)
        Log.i("Internal", path.path)
        return stat.availableBytes
    }

    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    fun getExternalStorageTotalSpace(): Long{
        val dirs: Array<File> = getExternalFilesDirs(context, null)
        val stat = StatFs(dirs[1].path.split("Android")[0])
        return stat.totalBytes
    }

    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    fun getExternalStorageFreeSpace(): Long{
        val dirs: Array<File> = getExternalFilesDirs(context, null)
        val stat = StatFs(dirs[1].path.split("Android")[0])
        return stat.availableBytes
    }
}
