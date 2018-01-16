From: Colin King <colin.king@canonical.com>
Date: Tue, 16 Jan 2018 12:48:09 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: remove redundant initialization of
 'pool'
Message-ID: <20180116124809.25790-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

Variable pool is being assigned zero and then in the following for-loop
is it being set to zero again. Remove the redundant first assignment.

Cleans up clang warning:
drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c:61:2: warning: Value stored
to 'pool' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index b3c282d09b18..d57c77f2811f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -58,7 +58,6 @@ static bool ixgbe_cache_ring_dcb_sriov(struct ixgbe_adapter *adapter)
 		return false;
 
 	/* start at VMDq register offset for SR-IOV enabled setups */
-	pool = 0;
 	reg_idx = vmdq->offset * __ALIGN_MASK(1, ~vmdq->mask);
 	for (i = 0, pool = 0; i < adapter->num_rx_queues; i++, reg_idx++) {
 		/* If we are greater than indices move to next pool */
-- 
2.15.1

