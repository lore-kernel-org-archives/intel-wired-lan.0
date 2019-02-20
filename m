From: Jan Sokolowski <jan.sokolowski@intel.com>
Date: Wed, 20 Feb 2019 15:20:14 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: don't do any AF_XDP zero-copy
 transmit if netif is not OK
Message-ID: <20190220152014.13376-1-jan.sokolowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

An issue has been found while testing zero-copy XDP that
causes a reset to be triggered. As it takes some time to
turn the carrier on after setting zc, and we already
start trying to transmit some packets, watchdog considers
this as an erroneous state and triggers a reset.

Don't do any work if netif carrier is not OK.

Fixes: 8221c5eba8c13 (ixgbe: add AF_XDP zero-copy Tx support)
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 98870707b51a..51c29358c2a9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -617,7 +617,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 	dma_addr_t dma;
 
 	while (budget-- > 0) {
-		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
+		if (unlikely(!ixgbe_desc_unused(xdp_ring)) ||
+		    !netif_carrier_ok(xdp_ring->netdev)) {
 			work_done = false;
 			break;
 		}
-- 
2.18.1

