From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Sat, 08 Aug 2015 16:27:51 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix FCRTH value in VM-to-VM
	loopback mode
Message-ID: <20150808232751.95142.27650.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The 82599 and X540 datasheets require that FCRTH be "set" for Tx
switching (VM-to-VM loopback) but it did not previously specify what
the value should be set to. It has now been determined that the
the correct value is RXPBSIZE - (24*1024).

This setting is also required for later devices.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |    7 ++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c |    8 +++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 5085fa93675e..5ce649baa3ac 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -2164,10 +2164,11 @@ s32 ixgbe_fc_enable_generic(struct ixgbe_hw *hw)
 			/*
 			 * In order to prevent Tx hangs when the internal Tx
 			 * switch is enabled we must set the high water mark
-			 * to the maximum FCRTH value.  This allows the Tx
-			 * switch to function even under heavy Rx workloads.
+			 * to the Rx packet buffer size - 24KB.  This allows
+			 * the Tx switch to function even under heavy Rx
+			 * workloads.
 			 */
-			fcrth = IXGBE_READ_REG(hw, IXGBE_RXPBSIZE(i)) - 32;
+			fcrth = IXGBE_READ_REG(hw, IXGBE_RXPBSIZE(i)) - 24576;
 		}
 
 		IXGBE_WRITE_REG(hw, IXGBE_FCRTH_82599(i), fcrth);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c
index 3b932fe64ab6..23277ab153b6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c
@@ -259,7 +259,13 @@ s32 ixgbe_dcb_config_pfc_82599(struct ixgbe_hw *hw, u8 pfc_en, u8 *prio_tc)
 			fcrtl = (hw->fc.low_water[i] << 10) | IXGBE_FCRTL_XONE;
 			IXGBE_WRITE_REG(hw, IXGBE_FCRTL_82599(i), fcrtl);
 		} else {
-			reg = IXGBE_READ_REG(hw, IXGBE_RXPBSIZE(i)) - 32;
+			/* In order to prevent Tx hangs when the internal Tx
+			 * switch is enabled we must set the high water mark
+			 * to the Rx packet buffer size - 24KB.  This allows
+			 * the Tx switch to function even under heavy Rx
+			 * workloads.
+			 */
+			reg = IXGBE_READ_REG(hw, IXGBE_RXPBSIZE(i)) - 24576;
 			IXGBE_WRITE_REG(hw, IXGBE_FCRTL_82599(i), 0);
 		}
 

