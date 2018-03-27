From: Colin King <colin.king@canonical.com>
Date: Tue, 27 Mar 2018 15:21:48 +0100
Subject: [Intel-wired-lan] [PATCH][next] ixgbevf: ensure xdp_ring resources
 are free'd on error exit
Message-ID: <20180327142148.13603-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

The current error handling for failed resource setup for xdp_ring
data is a break out of the loop and returning 0 indicated everying
was OK, when in fact it is not.  Fix this by exiting via the
error exit label err_setup_tx that will clean up the resources
correctly and return and error status.

Detected by CoverityScan, CID#1466879 ("Logically dead code")

Fixes: 21092e9ce8b1 ("ixgbevf: Add support for XDP_TX action")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 3d9033f26eff..e3d04f226d57 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3420,7 +3420,7 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
 		if (!err)
 			continue;
 		hw_dbg(&adapter->hw, "Allocation for XDP Queue %u failed\n", j);
-		break;
+		goto err_setup_tx;
 	}
 
 	return 0;
-- 
2.15.1

