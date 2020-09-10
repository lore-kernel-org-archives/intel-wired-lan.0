From: Wang Hai <wanghai38@huawei.com>
Date: Thu, 10 Sep 2020 23:04:29 +0800
Subject: [Intel-wired-lan] [PATCH net-next 3/3] e1000: Fix a bunch of
 kerneldoc parameter issues in e1000_hw.c
In-Reply-To: <20200910150429.31912-1-wanghai38@huawei.com>
References: <20200910150429.31912-1-wanghai38@huawei.com>
Message-ID: <20200910150429.31912-4-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix W=1 compile warnings (invalid kerneldoc):

drivers/net/ethernet/intel/e1000/e1000_hw.c:1907: warning: Excess function parameter 'mii_reg' description in 'e1000_config_mac_to_phy'
drivers/net/ethernet/intel/e1000/e1000_hw.c:2930: warning: Excess function parameter 'data' description in 'e1000_write_phy_reg'
drivers/net/ethernet/intel/e1000/e1000_hw.c:4788: warning: Excess function parameter 'tx_packets' description in 'e1000_update_adaptive'
drivers/net/ethernet/intel/e1000/e1000_hw.c:4788: warning: Excess function parameter 'total_collisions' description in 'e1000_update_adaptive'
drivers/net/ethernet/intel/e1000/e1000_hw.c:5079: warning: Excess function parameter 'downshift' description in 'e1000_check_downshift'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/intel/e1000/e1000_hw.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 4e7a0810eaeb..9cc5553b5287 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -1897,7 +1897,6 @@ void e1000_config_collision_dist(struct e1000_hw *hw)
 /**
  * e1000_config_mac_to_phy - sync phy and mac settings
  * @hw: Struct containing variables accessed by shared code
- * @mii_reg: data to write to the MII control register
  *
  * Sets MAC speed and duplex settings to reflect the those in the PHY
  * The contents of the PHY register containing the needed information need to
@@ -2922,7 +2921,7 @@ static s32 e1000_read_phy_reg_ex(struct e1000_hw *hw, u32 reg_addr,
  *
  * @hw: Struct containing variables accessed by shared code
  * @reg_addr: address of the PHY register to write
- * @data: data to write to the PHY
+ * @phy_data: data to write to the PHY
  *
  * Writes a value to a PHY register
  */
@@ -4778,8 +4777,6 @@ void e1000_reset_adaptive(struct e1000_hw *hw)
 /**
  * e1000_update_adaptive - update adaptive IFS
  * @hw: Struct containing variables accessed by shared code
- * @tx_packets: Number of transmits since last callback
- * @total_collisions: Number of collisions since last callback
  *
  * Called during the callback/watchdog routine to update IFS value based on
  * the ratio of transmits to collisions.
@@ -5064,8 +5061,6 @@ static s32 e1000_check_polarity(struct e1000_hw *hw,
 /**
  * e1000_check_downshift - Check if Downshift occurred
  * @hw: Struct containing variables accessed by shared code
- * @downshift: output parameter : 0 - No Downshift occurred.
- *                                1 - Downshift occurred.
  *
  * returns: - E1000_ERR_XXX
  *            E1000_SUCCESS
-- 
2.17.1

