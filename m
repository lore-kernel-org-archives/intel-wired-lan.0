From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:24 -0700
Subject: [Intel-wired-lan] [PATCH 07/19] fm10k: reduce the scope of the err
 variable
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-8-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reduce the scope of the local variable err in the fm10k_detach_subtask
function.

This was detected by cppcheck and resolves the following warning
produced by that tool:

[fm10k_pci.c:403]: (style) The scope of the variable 'err' can be reduced.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index e49fb51d3613..8cdfb24125bf 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2013 - 2018 Intel Corporation. */
+/* Copyright(c) 2013 - 2019 Intel Corporation. */
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -344,7 +344,6 @@ static void fm10k_detach_subtask(struct fm10k_intfc *interface)
 	struct net_device *netdev = interface->netdev;
 	u32 __iomem *hw_addr;
 	u32 value;
-	int err;
 
 	/* do nothing if netdev is still present or hw_addr is set */
 	if (netif_device_present(netdev) || interface->hw.hw_addr)
@@ -362,6 +361,8 @@ static void fm10k_detach_subtask(struct fm10k_intfc *interface)
 	hw_addr = READ_ONCE(interface->uc_addr);
 	value = readl(hw_addr);
 	if (~value) {
+		int err;
+
 		/* Make sure the reset was initiated because we detached,
 		 * otherwise we might race with a different reset flow.
 		 */
-- 
2.22.0.214.g8dca754b1e87

