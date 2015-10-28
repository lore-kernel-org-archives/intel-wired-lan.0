From: Bruce Allan <bruce.w.allan@intel.com>
Date: Wed, 28 Oct 2015 16:04:24 -0700
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: use BIT() macro instead
 of open-coded bit-shifting
Message-ID: <20151028230424.10576.20916.stgit@bwallan-cwp1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_type.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 

