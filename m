From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 1 Jun 2021 22:02:38 +0800
Subject: [Intel-wired-lan] [PATCH net-next] igb: Fix -Wunused-const-variable
 warning
Message-ID: <20210601140238.20712-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If CONFIG_IGB_HWMON is n, gcc warns:

drivers/net/ethernet/intel/igb/e1000_82575.c:2765:17:
 warning: ?e1000_emc_therm_limit? defined but not used [-Wunused-const-variable=]
 static const u8 e1000_emc_therm_limit[4] = {
                 ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/igb/e1000_82575.c:2759:17:
 warning: ?e1000_emc_temp_data? defined but not used [-Wunused-const-variable=]
 static const u8 e1000_emc_temp_data[4] = {
                 ^~~~~~~~~~~~~~~~~~~

Move it into #ifdef block to fix this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index 50863fd87d53..cbe92fd23a70 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -2756,6 +2756,7 @@ s32 igb_get_eee_status_i354(struct e1000_hw *hw, bool *status)
 	return ret_val;
 }
 
+#ifdef CONFIG_IGB_HWMON
 static const u8 e1000_emc_temp_data[4] = {
 	E1000_EMC_INTERNAL_DATA,
 	E1000_EMC_DIODE1_DATA,
@@ -2769,7 +2770,6 @@ static const u8 e1000_emc_therm_limit[4] = {
 	E1000_EMC_DIODE3_THERM_LIMIT
 };
 
-#ifdef CONFIG_IGB_HWMON
 /**
  *  igb_get_thermal_sensor_data_generic - Gathers thermal sensor data
  *  @hw: pointer to hardware structure
-- 
2.17.1

