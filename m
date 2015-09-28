From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:16:57 -0400
Subject: [Intel-wired-lan] [next PATCH S17 08/11] i40e/i40evf: Fix an
	accidental error with BIT_ULL replacement
In-Reply-To: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443464220-148318-9-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

A mask value of 0x1FF was accidentally replaced with a bit mask
causing flow director sideband to be broken.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: Id3387f67dd1b567b41692b570b383c58671e1eae
---
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 4 ++--
 drivers/net/ethernet/intel/i40evf/i40e_type.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index f631ca0..dd2da35 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1068,8 +1068,8 @@ enum i40e_filter_program_desc_fd_status {
 };
 
 #define I40E_TXD_FLTR_QW0_DEST_VSI_SHIFT	23
-#define I40E_TXD_FLTR_QW0_DEST_VSI_MASK \
-				       BIT_ULL(I40E_TXD_FLTR_QW0_DEST_VSI_SHIFT)
+#define I40E_TXD_FLTR_QW0_DEST_VSI_MASK	(0x1FFUL << \
+					 I40E_TXD_FLTR_QW0_DEST_VSI_SHIFT)
 
 #define I40E_TXD_FLTR_QW1_CMD_SHIFT	4
 #define I40E_TXD_FLTR_QW1_CMD_MASK	(0xFFFFULL << \
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index 85af3b4..301fe2b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -1055,8 +1055,8 @@ enum i40e_filter_program_desc_fd_status {
 };
 
 #define I40E_TXD_FLTR_QW0_DEST_VSI_SHIFT	23
-#define I40E_TXD_FLTR_QW0_DEST_VSI_MASK \
-				       BIT_ULL(I40E_TXD_FLTR_QW0_DEST_VSI_SHIFT)
+#define I40E_TXD_FLTR_QW0_DEST_VSI_MASK	(0x1FFUL << \
+					 I40E_TXD_FLTR_QW0_DEST_VSI_SHIFT)
 
 #define I40E_TXD_FLTR_QW1_CMD_SHIFT	4
 #define I40E_TXD_FLTR_QW1_CMD_MASK	(0xFFFFULL << \
-- 
1.9.3

