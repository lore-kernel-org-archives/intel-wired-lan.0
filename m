From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Fri, 12 Jan 2018 14:02:56 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: don't set RXDCTL.RLPML for 82599
Message-ID: <20180112220256.11028.5719.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

commit 2de6aa3a666e ("ixgbe: Add support for padding packet")

Uses RXDCTL.RLPML to limit the maximum frame size on Rx when using
build_skb. Unfortunately that register does not work on 82599.

Added an explicit check to avoid setting this register on 82599 MAC.

Extended the comment related to the setting of RXDCTL.RLPML to better
explain its purpose.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index addb625..1b3a246 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4133,11 +4133,15 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter *adapter,
 		rxdctl &= ~0x3FFFFF;
 		rxdctl |=  0x080420;
 #if (PAGE_SIZE < 8192)
-	} else {
+	/* RXDCTL.RLPML does not work on 82599 */
+	} else if (hw->mac.type != ixgbe_mac_82599EB) {
 		rxdctl &= ~(IXGBE_RXDCTL_RLPMLMASK |
 			    IXGBE_RXDCTL_RLPML_EN);
 
-		/* Limit the maximum frame size so we don't overrun the skb */
+		/* Limit the maximum frame size so we don't overrun the skb.
+		 * This can happen in SRIOV mode when the MTU of the VF is
+		 * higher than the MTU of the PF.
+		 */
 		if (ring_uses_build_skb(ring) &&
 		    !test_bit(__IXGBE_RX_3K_BUFFER, &ring->state))
 			rxdctl |= IXGBE_MAX_2K_FRAME_BUILD_SKB |

