From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sun,  5 Jan 2020 00:46:00 -0800
Subject: [Intel-wired-lan] [net] i40e: Fix receive buffer starvation for
 AF_XDP
Message-ID: <20200105084600.4025394-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Magnus's fix to resolve a potential receive buffer starvation for AF_XDP
got applied to both the i40e_xsk_umem_enable/disable() functions, when it
should have only been applied to the "enable".  So clean up the undesired
code in the disable function.

CC: Magnus Karlsson <magnus.karlsson@intel.com>
Fixes: 1f459bdc2007 ("i40e: fix potential RX buffer starvation for AF_XDP")
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 42058fad6a3c..1b13d8e0d67a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -114,11 +114,6 @@ static int i40e_xsk_umem_enable(struct i40e_vsi *vsi, struct xdp_umem *umem,
 		err = i40e_queue_pair_enable(vsi, qid);
 		if (err)
 			return err;
-
-		/* Kick start the NAPI context so that receiving will start */
-		err = i40e_xsk_wakeup(vsi->netdev, qid, XDP_WAKEUP_RX);
-		if (err)
-			return err;
 	}
 
 	return 0;
-- 
2.24.1

