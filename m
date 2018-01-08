From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon,  8 Jan 2018 14:47:48 -0800
Subject: [Intel-wired-lan] [PATCH next-queue 1/2] ixgbe: fix clean hw loop
 count
Message-ID: <1515451669-927-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix a cut-paste error so that we can clean all the table entries.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 12c7132..57c10e6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -148,7 +148,7 @@ static void ixgbe_ipsec_clear_hw_tables(struct ixgbe_adapter *adapter)
 		ixgbe_ipsec_set_rx_sa(hw, idx, 0, buf, 0, 0, 0);
 		ixgbe_ipsec_set_rx_ip(hw, idx, (__be32 *)buf);
 	}
-	for (; idx < IXGBE_IPSEC_MAX_RX_IP_COUNT; idx++) {
+	for (; idx < IXGBE_IPSEC_MAX_SA_COUNT; idx++) {
 		ixgbe_ipsec_set_tx_sa(hw, idx, buf, 0);
 		ixgbe_ipsec_set_rx_sa(hw, idx, 0, buf, 0, 0, 0);
 	}
-- 
2.7.4

