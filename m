From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 10 Nov 2016 09:57:29 -0800
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Reduce I2C retry count on X550
	devices
Message-ID: <1478800649-22831-1-git-send-email-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A retry count of 10 is likely to run into problems on X550 devices that
have to detect and reset unresponsive CS4227 devices. So, reduce the I2C
retry count to 3 for X550 and above. This should avoid any possible
regressions in existing devices.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---

v2 -
  Removed mac check in ixgbe_read_i2c_combined_generic_int(); set initial
  max_retry value to 3 instead.

 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 4aa6793..e0fc147 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -113,7 +113,7 @@ s32 ixgbe_read_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 					u16 reg, u16 *val, bool lock)
 {
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
-	int max_retry = 10;
+	int max_retry = 3;
 	int retry = 0;
 	u8 csum_byte;
 	u8 high_bits;
@@ -1756,6 +1756,8 @@ static s32 ixgbe_read_i2c_byte_generic_int(struct ixgbe_hw *hw, u8 byte_offset,
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
 	bool nack = true;
 
+	if (hw->mac.type >= ixgbe_mac_X550)
+		max_retry = 3;
 	if (ixgbe_is_sfp_probe(hw, byte_offset, dev_addr))
 		max_retry = IXGBE_SFP_DETECT_RETRIES;
 
-- 
2.4.0

