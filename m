From: Bruce Allan <bruce.w.allan@intel.com>
Date: Tue, 08 Dec 2015 15:51:04 -0800
Subject: [Intel-wired-lan] [PATCH] fm10k: remove unused struct element
Message-ID: <20151208235104.125805.8704.stgit@bwallan-cwp1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_type.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_type.h b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
index bc27c75..854ebb1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_type.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
@@ -550,7 +550,6 @@ struct fm10k_mac_ops {
 				    struct fm10k_dglort_cfg *);
 	void (*set_dma_mask)(struct fm10k_hw *, u64);
 	s32 (*get_fault)(struct fm10k_hw *, int, struct fm10k_fault *);
-	void (*request_lport_map)(struct fm10k_hw *);
 	s32 (*adjust_systime)(struct fm10k_hw *, s32 ppb);
 	u64 (*read_systime)(struct fm10k_hw *);
 };

