From: Paul Greenwalt <paul.greenwalt@intel.com>
Date: Mon, 23 Oct 2017 11:21:51 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe: add array bounds check
Message-ID: <1508772111-4527-1-git-send-email-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add bounds check for index fcoe_i of rx_ring array.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index a23c2b5..5772fe2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -698,6 +698,8 @@ void ixgbe_configure_fcoe(struct ixgbe_adapter *adapter)
 		}
 
 		fcoe_i = fcoe->offset + (i % fcoe->indices);
+		if (fcoe_i >= MAX_RX_QUEUES)
+			fcoe_i = MAX_RX_QUEUES - 1;
 		fcoe_i &= IXGBE_FCRETA_ENTRY_MASK;
 		fcoe_q = adapter->rx_ring[fcoe_i]->reg_idx;
 		fcoe_q |= fcoe_q_h;
-- 
2.7.4

