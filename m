From: Vasu Dev <vasu.dev@intel.com>
Date: Mon, 23 Nov 2015 10:31:25 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix broken PFC with X550
Message-ID: <20151123183125.20877.67227.stgit@lin-nd1-054.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

PFC is configuration is skipped for X550 devices due to a incorrect
device id check, fixing that to include X550 PFC configuration.

Signed-off-by: Vasu Dev <vasu.dev@intel.com>
---

 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c
index 3b932fe..07d2b1e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c
@@ -223,13 +223,13 @@ s32 ixgbe_dcb_config_pfc_82599(struct ixgbe_hw *hw, u8 pfc_en, u8 *prio_tc)
 	reg |= IXGBE_MFLCN_DPF;
 
 	/*
-	 * X540 supports per TC Rx priority flow control.  So
-	 * clear all TCs and only enable those that should be
+	 * X540 & X550 supports per TC Rx priority flow control.
+	 * So clear all TCs and only enable those that should be
 	 * enabled.
 	 */
 	reg &= ~(IXGBE_MFLCN_RPFCE_MASK | IXGBE_MFLCN_RFCE);
 
-	if (hw->mac.type == ixgbe_mac_X540)
+	if (hw->mac.type >= ixgbe_mac_X540)
 		reg |= pfc_en << IXGBE_MFLCN_RPFCE_SHIFT;
 
 	if (pfc_en)

