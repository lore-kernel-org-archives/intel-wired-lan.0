From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 04 Dec 2015 11:26:43 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Correct handling of any outer UDP
	checksum setting
Message-ID: <20151204192643.31964.87829.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If an outer UDP checksum is set, pass the skb up with CHECKSUM_NONE
so that the stack will check the checksum. Do not increment an
error counter, because we don't know that there is an actual error.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1ce1112f536b..986fc6eb135c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1483,7 +1483,7 @@ static inline void ixgbe_rx_checksum(struct ixgbe_ring *ring,
 			return;
 
 		if (ixgbe_test_staterr(rx_desc, IXGBE_RXDADV_ERR_OUTERIPER)) {
-			ring->rx_stats.csum_err++;
+			skb->ip_summed = CHECKSUM_NONE;
 			return;
 		}
 		/* If we checked the outer header let the stack know */

