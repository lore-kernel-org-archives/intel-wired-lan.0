From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 29 Jan 2016 14:44:29 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Use udelay to avoid sleeping while
	atomic
Message-ID: <20160129224429.97444.23897.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use udelay instead of usleep_range because this can be called while
a lock is held.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 0985a39e7268..972c9aa17503 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -356,7 +356,7 @@ static s32 ixgbe_iosf_wait(struct ixgbe_hw *hw, u32 *ctrl)
 		command = IXGBE_READ_REG(hw, IXGBE_SB_IOSF_INDIRECT_CTRL);
 		if (!(command & IXGBE_SB_IOSF_CTRL_BUSY))
 			break;
-		usleep_range(10, 20);
+		udelay(10);
 	}
 	if (ctrl)
 		*ctrl = command;

