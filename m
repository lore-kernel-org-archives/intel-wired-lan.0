From: Bruce Allan <bruce.w.allan@intel.com>
Date: Wed, 28 Oct 2015 17:19:45 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v2] fm10k: use BIT() macro
 instead of open-coded bit-shifting
Message-ID: <20151029001945.19165.81033.stgit@bwallan-cwp1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h      |    2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_type.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 4aaaa90..6735f7d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -422,7 +422,7 @@ static inline u16 fm10k_desc_unused(struct fm10k_ring *ring)
 	 (&(((union fm10k_rx_desc *)((R)->desc))[i]))
 
 #define FM10K_MAX_TXD_PWR	14
-#define FM10K_MAX_DATA_PER_TXD	(1 << FM10K_MAX_TXD_PWR)
+#define FM10K_MAX_DATA_PER_TXD	BIT(FM10K_MAX_TXD_PWR)
 
 /* Tx Descriptors needed, worst case */
 #define TXD_USE_COUNT(S)	DIV_ROUND_UP((S), FM10K_MAX_DATA_PER_TXD)
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_type.h b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
index 2fd962f..098883d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_type.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
@@ -354,7 +354,7 @@ struct fm10k_hw;
 #define FM10K_VLAN_TABLE_VID_MAX		4096
 #define FM10K_VLAN_TABLE_VSI_MAX		64
 #define FM10K_VLAN_LENGTH_SHIFT			16
-#define FM10K_VLAN_CLEAR			(1 << 15)
+#define FM10K_VLAN_CLEAR			BIT(15)
 #define FM10K_VLAN_ALL \
 	((FM10K_VLAN_TABLE_VID_MAX - 1) << FM10K_VLAN_LENGTH_SHIFT)
 

