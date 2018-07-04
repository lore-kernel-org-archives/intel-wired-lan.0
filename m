From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 4 Jul 2018 12:53:37 +0300
Subject: [Intel-wired-lan] [PATCH net] ixgbe: Off by one in ixgbe_ipsec_tx()
Message-ID: <20180704095337.nqiczkkd5r6k755v@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ipsec->tx_tbl[] has IXGBE_IPSEC_MAX_SA_COUNT elements so the > needs
to be changed to >= so we don't read one element beyond the end of the
array.

Fixes: 592594704761 ("ixgbe: process the Tx ipsec offload")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index c116f459945d..da4322e4daed 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -839,7 +839,7 @@ int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring,
 	}
 
 	itd->sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_TX_INDEX;
-	if (unlikely(itd->sa_idx > IXGBE_IPSEC_MAX_SA_COUNT)) {
+	if (unlikely(itd->sa_idx >= IXGBE_IPSEC_MAX_SA_COUNT)) {
 		netdev_err(tx_ring->netdev, "%s: bad sa_idx=%d handle=%lu\n",
 			   __func__, itd->sa_idx, xs->xso.offload_handle);
 		return 0;
