package com.example.health_genie;

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}

//import static com.pingwang.bluetoothlib.utils.BleStrUtils.byte2HexStr;

//import android.Manifest;
//import android.annotation.SuppressLint;
//import android.bluetooth.BluetoothAdapter;








































































































//import android.bluetooth.BluetoothDevice;
//import android.bluetooth.BluetoothGatt;
//import android.bluetooth.BluetoothGattCallback;
//import android.bluetooth.BluetoothGattCharacteristic;
//import android.bluetooth.BluetoothGattDescriptor;
//import android.bluetooth.BluetoothGattService;
//import android.bluetooth.BluetoothManager;
//import android.bluetooth.BluetoothProfile;
//import android.bluetooth.le.BluetoothLeScanner;
//import android.bluetooth.le.ScanCallback;
//import android.bluetooth.le.ScanFilter;
//import android.bluetooth.le.ScanResult;
//import android.bluetooth.le.ScanSettings;
//import android.content.ComponentName;
//import android.content.Context;
//
//import com.pingwang.bluetoothlib.BuildConfig;
//import com.pingwang.bluetoothlib.bean.BleScanAddAilinkBean;
//import com.pingwang.bluetoothlib.device.SendBleBean;
//import com.pingwang.bluetoothlib.utils.BleLog;
//import com.pingwang.bluetoothlib.utils.MyBleDeviceUtils;
//import com.pingwang.bluetoothlib.device.AiLinkBleCheckUtil;
//import com.pingwang.bluetoothlib.config.CmdConfig;
//
//
//
//import android.content.Intent;
//import android.content.ServiceConnection;
//import android.content.pm.PackageManager;
//import android.os.BatteryManager;
//import android.os.Build;
//import android.os.Handler;
//import android.os.IBinder;
//import android.os.Looper;
//import android.os.Message;
//import android.os.ParcelUuid;
//import android.util.Log;
//import android.util.SparseArray;
//import android.widget.ArrayAdapter;
//
//import androidx.annotation.NonNull;
//import androidx.annotation.Nullable;
//import androidx.annotation.RequiresApi;
//import androidx.annotation.RequiresPermission;
//import androidx.core.app.ActivityCompat;
//
//import com.pingwang.bluetoothlib.AILinkBleManager;
//import com.pingwang.bluetoothlib.AILinkSDK;
//
//import com.pingwang.bluetoothlib.AILinkBleManager.onInitListener;
//import com.pingwang.bluetoothlib.bean.BleValueBean;
//import com.pingwang.bluetoothlib.config.BleConfig;
//import com.pingwang.bluetoothlib.device.BleDevice;
//import com.pingwang.bluetoothlib.device.SendDataBean;
//import com.pingwang.bluetoothlib.listener.OnBleBroadcastDataListener;
//import com.pingwang.bluetoothlib.listener.OnBleDeviceDataListener;
//import com.pingwang.bluetoothlib.listener.OnBleOtherDataListener;
//import com.pingwang.bluetoothlib.listener.OnCallbackBle;
//import com.pingwang.bluetoothlib.listener.OnScanFilterListener;
//import com.pingwang.bluetoothlib.server.ELinkBleServer;
//
//import java.io.UnsupportedEncodingException;
//import java.util.ArrayList;
//import java.util.Arrays;
//import java.util.List;
//import java.util.UUID;
//
//import io.flutter.embedding.android.FlutterActivity;
//import io.flutter.embedding.engine.FlutterEngine;
//import io.flutter.plugin.common.MethodChannel;


/*
public class MainActivity extends FlutterActivity
{

//    private static final String CHANNEL = "samples.flutter.dev/battery";
//    private static final String TAG = "MainActivity";
//    private String string = "tanmay";
//    MethodChannel.Result myResult;
//    private ELinkBleServer mBluetoothService2;
//    private BleDevice bleDevice;
//    private ArrayAdapter listAdapter2;
//    private final static int STOP_SEARCH = 2;
//    private final static int REFRESH_DATA = 3;
//    private final static int REFRESH_BLE_DATA = 4;
//    private BluetoothManager mBleManager;
//    private BluetoothAdapter mBluetoothAdapter;
//    protected AILinkBleManager mBluetoothService;
//    protected AILinkBleManager mBluetoothService3;
//
//
//    private ArrayAdapter listAdapter1;
//    private List<String> mList1 = new ArrayList<>();
//    private List<String> mList2 = new ArrayList<>();
//    private List<BleValueBean> mBleValueList = new ArrayList<>() ;
//    private int mCid;
//    private int mVid;
//    private int mPid;
//    private int mScanCid = 0;
//    private String mBleName;
//    private final int BIND_SERVER_OK = 1;
//    private final int BIND_SERVER_ERR = 2;
//
//
//    private Handler mHandler = new Handler(Looper.getMainLooper()) {
//        @Override
//        public void handleMessage(Message msg) {
//            switch (msg.what) {
//
//                case BIND_SERVER_OK:
//
//                    break;
//
//                case REFRESH_DATA:
////                    if (listAdapter != null) {
////                        listAdapter.notifyDataSetChanged();
////                    }
//                    break;
//            }
//        }
//    };
//    //private MyScanCallback mScanCallback;
//    // private AnalyticalDataUtil mAnalyticalDataUtil;
//
//
//    // private AnalyticalDataUtil mAnalyticalDataUtil;
//
//
//    @Override
//    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//        super.configureFlutterEngine(flutterEngine);
//        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
//                .setMethodCallHandler((call, result) -> {
//                    myResult = result;
//                    if (call.method.equals("getBatteryLevel")) {
//                        int batteryLevel = getBatteryLevel();
//
//                        if (batteryLevel != -1) {
//                            result.success(batteryLevel);
//                        } else {
//                            result.error("UNAVAILABLE", "Battery level not available.", null);
//                        }
//                    } else if (call.method.equals("checkScanning")) {
//                        AILinkSDK.getInstance().init(getApplicationContext());
//
//                        AILinkBleManager.getInstance().init(MainActivity.this, new onInitListener() {
//                            @Override
//                            public void onInitSuccess() {
//                                initPermissions();
//                                AILinkBleManager.getInstance().startScan(0);
//                                Intent bindIntent = new Intent(MainActivity.this, ELinkBleServer.class);
//
//                                startService(bindIntent);
//                                MainActivity.this.bindService(bindIntent, mFhrSCon, Context.BIND_AUTO_CREATE);
//
//
//                                AILinkBleManager.getInstance().setOnCallbackBle(new OnCallbackBle() {
//                                    @Override
//                                    public void onStartScan() {
//                                        OnCallbackBle.super.onStartScan();
//                                        string = "onStartScan Started";
//                                        Log.e(TAG, "onStartScan: ");
//                                        //scanLeDevice(BleConfig.UUID_SERVER_AILINK);
//
//                                        //                                        myResult.success(string);
//                                        // onScanning();
//                                    }
//
//                                    @Override
//                                        public void onScanning(BleValueBean data) {
//                                        OnCallbackBle.super.onScanning(data);
//                                        string = "onScanningStart";
//                                        Log.e(TAG, "onScanning: " + data.getName());
//
//                                        if (data != null && "EL2".equals(data.getName())) {
//                                            getonScanedData(data);
//                                        }
//
//
//
//                                        //                                        myResult.success(string);
//                                    }
//
//
//                                    @Override
//                                    public void onScanTimeOut() {
//                                        OnCallbackBle.super.onScanTimeOut();
//                                        string = "onScanTimeOut Start";
//                                        Log.e(TAG, "onScanTimeOut: ");
//                                        //                                        myResult.success(string);
//                                    }
//
//
//                                    @Override
//                                    public void onScanErr(int type, long time) {
//                                        OnCallbackBle.super.onScanErr(type, time);
//                                        string = "onScanErr Start";
//                                        Log.e(TAG, "onScanErr: ");
//                                        //                                        myResult.success(string);
//                                    }
//
//                                    @Override
//                                    public void onConnecting(String mac) {
//                                        OnCallbackBle.super.onConnecting(mac);
//
//                                        string = "onConnecting Start";
//                                        Log.e(TAG, "Received onConnecting data: " + mac);
//                                        // Log.e(TAG, "Received data: " + bleDevice);
//
//
//                                       // BleDevice bleDevice = mBluetoothService2.getBleDevice(mac);
//                                        //Log.e(TAG, "BLEDEVICE: " + bleDevice);
//                                        //myResult.success(string);
//                                    }
//
//                                });
//
//
//
//                            }
//
//                            @Override
//                            public void onInitFailure() {
//                                System.out.println("onInitFailure");
//                                // Failure
//                            }
//                        });
//
//
//                    } else {
//                        result.notImplemented();
//                    }
//                });
//    }
//
//
//    private void initPermissions() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//            ActivityCompat.requestPermissions(this,
//                    new String[]{Manifest.permission.ACCESS_COARSE_LOCATION}, 1);
//
//        }
//    }
//
//    private void checkService(){
//        if (mBluetoothService3 != null) {
//            BleLog.i(TAG, "搜索设备");
//            try {
//                String cidStr = String.valueOf(mScanCid);
//                if (cidStr.startsWith("0x")) {
//                    mScanCid = Integer.parseInt(cidStr, 16);
//                } else {
//                    mScanCid = Integer.parseInt(cidStr);
//                }
//            } catch (NumberFormatException e) {
//                mScanCid = -1;
//                e.printStackTrace();
//            }
//                //0000FEE7=手表
//                mBluetoothService3.startScan(30 * 1000, BleConfig.UUID_BROADCAST_AILINK, BleConfig.UUID_SERVER_BROADCAST_AILINK, UUID.fromString("0000FEE7-0000-1000-8000-00805F9B34FB"));
//
//            mBleValueList.clear();
//          //  listAdapter.notifyDataSetChanged();
//        }
//    }
//
//
//
//
//private void getonScanedData ( BleValueBean data){
//    String mAddress = data.getMac();
//
//    BleLog.i(TAG, "MAC=" + mAddress + "||CID=" + data.getCid() + "||VID=" + data.getVid() + "||PID=" + data.getPid());
//    Log.e(TAG, "Received data: " + mAddress);
//    boolean oldData = false;
//    for (int i = 0; i < mBleValueList.size(); i++) {
//        BleValueBean bleValueBean = mBleValueList.get(i);
//
//        if (bleValueBean.equals(data)) {
//            bleValueBean.setRssi(data.getRssi());
//           // Log.e(TAG, " hsjfsfskhfdata: " + data.getRssi());
//            oldData = true;
//            //listAdapter.notifyItemChanged(i);
//            Log.e(TAG, "Received one: " + mBleValueList.get(i));
//
//            break;
//        }
//    }
//    if (!oldData) {
//        //不是旧设备,是新的,添加
//        mBleValueList.add(data);
//        //listAdapter.notifyDataSetChanged();
//    }
//
//}
//
//    private int getBatteryLevel() {
//        int batteryLevel;
//        BatteryManager batteryManager = (BatteryManager) getSystemService(Context.BATTERY_SERVICE);
//        batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
//
//        return batteryLevel;
//    }
//
//
//    private ServiceConnection mFhrSCon = new ServiceConnection() {
//        @Override
//        public void onServiceConnected(ComponentName name, IBinder service) {
//            Log.e(TAG, "onServiceConnected: " + name);
//
//
//            AILinkBleManager.getInstance().startScan(35000, BleConfig.UUID_SERVER_BROADCAST_AILINK);
//
//
//            //            与服务建立连接
//            mBluetoothService2 = ((ELinkBleServer.BluetoothBinder) service).getService();
//            // mBluetoothService.scanLeDevice (3000,BleConfig.UUID_SERVER_BROADCAST_AILINK);
//
//            Log.e(TAG, "onServiceConnected: 2 " + service + (mBluetoothService != null));
//
//            if (mBluetoothService2 != null) {
//                //mBluetoothService.setOnCallback(MainActivity.this);
//                mBluetoothService2.isScanStatus();
//                Log.e(TAG, "isScanStatus: " + mBluetoothService2.isScanStatus());
//
//                mBluetoothService2.setOnScanFilterListener(new OnScanFilterListener() {
//                    @Override
//                    public boolean onFilter(BleValueBean bleValueBean) {
//
//                        Log.e(TAG, "onFilter: " + bleValueBean);
//                        return OnScanFilterListener.super.onFilter(bleValueBean);
//                    }
//
//                    @Override
//                    public void onScanRecord(BleValueBean bleValueBean) {
//                        Log.e(TAG, "onScanRecord: " + bleValueBean);
//                        OnScanFilterListener.super.onScanRecord(bleValueBean);
//                        if(bleValueBean != null && "EL2".equals(bleValueBean.getName())){
//
//
//                            connectBle(bleValueBean);
//                        }
//
//
//
//                    }
//
//
//                });
//                //                mHandler.sendEmptyMessageptyMessage(BIND_SERVER_OK);
//            }
//        }
//
//        @Override
//        public void onServiceDisconnected(ComponentName name) {
//
//        }
//
//        @Override
//        public void onBindingDied(ComponentName name) {
//            ServiceConnection.super.onBindingDied(name);
//        }
//
//        @Override
//        public void onNullBinding(ComponentName name) {
//            ServiceConnection.super.onNullBinding(name);
//        }
//
//    };
//
//    protected void connectBle(BleValueBean bleValueBean){
//        Log.e(TAG, "isConnectStatus: " + bleValueBean.getManufacturerData());
//        mBluetoothService2.stopScan();
//        mBluetoothService2.connectDevice(bleValueBean);
//        Log.e(TAG, "onServiceDisconnected: " + bleValueBean);
//
//        String deviceAddress = bleValueBean.getAddress();
//        String mac = bleValueBean.getMac();
//        mCid = bleValueBean.getCid();
//        mVid = bleValueBean.getVid();
//        mPid = bleValueBean.getPid();
//        mBluetoothService2.isConnectStatus();
//        Log.e(TAG, "isConnectStatus: " + mBluetoothService2.isConnectStatus());
//        Log.e(TAG, "isConnectStatus: " + mVid);
//        Log.e(TAG, "isConnectStatus: " + mCid);
//
//
//        AILinkBleManager.getInstance().setOnBleBroadcastDataListener(new OnBleBroadcastDataListener() {
//            @Override
//            public void onBleBroadcastData(BleValueBean bleValueBean, byte[] payload) {
//                Log.e(TAG, "payload: "+payload );
//                if(payload != null ) {
//
//                    byte[] data = AiLinkBleCheckUtil.getBroadcastManufacturerData(bleValueBean);
//
//
//                    byte[] decryptData = AiLinkBleCheckUtil.decryptAndCidVidPid(data,false,mCid,mVid,mPid);
//
//                    Log.e(TAG, "isCodata: " + decryptData);
//
//                }
//                OnBleBroadcastDataListener.super.onBleBroadcastData(bleValueBean, payload);
//            }
//
//            @Override
//            public int hashCode() {
//                return super.hashCode();
//            }
//
//            @Override
//            public boolean equals(@Nullable Object obj) {
//                return super.equals(obj);
//            }
//
//            @NonNull
//            @Override
//            protected Object clone() throws CloneNotSupportedException {
//                return super.clone();
//            }
//
//            @NonNull
//            @Override
//            public String toString() {
//                return super.toString();
//            }
//
//            @Override
//            protected void finalize() throws Throwable {
//                super.finalize();
//            }
//        });
//
//
//        //BodyFatData bodyFatData = AicareBleConfig.getBodyFatData(0, 1, 25, 65, 170, 500);
//
//       // AILinkBleManager.getInstance().onB
//
//
//    }




}


*/







