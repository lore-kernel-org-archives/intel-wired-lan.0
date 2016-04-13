From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 13 Apr 2016 16:08:21 -0700
Subject: [Intel-wired-lan] [PATCH v1 00/13] Fix several GCC6 warnings
Message-ID: <1460588914-20143-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series fixes several warnings on Intel(R) drivers, including
for igb, igbvf, e1000e, ixgbe, ixgbevf, i40e, i40evf and fm10k.

The primary change is to use BIT() macro where appropriate, and use the
unsigned postfix for various other bitshifts. While much of this change
doesn't prevent any current warnings, it helps ensure that future
additions make use of BIT() macro or the unsigned postfix and prevent
signed bitshift errors in the future. A few places (especially in ixgbe)
don't use BIT even though it's technically equivalent for style and
understanding the real intent of the code.

The series also fixes some other warnings, and makes use of GENMASK in a
few locations.

Changes since v1
- Fixed the last patch in the series to properly resolve the warning
  without generating a compilation error.
- Resolved Alex's comments about overzealous use of BIT(). I hope that I
  have resolved all his complaints, I fixed up the ethtool version
  changes, and other places that I felt were not bit masks. I don't
  think I missed any but there are a lot so I could use a few more eyes
  on it.

For review, here is the interdiff of the previous series:

interdiff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 50253fb9208f..010e6d61c855 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -109,14 +109,14 @@ struct e1000_info;
 #define E1000_TXDCTL_DMA_BURST_ENABLE                          \
 	(E1000_TXDCTL_GRAN | /* set descriptor granularity */  \
 	 E1000_TXDCTL_COUNT_DESC |                             \
-	 BIT(16) | /* wthresh must be +1 more than desired */\
-	 BIT(8)  | /* hthresh */                             \
-	 0x1f)       /* pthresh */
+	 (1u << 16) | /* wthresh must be +1 more than desired */\
+	 (1u << 8)  | /* hthresh */                             \
+	 0x1f)        /* pthresh */
 
 #define E1000_RXDCTL_DMA_BURST_ENABLE                          \
 	(0x01000000 | /* set descriptor granularity */         \
-	 (4 << 16)  | /* set writeback threshold    */         \
-	 (4 << 8)   | /* set prefetch threshold     */         \
+	 (4u << 16) | /* set writeback threshold    */         \
+	 (4u << 8)  | /* set prefetch threshold     */         \
 	 0x20)        /* set hthresh                */
 
 #define E1000_TIDV_FPD BIT(31)
interdirr --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 7d7eb6fcc44e..2fe5bf3653e5 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -446,8 +446,9 @@ static void e1000_get_regs(struct net_device *netdev,
 
 	memset(p, 0, E1000_REGS_LEN * sizeof(u32));
 
-	regs->version = BIT(24) | (adapter->pdev->revision << 16) |
-	    adapter->pdev->device;
+	regs->version = (1u << 24) |
+			(adapter->pdev->revision << 16) |
+			adapter->pdev->device;
 
 	regs_buff[0] = er32(CTRL);
 	regs_buff[1] = er32(STATUS);
interdirr --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index eba90c2002a2..7a7bc31493a5 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -169,7 +169,7 @@ enum igb_tx_flags {
  * maintain a power of two alignment we have to limit ourselves to 32K.
  */
 #define IGB_MAX_TXD_PWR	15
-#define IGB_MAX_DATA_PER_TXD	BIT(IGB_MAX_TXD_PWR)
+#define IGB_MAX_DATA_PER_TXD	(1u << IGB_MAX_TXD_PWR)
 
 /* Tx Descriptors needed, worst case */
 #define TXD_USE_COUNT(S) DIV_ROUND_UP((S), IGB_MAX_DATA_PER_TXD)
interdirr --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 4cc03c257eff..64e91c575a39 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -466,7 +466,7 @@ static void igb_get_regs(struct net_device *netdev,
 
 	memset(p, 0, IGB_REGS_LEN * sizeof(u32));
 
-	regs->version = BIT(24) | (hw->revision_id << 16) | hw->device_id;
+	regs->version = (1u << 24) | (hw->revision_id << 16) | hw->device_id;
 
 	/* General Registers */
 	regs_buff[0] = rd32(E1000_CTRL);
interdirr --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
index 77bdb5386e78..8dea1b1367ef 100644
--- a/drivers/net/ethernet/intel/igbvf/ethtool.c
+++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
@@ -154,7 +154,8 @@ static void igbvf_get_regs(struct net_device *netdev,
 
 	memset(p, 0, IGBVF_REGS_LEN * sizeof(u32));
 
-	regs->version = BIT(24) | (adapter->pdev->revision << 16) |
+	regs->version = (1u << 24) |
+			(adapter->pdev->revision << 16) |
 			adapter->pdev->device;
 
 	regs_buff[0] = er32(CTRL);
interdirr --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index c60717c8dc37..57894a80c469 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -1014,7 +1014,7 @@ static void igbvf_configure_msix(struct igbvf_adapter *adapter)
 
 	ew32(IVAR_MISC, tmp);
 
-	adapter->eims_enable_mask = BIT(vector) - 1;
+	adapter->eims_enable_mask = GENMASK(vector - 1, 0);
 	adapter->eims_other = BIT(vector - 1);
 	e1e_flush();
 }
@@ -2089,7 +2089,7 @@ static int igbvf_maybe_stop_tx(struct net_device *netdev, int size)
 }
 
 #define IGBVF_MAX_TXD_PWR	16
-#define IGBVF_MAX_DATA_PER_TXD	BIT(IGBVF_MAX_TXD_PWR)
+#define IGBVF_MAX_DATA_PER_TXD	(1u << IGBVF_MAX_TXD_PWR)
 
 static inline int igbvf_tx_map_adv(struct igbvf_adapter *adapter,
 				   struct igbvf_ring *tx_ring,
interdirr --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 51b47880abc4..472b4515bb76 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -170,7 +170,7 @@ struct vf_macvlans {
 };
 
 #define IXGBE_MAX_TXD_PWR	14
-#define IXGBE_MAX_DATA_PER_TXD	BIT(IXGBE_MAX_TXD_PWR)
+#define IXGBE_MAX_DATA_PER_TXD	(1u << IXGBE_MAX_TXD_PWR)
 
 /* Tx Descriptors needed, worst case */
 #define TXD_USE_COUNT(S) DIV_ROUND_UP((S), IXGBE_MAX_DATA_PER_TXD)
interdirr --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index 3c12377447b2..47afed74a54d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -1302,11 +1302,11 @@ do { \
 		bucket_hash ^= lo_hash_dword >> n; \
 	else if (IXGBE_ATR_SIGNATURE_HASH_KEY & BIT(n)) \
 		sig_hash ^= lo_hash_dword << (16 - n); \
-	if (IXGBE_ATR_COMMON_HASH_KEY & BIT((n + 16))) \
+	if (IXGBE_ATR_COMMON_HASH_KEY & BIT(n + 16)) \
 		common_hash ^= hi_hash_dword >> n; \
-	else if (IXGBE_ATR_BUCKET_HASH_KEY & BIT((n + 16))) \
+	else if (IXGBE_ATR_BUCKET_HASH_KEY & BIT(n + 16)) \
 		bucket_hash ^= hi_hash_dword >> n; \
-	else if (IXGBE_ATR_SIGNATURE_HASH_KEY & BIT((n + 16))) \
+	else if (IXGBE_ATR_SIGNATURE_HASH_KEY & BIT(n + 16)) \
 		sig_hash ^= hi_hash_dword << (16 - n); \
 } while (0)
 
@@ -1442,7 +1442,7 @@ do { \
 	u32 n = (_n); \
 	if (IXGBE_ATR_BUCKET_HASH_KEY & BIT(n)) \
 		bucket_hash ^= lo_hash_dword >> n; \
-	if (IXGBE_ATR_BUCKET_HASH_KEY & BIT((n + 16))) \
+	if (IXGBE_ATR_BUCKET_HASH_KEY & BIT(n + 16)) \
 		bucket_hash ^= hi_hash_dword >> n; \
 } while (0)
 
interdirr --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 999072dd3763..902d2061ce73 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -2924,7 +2924,7 @@ s32 ixgbe_clear_vmdq_generic(struct ixgbe_hw *hw, u32 rar, u32 vmdq)
 		mpsar_lo &= ~BIT(vmdq);
 		IXGBE_WRITE_REG(hw, IXGBE_MPSAR_LO(rar), mpsar_lo);
 	} else {
-		mpsar_hi &= ~BIT((vmdq - 32));
+		mpsar_hi &= ~BIT(vmdq - 32);
 		IXGBE_WRITE_REG(hw, IXGBE_MPSAR_HI(rar), mpsar_hi);
 	}
 
interdirr --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index 28954577fb59..4cadf80e5b87 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -166,7 +166,8 @@ static void ixgbevf_get_regs(struct net_device *netdev,
 
 	memset(p, 0, regs_len);
 
-	regs->version = BIT(24) | hw->revision_id << 16 | hw->device_id;
+	/* generate a number suitable for ethtool's register version */
+	regs->version = (1u << 24) | (hw->revision_id << 16) | hw->device_id
 
 	/* General Registers */
 	regs_buff[0] = IXGBE_READ_REG(hw, IXGBE_VFCTRL);
interdirr --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index ef127f46de23..e4e6060e6197 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3325,7 +3325,7 @@ static int ixgbevf_tso(struct ixgbevf_ring *tx_ring,
 	/* mss_l4len_id: use 1 as index for TSO */
 	mss_l4len_idx = l4len << IXGBE_ADVTXD_L4LEN_SHIFT;
 	mss_l4len_idx |= skb_shinfo(skb)->gso_size << IXGBE_ADVTXD_MSS_SHIFT;
-	mss_l4len_idx |= BIT(IXGBE_ADVTXD_IDX_SHIFT);
+	mss_l4len_idx |= (1u << IXGBE_ADVTXD_IDX_SHIFT);
 
 	/* vlan_macip_lens: HEADLEN, MACLEN, VLAN tag */
 	vlan_macip_lens = skb_network_header_len(skb);
@@ -3422,7 +3422,7 @@ static void ixgbevf_tx_olinfo_status(union ixgbe_adv_tx_desc *tx_desc,
 
 	/* use index 1 context for TSO/FSO/FCOE */
 	if (tx_flags & IXGBE_TX_FLAGS_TSO)
-		olinfo_status |= cpu_to_le32(BIT(IXGBE_ADVTXD_IDX_SHIFT));
+		olinfo_status |= cpu_to_le32(1u << IXGBE_ADVTXD_IDX_SHIFT);
 
 	/* Check Context must be set if Tx switch is enabled, which it
 	 * always is for case where virtual functions are running

Jacob Keller (13):
  ixgbe: use BIT() macro
  ixgbe: resolve shift of negative value warning
  ixgbevf: make use of BIT() macro to avoid shift of signed values
  i40e/i40evf: fix I40E_MASK signed shift overflow warnings
  i40e: make use of BIT() macro to prevent left shift of signed values
  i40evf: make use of BIT() macro to avoid signed left shift
  igb: use BIT() macro or unsigned prefix
  igb: make igb_update_pf_vlvf static
  igbvf: remove unused variable and dead code
  igbvf: use BIT() macro instead of shifts
  e1000e: use BIT() macro for bit defines
  e1000e: mark shifted values as unsigned
  e1000e: remove unused variable

 drivers/net/ethernet/intel/e1000e/80003es2lan.c    |  12 +-
 drivers/net/ethernet/intel/e1000e/82571.c          |  30 ++--
 drivers/net/ethernet/intel/e1000e/e1000.h          | 100 ++++++-------
 drivers/net/ethernet/intel/e1000e/ethtool.c        |  40 ++---
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  44 +++---
 drivers/net/ethernet/intel/e1000e/ich8lan.h        |   8 +-
 drivers/net/ethernet/intel/e1000e/mac.c            |   2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |  29 ++--
 drivers/net/ethernet/intel/e1000e/nvm.c            |   2 +-
 drivers/net/ethernet/intel/e1000e/phy.c            |   4 +-
 drivers/net/ethernet/intel/e1000e/phy.h            |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  53 ++++---
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   2 +-
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  44 +++---
 drivers/net/ethernet/intel/i40evf/i40e_type.h      |   2 +-
 drivers/net/ethernet/intel/igb/e1000_82575.c       |   8 +-
 drivers/net/ethernet/intel/igb/e1000_82575.h       |  30 ++--
 drivers/net/ethernet/intel/igb/e1000_defines.h     | 108 +++++++-------
 drivers/net/ethernet/intel/igb/e1000_mac.c         |  10 +-
 drivers/net/ethernet/intel/igb/e1000_mbx.c         |   4 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c         |   2 +-
 drivers/net/ethernet/intel/igb/e1000_phy.h         |   6 +-
 drivers/net/ethernet/intel/igb/igb.h               |  32 ++--
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |  18 +--
 drivers/net/ethernet/intel/igb/igb_main.c          |  50 +++----
 drivers/net/ethernet/intel/igb/igb_ptp.c           |   6 +-
 drivers/net/ethernet/intel/igbvf/defines.h         |   2 +-
 drivers/net/ethernet/intel/igbvf/ethtool.c         |   2 +-
 drivers/net/ethernet/intel/igbvf/igbvf.h           |   4 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |  14 +-
 drivers/net/ethernet/intel/igbvf/vf.c              |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |  68 ++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     |   6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     |  16 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |  30 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c       |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c    |   6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  14 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  36 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c       |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h       |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |  22 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      | 164 ++++++++++-----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |   8 +-
 drivers/net/ethernet/intel/ixgbevf/defines.h       |  22 +--
 drivers/net/ethernet/intel/ixgbevf/ethtool.c       |   2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h       |   8 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |  18 +--
 52 files changed, 558 insertions(+), 564 deletions(-)

-- 
2.8.1.102.ga49ec4a

