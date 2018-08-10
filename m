From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 10 Aug 2018 12:24:10 -0700
Subject: [Intel-wired-lan] [PATCH next-queue] ixgbe: don't clear ipsec sa
 counters on hw clearing
Message-ID: <1533929050-15326-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The software SA record counters should not be cleared when clearing
the hardware tables.  This causes the counters to be out of sync
after a driver reset.

Fixes: 63a67fe229ea ("ixgbe: add ipsec offload add and remove SA")
Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index c116f45..df2f997 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -113,7 +113,6 @@ static void ixgbe_ipsec_set_rx_ip(struct ixgbe_hw *hw, u16 idx, __be32 addr[])
  **/
 static void ixgbe_ipsec_clear_hw_tables(struct ixgbe_adapter *adapter)
 {
-	struct ixgbe_ipsec *ipsec = adapter->ipsec;
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 buf[4] = {0, 0, 0, 0};
 	u16 idx;
@@ -132,9 +131,6 @@ static void ixgbe_ipsec_clear_hw_tables(struct ixgbe_adapter *adapter)
 		ixgbe_ipsec_set_tx_sa(hw, idx, buf, 0);
 		ixgbe_ipsec_set_rx_sa(hw, idx, 0, buf, 0, 0, 0);
 	}
-
-	ipsec->num_rx_sa = 0;
-	ipsec->num_tx_sa = 0;
 }
 
 /**
-- 
2.7.4

