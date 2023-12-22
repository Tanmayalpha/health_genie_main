package com.example.health_genie;

import java.util.UUID;

/**
 * xing<br>
 * 2021/4/15<br>
 * <p>
 * 解析数据接口
 */
public interface OnAnalyticalListener {
    /**
     * 解析后的透传数据,
     * 用于APP
     * 后续处理的
     *
     * @param mac  mac
     * @param uuid uuid
     * @param data 数据
     */
    void onAnalyticalData(String mac, UUID uuid, byte[] data);

    /**
     * 握手结果,
     * 在握手成功后才可以发送数据,
     * 否则可能会导致芯片丢弃发送的数据
     *
     * @param mac    mac
     * @param result 结果
     */
    void onHandshake(String mac, boolean result);
}
