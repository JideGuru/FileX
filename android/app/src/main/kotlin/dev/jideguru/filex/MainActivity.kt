package dev.jideguru.filex

import android.os.Build
import android.os.Environment
import android.os.StatFs
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

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
                        call.method == "getSDCardTotalSpace" -> result.success(getSDCardTotalSpace())
                        call.method == "getSDCardFreeSpace" -> result.success(getSDCardFreeSpace())
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
        return stat.availableBytes
    }

    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    fun getSDCardTotalSpace(): Long{
        val path = Environment.getExternalStorageDirectory()
        val stat = StatFs(path.path)
        return stat.totalBytes
    }

    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    fun getSDCardFreeSpace(): Long{
        val path = Environment.getExternalStorageDirectory()
        val stat = StatFs(path.path)
        return stat.availableBytes
    }
}
