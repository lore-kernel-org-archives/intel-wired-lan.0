From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:22 -0700
Subject: [Intel-wired-lan] [PATCH 05/19] fm10k: reduce the scope of the
 q_idx local variable
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-6-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reduce the scope of the q_idx local variable in the fm10k_cache_ring_qos
function.

This was detected by cppcheck and resolves the following style warning
produced by that tool:

[fm10k_main.c:2016]: (style) The scope of the variable 'q_idx' can be
reduced.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 90270b4a1682..3bacf35fbfad 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2013 - 2018 Intel Corporation. */
+/* Copyright(c) 2013 - 2019 Intel Corporation. */
 
 #include <linux/types.h>
 #include <linux/module.h>
@@ -17,7 +17,7 @@ const char fm10k_driver_version[] = DRV_VERSION;
 char fm10k_driver_name[] = "fm10k";
 static const char fm10k_driver_string[] = DRV_SUMMARY;
 static const char fm10k_copyright[] =
-	"Copyright(c) 2013 - 2018 Intel Corporation.";
+	"Copyright(c) 2013 - 2019 Intel Corporation.";
 
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION(DRV_SUMMARY);
@@ -1869,7 +1869,7 @@ static int fm10k_init_msix_capability(struct fm10k_intfc *interface)
 static bool fm10k_cache_ring_qos(struct fm10k_intfc *interface)
 {
 	struct net_device *dev = interface->netdev;
-	int pc, offset, rss_i, i, q_idx;
+	int pc, offset, rss_i, i;
 	u16 pc_stride = interface->ring_feature[RING_F_QOS].mask + 1;
 	u8 num_pcs = netdev_get_num_tc(dev);
 
@@ -1879,7 +1879,8 @@ static bool fm10k_cache_ring_qos(struct fm10k_intfc *interface)
 	rss_i = interface->ring_feature[RING_F_RSS].indices;
 
 	for (pc = 0, offset = 0; pc < num_pcs; pc++, offset += rss_i) {
-		q_idx = pc;
+		int q_idx = pc;
+
 		for (i = 0; i < rss_i; i++) {
 			interface->tx_ring[offset + i]->reg_idx = q_idx;
 			interface->tx_ring[offset + i]->qos_pc = pc;
-- 
2.22.0.214.g8dca754b1e87

