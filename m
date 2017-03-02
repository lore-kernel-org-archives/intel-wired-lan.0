From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 02 Mar 2017 15:01:36 -0800
Subject: [Intel-wired-lan] [net PATCH] ixgbe: Fix output from ixgbe_dump
Message-ID: <20170302230136.8845.40421.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

I just found that when we had changed the Rx path to check for length
instead of the DD bit we introduced an issue in ixgbe_dump since we were no
longer clearing the status bits.

To correct this I am updating ixgbe_dump to look for the length bits in the
descriptor since that is what we are using in the Rx path.

Fixes: c3630cc40b4f ("ixgbe: Use length to determine if descriptor is done")
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index a922a2c2e4b6..b58f4b255e4e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -601,7 +601,6 @@ static void ixgbe_dump(struct ixgbe_adapter *adapter)
 	struct ixgbe_ring *rx_ring;
 	union ixgbe_adv_rx_desc *rx_desc;
 	struct ixgbe_rx_buffer *rx_buffer_info;
-	u32 staterr;
 	int i = 0;
 
 	if (!netif_msg_hw(adapter))
@@ -810,8 +809,7 @@ static void ixgbe_dump(struct ixgbe_adapter *adapter)
 			rx_buffer_info = &rx_ring->rx_buffer_info[i];
 			rx_desc = IXGBE_RX_DESC(rx_ring, i);
 			u0 = (struct my_u0 *)rx_desc;
-			staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
-			if (staterr & IXGBE_RXD_STAT_DD) {
+			if (rx_desc->wb.upper.length) {
 				/* Descriptor Done */
 				pr_info("RWB[0x%03X]     %016llX "
 					"%016llX ---------------- %p", i,

