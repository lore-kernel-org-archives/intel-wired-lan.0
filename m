From: Jakub Kicinski <kuba@kernel.org>
Date: Mon,  3 Jan 2022 19:48:27 -0800
Subject: [Intel-wired-lan] [PATCH net-next] net: fixup build after bpf
 header changes
Message-ID: <20220104034827.1564167-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Recent bpf-next merge brought in header changes which uncovered
includes missing in net-next which were not present in bpf-next.
Build problems happen only on less-popular arches like hppa,
sparc, alpha etc.

I could repro the build problem with ice but not the mlx5 problem
Abdul was reporting. mlx5 does look like it should include filter.h,
anyway.

Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Fixes: e63a02348958 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next")
Link: https://lore.kernel.org/all/7c03768d-d948-c935-a7ab-b1f963ac7eed at linux.vnet.ibm.com/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jesse.brandeburg at intel.com
CC: anthony.l.nguyen at intel.com
CC: saeedm at nvidia.com
CC: leon at kernel.org
CC: intel-wired-lan at lists.osuosl.org
CC: linux-rdma at vger.kernel.org
CC: bpf at vger.kernel.org
---
 drivers/net/ethernet/intel/ice/ice_nvm.c          | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index cd739a2c64e8..4eb0599714f4 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2018, Intel Corporation. */
 
+#include <linux/vmalloc.h>
+
 #include "ice_common.h"
 
 /**
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index efcf9d30b131..31c911182498 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -37,6 +37,7 @@
 #include <net/geneve.h>
 #include <linux/bpf.h>
 #include <linux/if_bridge.h>
+#include <linux/filter.h>
 #include <net/page_pool.h>
 #include <net/xdp_sock_drv.h>
 #include "eswitch.h"
-- 
2.31.1

