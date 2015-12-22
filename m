From: Raanan Avargil <raanan.avargil@intel.com>
Date: Tue, 22 Dec 2015 15:35:04 +0200
Subject: [Intel-wired-lan] [PATCH 4/5] e1000e: Clear ULP configuration
	register on ULP exit
In-Reply-To: <1450791305-11285-1-git-send-email-raanan.avargil@intel.com>
References: <1450791305-11285-1-git-send-email-raanan.avargil@intel.com>
Message-ID: <1450791305-11285-4-git-send-email-raanan.avargil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There have been bugs caused by HW ULP configuration settings not being
properly cleared after cable connect in V-Pro capable systems.
This caused HW to get out of sync occasionally.
The fix ensures that ULP settings are cleared in HW after
LAN cable re-connect.

Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 ++
 drivers/net/ethernet/intel/e1000e/ich8lan.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index e7ccf5f..c0f4887 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1328,6 +1328,8 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 		     I218_ULP_CONFIG1_RESET_TO_SMBUS |
 		     I218_ULP_CONFIG1_WOL_HOST |
 		     I218_ULP_CONFIG1_INBAND_EXIT |
+		     I218_ULP_CONFIG1_EN_ULP_LANPHYPC |
+		     I218_ULP_CONFIG1_DIS_CLR_STICKY_ON_PERST |
 		     I218_ULP_CONFIG1_DISABLE_SMB_PERST);
 	e1000_write_phy_reg_hv_locked(hw, I218_ULP_CONFIG1, phy_reg);
 
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index 7d85f00..2311f60 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -188,6 +188,10 @@
 #define I218_ULP_CONFIG1_INBAND_EXIT	0x0020	/* Inband on ULP exit */
 #define I218_ULP_CONFIG1_WOL_HOST	0x0040	/* WoL Host on ULP exit */
 #define I218_ULP_CONFIG1_RESET_TO_SMBUS	0x0100	/* Reset to SMBus mode */
+/* enable ULP even if when phy powered down via lanphypc */
+#define I218_ULP_CONFIG1_EN_ULP_LANPHYPC	0x0400
+/* disable clear of sticky ULP on PERST */
+#define I218_ULP_CONFIG1_DIS_CLR_STICKY_ON_PERST	0x0800
 #define I218_ULP_CONFIG1_DISABLE_SMB_PERST	0x1000	/* Disable on PERST# */
 
 /* SMBus Address Phy Register */
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

