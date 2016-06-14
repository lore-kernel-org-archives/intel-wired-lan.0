From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Tue, 14 Jun 2016 14:26:28 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe: Change register variable to
	unsigned
Message-ID: <1465928788-29757-1-git-send-email-donald.c.skidmore@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I noticed this variable used for register reads wasn't an unsigned
so this patch corrects that.  I don't believe this was causing any
issue as is but this is more consistent with the rest of the driver.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 902d206..f8defc7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -2657,7 +2657,7 @@ s32 ixgbe_disable_rx_buff_generic(struct ixgbe_hw *hw)
  **/
 s32 ixgbe_enable_rx_buff_generic(struct ixgbe_hw *hw)
 {
-	int secrxreg;
+	u32 secrxreg;
 
 	secrxreg = IXGBE_READ_REG(hw, IXGBE_SECRXCTRL);
 	secrxreg &= ~IXGBE_SECRXCTRL_RX_DIS;
-- 
2.4.3

