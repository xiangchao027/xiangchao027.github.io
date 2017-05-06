CREATE OR REPLACE PROCEDURE P_DYL_2G_LOST_FLAG_WEAL(V_MONTH   IN VARCHAR2,
                                                     V_PROV    IN VARCHAR2,
                                                     V_RETCODE OUT VARCHAR2,
                                                     V_RETINFO OUT VARCHAR2) IS
  /*@
  ****************************************************************
  *名称 --%@NAME:  P_DYL_2G_LOST_FLAG_WEAL
  *功能描述 --%@COMMENT:2G稳定度指标加工
  *执行周期 --%@PERIOD:月
  *参数 --%@PARAM:V_DATE 日期,格式YYYYMM
  *参数 --%@PARAM:V_RETCODE  过程运行结束成功与否标志
  *参数 --%@PARAM:V_RETINFO  过程运行结束成功与否描述
  *创建人 --%@CREATOR:  杜娅丽
  *创建时间 --%@CREATED_TIME:2015-07-26
  *备注 --%@REMARK:
  *修改记录 --%@MODIFY:
  *来源表 --%@FROM:
  *目标表 --%@TO:
  *修改记录 --%@MODIFY:
  ******************************************************************
  @*/

  V_PKG      VARCHAR2(30);
  V_TAB      VARCHAR2(300);
  V_PROCNAME VARCHAR2(300);
  V_ROWLINE  NUMBER;
  V_COUNT    NUMBER;
  V_SQL      LONG;
  V_LOG_SN   NUMBER;
BEGIN
  V_PKG      := 'LOST_2G'; -- 分类
  V_TAB      := 'DYL_2G_LOST_FLAG_WEAL';
  V_PROCNAME := 'P_DYL_2G_LOST_FLAG_WEAL'; -- 过程名称
  SELECT ZB_csm.SEQ_DWD_SQLPARSER.NEXTVAL
    INTO V_LOG_SN --运行日志序号
    FROM DUAL;
  --日志部分
  P_INSERT_SQLPARSER_LOG_GENERAL(V_LOG_SN,
                                 V_MONTH,
                                 V_PROV,
                                 'zb_CSM',
                                 V_PROCNAME,
                                 'V_DATE='||V_MONTH||';V_PROV='||
                                 V_PROV,
                                 SYSDATE,
                                 V_TAB);
  P_INSERT_LOG(V_MONTH, V_PKG, V_PROCNAME, V_PROV, SYSDATE, V_TAB);

  V_SQL := 'ALTER TABLE zb_CSM.DYL_2G_LOST_FLAG_WEAL TRUNCATE SUBPARTITION PART'||V_MONTH||'_SUBPART'||V_PROV;
  execute immediate v_sql;


INSERT INTO zb_CSM.DYL_2G_LOST_FLAG_WEAL
SELECT
NVL(MONTH_ID,0) MONTH_ID,
NVL(PROV_ID,0) PROV_ID,
NVL(AREA_ID,0) AREA_ID,
NVL(USER_ID,0) USER_ID,
NVL(DEVICE_NUMBER,0) DEVICE_NUMBER,
NVL(SERVICE_TYPE,0) SERVICE_TYPE,
NVL(PAY_MODE,0) PAY_MODE,
NVL(PRODUCT_ID,0) PRODUCT_ID,
NVL(PRODUCT_MODE,0) PRODUCT_MODE,
NVL(CHNL_ID,0) CHNL_ID,
NVL(USER_STATUS,0) USER_STATUS,
NVL(CUST_ID,0) CUST_ID,
NVL(IS_GRP_MBR,0) IS_GRP_MBR,
NVL(IS_INNET,0) IS_INNET,
NVL(IS_THIS_ACCT,0) IS_THIS_ACCT,
NVL(IS_FREE,0) IS_FREE,
NVL(STOP_MONTH,0) STOP_MONTH,
CASE WHEN NVL(LAST_STOP_DATE,0) = 0 THEN 0 ELSE V_MONTH - NVL(LAST_STOP_DATE,0) END  LAST_STOP_DATE,
NVL(INNET_MONTHS,0) INNET_MONTHS,
NVL(FLUXMOST1MON_IMEI,0) FLUXMOST1MON_IMEI,
NVL(USE_TERM_TYPE,0) USE_TERM_TYPE,
NVL(IS_TERM_IPHONE,0) IS_TERM_IPHONE,
NVL(IS_USE_SMART,0) IS_USE_SMART,
NVL(USER_3WU,0) USER_3WU,
NVL(IS_ACTIVE,0) IS_ACTIVE,
NVL(IS_LOWER_VALUE_USER,0) IS_LOWER_VALUE_USER,
NVL(USE_STATUS_INNET,0) USE_STATUS_INNET,
NVL(TOTAL_FLUX,0) TOTAL_FLUX,
NVL(LOCAL_FLUX,0) LOCAL_FLUX,
NVL(LOCAL_FLUX,0)/DECODE(NVL(TOTAL_FLUX,0),0,1,NVL(TOTAL_FLUX,0)) LOCAL_FLUX_ZB ,
NVL(JF_TIMES,0) JF_TIMES,
NVL(NOROAM_LOCAL_JF_TIMES,0) NOROAM_LOCAL_JF_TIMES,
NVL(NOROAM_LONG_JF_TIMES,0) NOROAM_LONG_JF_TIMES,
NVL((ROAM_PROV_CALLING_TIMES + ROAM_COUN_CALLING_TIMES + GAT_ROAM_OUT_JF_TIMES + GJ_ROAM_OUT_JF_TIMES),0) / DECODE(NVL(JF_TIMES,0),0,1,NVL(JF_TIMES,0)) ROAM_ZB,
NVL(OUT_JF_TIMES,0)/DECODE(NVL(JF_TIMES,0),0,1,NVL(JF_TIMES,0))  ZHUJIAO_ZB,
NVL(CDR_NUM,0) CDR_NUM,
NVL(TOLL_NUMS,0)/DECODE(NVL(CDR_NUM,0),0,1,NVL(CDR_NUM,0))  TOLL_NUMS_ZB,
NVL(VIP_LEVEL,0) VIP_LEVEL,
NVL(ACCT_FEE,0) ACCT_FEE,
NVL(ROAM_VOICE_FEE,0) ROAM_VOICE_FEE,
NVL((PHONE_TV_FEE + PHONE_NEWSPAPER_FEE + PHONE_MUSIC_FEE),0) ZENGZHI_FEE,
NVL(OWE_FEE,0) OWE_FEE,
NVL(OVERDUE_OWE_FEE,0) OVERDUE_OWE_FEE,
NVL(P2P_SMS_CNT,0) P2P_SMS_CNT,
NVL(FLUX_NUM,0) FLUX_NUM,
NVL(FLUX_TIME,0) FLUX_TIME,
NVL(YQ_OWE_MONTHS,0) YQ_OWE_MONTHS,
NVL(STDEV_CDR_NUM,0) STDEV_CDR_NUM,
NVL(VAR_CDR_NUM,0) VAR_CDR_NUM,
NVL(CALL_DAYS,0) CALL_DAYS,
CASE WHEN NVL(LAST_CALL_TIME,0) = 0 THEN 0 ELSE V_MONTH||30 - SUBSTR(NVL(LAST_CALL_TIME,0),1,8) END  LAST_CALL_TIME,
NVL((CALL_DURA_LAST7/7),0)/DECODE(NVL((CALL_DURA_FIRST20/23),0),0,1,NVL((CALL_DURA_FIRST20/23),0))  CALL_DURA_LAST7_CN,
NVL(OTHER_MOBILE_RING,0) OTHER_MOBILE_RING,
NVL(CELLID_NUM,0) CELLID_NUM,
NVL(CALLING_MOBILE_PHONE_CDR + CALLING_TELE_PHONE_CDR,0) CALLING_YIWANG,
NVL(NET_TYPE,0) NET_TYPE,
NVL(MANU_NAME,0) MANU_NAME,
NVL(DEV_NUM_SHANG,0) DEV_NUM_SHANG,
CASE WHEN ( IS_THIS_ACCT_N = 0 OR IS_THIS_ACCT_N IS NULL ) AND USER_ID_BSS IS NULL AND SUBS_INSTANCE_ID IS NULL THEN 1 ELSE 0 END LOST_FLAG
FROM zb_CSM.DYL_2G_LOST_FLAG
WHERE MONTH_ID = V_MONTH
AND PROV_ID = V_PROV
;
      V_ROWLINE := SQL%ROWCOUNT;
      COMMIT;


    V_RETCODE := 'SUCCESS';
    V_RETINFO := '结束';



  -- 更新执行结果
  P_UPDATE_LOG(V_MONTH,
               V_PKG,
               V_PROCNAME,
               V_PROV,
               V_RETINFO,
               V_RETCODE,
               SYSDATE,
               V_ROWLINE);
  P_UPDATE_SQLPARSER_LOG_GENERAL(V_LOG_SN, V_RETCODE, V_RETINFO);
EXCEPTION
  WHEN OTHERS THEN
    V_RETCODE := 'FAIL';
    V_RETINFO := SQLERRM;
    P_UPDATE_LOG(V_MONTH,
                 V_PKG,
                 V_PROCNAME,
                 V_PROV,
                 V_RETINFO,
                 V_RETCODE,
                 SYSDATE,
                 V_ROWLINE);
    P_UPDATE_SQLPARSER_LOG_GENERAL(V_LOG_SN, V_RETCODE, V_RETINFO);
END;
/
