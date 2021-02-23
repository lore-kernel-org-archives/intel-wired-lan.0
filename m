From: Grzegorz Siwik <grzegorz.siwik@intel.com>
Date: Tue, 23 Feb 2021 15:15:27 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1] igb: Add double-check
 MTA_REGISTER for i210 and i211
Message-ID: <1614089727-337500-1-git-send-email-grzegorz.siwik@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add new function which checks MTA_REGISTER if its filled correctly.
If not then writes again to same register.
There is possibility that i210 and i211 could not accept
MTA_REGISTER settings, specially when you add and remove
many of multicast addresses in short time.
Without this patch there is possibility that multicast settings will be
not always set correctly in hardware.

Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_mac.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index fd8eb2f..2ed6a00 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
@@ -484,6 +484,31 @@ static u32 igb_hash_mc_addr(struct e1000_hw *hw, u8 *mc_addr)
 }
 
 /**
+* igb_i21x_hw_doublecheck - double checks potential HW issue in i21X
+* @hw: pointer to the HW structure
+*
+* Checks if multicast array is wrote correctly
+* If not then rewrites again to register
+**/
+static void igb_i21x_hw_doublecheck(struct e1000_hw *hw)
+{
+	bool is_failed;
+	int i;
+
+	do {
+		is_failed = false;
+		for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
+			if (array_rd32(E1000_MTA, i) != hw->mac.mta_shadow[i]) {
+				is_failed = true;
+				array_wr32(E1000_MTA, i, hw->mac.mta_shadow[i]);
+				wrfl();
+				break;
+			}
+		}
+	} while (is_failed);
+}
+
+/**
  *  igb_update_mc_addr_list - Update Multicast addresses
  *  @hw: pointer to the HW structure
  *  @mc_addr_list: array of multicast addresses to program
@@ -516,6 +541,8 @@ void igb_update_mc_addr_list(struct e1000_hw *hw,
 	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
 		array_wr32(E1000_MTA, i, hw->mac.mta_shadow[i]);
 	wrfl();
+	if (hw->mac.type == e1000_i210 || hw->mac.type == e1000_i211)
+		igb_i21x_hw_doublecheck(hw);
 }
 
 /**
-- 
1.8.3.1

