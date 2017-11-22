From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:57:05 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 09/16] ixgbe: Default
 to 1 pool always being allocated
In-Reply-To: <20171122185256.29785.93548.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
Message-ID: <20171122185705.29785.4436.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

We might as well configure the limit to default to 1 pool always for the
interface. This accounts for the fact that the PF counts as 1 pool if
SR-IOV is enabled, and in general we are always running in 1 pool mode when
RSS or DCB is enabled as well, though we don't need to actually evaulate
any of the VMDq features in those cases.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    7 ++-----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6b553f96ead9..611e6980b5ac 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6127,6 +6127,7 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 	fdir = min_t(int, IXGBE_MAX_FDIR_INDICES, num_online_cpus());
 	adapter->ring_feature[RING_F_FDIR].limit = fdir;
 	adapter->fdir_pballoc = IXGBE_FDIR_PBALLOC_64K;
+	adapter->ring_feature[RING_F_VMDQ].limit = 1;
 #ifdef CONFIG_IXGBE_DCA
 	adapter->flags |= IXGBE_FLAG_DCA_CAPABLE;
 #endif
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 0085f4632966..543f2e60e4b7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -78,12 +78,9 @@ static int __ixgbe_enable_sriov(struct ixgbe_adapter *adapter,
 	struct ixgbe_hw *hw = &adapter->hw;
 	int i;
 
-	adapter->flags |= IXGBE_FLAG_SRIOV_ENABLED;
-
 	/* Enable VMDq flag so device will be set in VM mode */
-	adapter->flags |= IXGBE_FLAG_VMDQ_ENABLED;
-	if (!adapter->ring_feature[RING_F_VMDQ].limit)
-		adapter->ring_feature[RING_F_VMDQ].limit = 1;
+	adapter->flags |= IXGBE_FLAG_SRIOV_ENABLED |
+			  IXGBE_FLAG_VMDQ_ENABLED;
 
 	/* Allocate memory for per VF control structures */
 	adapter->vfinfo = kcalloc(num_vfs, sizeof(struct vf_data_storage),

