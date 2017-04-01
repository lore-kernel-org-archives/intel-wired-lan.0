From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sat,  1 Apr 2017 02:01:35 -0700
Subject: [Intel-wired-lan] [net-next,
	2/4] ixgbe/ixgbevf: Clear the CONFIG_SPARC for ixgbevf and 82598
In-Reply-To: <20170401090137.54079-1-jeffrey.t.kirsher@intel.com>
References: <20170401090137.54079-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170401090137.54079-2-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ding Tianhong <dingtianhong@huawei.com>

The CONFIG_SPARC in ixgbevf and ixgbe_82598 is only used
to enable relaxed ordering, the CONFIG_IXBGE_WANT_RELAXED_ORDER
already did this, so rename this config for the same setting.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
Doing what the author could not do, send to the correct mailing list...

---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c    | 4 ++--
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
index 523f9d0..c7f95ae 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
@@ -175,7 +175,7 @@ static s32 ixgbe_init_phy_ops_82598(struct ixgbe_hw *hw)
  **/
 static s32 ixgbe_start_hw_82598(struct ixgbe_hw *hw)
 {
-#ifndef CONFIG_SPARC
+#ifndef CONFIG_IXGBE_ALLOW_RELAXED_ORDER
 	u32 regval;
 	u32 i;
 #endif
@@ -183,7 +183,7 @@ static s32 ixgbe_start_hw_82598(struct ixgbe_hw *hw)
 
 	ret_val = ixgbe_start_hw_generic(hw);
 
-#ifndef CONFIG_SPARC
+#ifndef CONFIG_IXGBE_ALLOW_RELAXED_ORDER
 	/* Disable relaxed ordering */
 	for (i = 0; ((i < hw->mac.max_tx_queues) &&
 	     (i < IXGBE_DCA_MAX_QUEUES_82598)); i++) {
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 80bab26..c27932d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1713,7 +1713,7 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 	IXGBE_WRITE_REG(hw, IXGBE_VFRDLEN(reg_idx),
 			ring->count * sizeof(union ixgbe_adv_rx_desc));
 
-#ifndef CONFIG_SPARC
+#ifndef CONFIG_IXGBE_ALLOW_RELAXED_ORDER
 	/* enable relaxed ordering */
 	IXGBE_WRITE_REG(hw, IXGBE_VFDCA_RXCTRL(reg_idx),
 			IXGBE_DCA_RXCTRL_DESC_RRO_EN);
