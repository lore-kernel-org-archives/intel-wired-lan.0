From: Chen Yu <yu.c.chen@intel.com>
Date: Wed, 11 Nov 2020 13:51:00 +0800
Subject: [Intel-wired-lan] [PATCH 1/4][RFC] e1000e: save the return value of
 e1000e_reset()
In-Reply-To: <cover.1605073208.git.yu.c.chen@intel.com>
References: <cover.1605073208.git.yu.c.chen@intel.com>
Message-ID: <7e68b2f6a9b0a6e03f6eeba8433bc532a3256830.1605073208.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sometimes e1000e_reset() might fail during reume from S3 due to
hardware/firmware issues. Actually the return value from e1000e_reset()
can be used by the caller to verify if the NIC succeed to initialize or
not.

Introduce a static function _e1000e_reset() which is derived
from e1000e_reset(), except that the former returns the result
of this reset.

No functional change expected.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index b30f00891c03..f7c08426c0d7 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3998,7 +3998,7 @@ static void e1000e_systim_reset(struct e1000_adapter *adapter)
  * set/changed during runtime. After reset the device needs to be
  * properly configured for Rx, Tx etc.
  */
-void e1000e_reset(struct e1000_adapter *adapter)
+static int _e1000e_reset(struct e1000_adapter *adapter)
 {
 	struct e1000_mac_info *mac = &adapter->hw.mac;
 	struct e1000_fc_info *fc = &adapter->hw.fc;
@@ -4191,14 +4191,14 @@ void e1000e_reset(struct e1000_adapter *adapter)
 		default:
 			dev_err(&adapter->pdev->dev,
 				"Invalid PHY type setting EEE advertisement\n");
-			return;
+			return -EINVAL;
 		}
 
 		ret_val = hw->phy.ops.acquire(hw);
 		if (ret_val) {
 			dev_err(&adapter->pdev->dev,
 				"EEE advertisement - unable to acquire PHY\n");
-			return;
+			return -EBUSY;
 		}
 
 		e1000_write_emi_reg_locked(hw, adv_addr,
@@ -4239,6 +4239,12 @@ void e1000e_reset(struct e1000_adapter *adapter)
 		ew32(FEXTNVM9, reg);
 	}
 
+	return 0;
+}
+
+void e1000e_reset(struct e1000_adapter *adapter)
+{
+	_e1000e_reset(adapter);
 }
 
 /**
-- 
2.17.1

