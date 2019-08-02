From: Chuhong Yuan <hslester96@gmail.com>
Date: Fri,  2 Aug 2019 18:54:57 +0800
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: Explicitly initialize
 reference count to 0
Message-ID: <20190802105457.16596-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver does not explicitly call atomic_set to initialize
refcount to 0.
Add the call so that it will be more straight forward to
convert refcount from atomic_t to refcount_t.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index ccd852ad62a4..00710f43cfd2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -773,6 +773,7 @@ int ixgbe_setup_fcoe_ddp_resources(struct ixgbe_adapter *adapter)
 
 	fcoe->extra_ddp_buffer = buffer;
 	fcoe->extra_ddp_buffer_dma = dma;
+	atomic_set(&fcoe->refcnt, 0);
 
 	/* allocate pci pool for each cpu */
 	for_each_possible_cpu(cpu) {
-- 
2.20.1

