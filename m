From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 13 Aug 2018 11:43:38 -0700
Subject: [Intel-wired-lan] [PATCH next-queue 1/8] ixgbe: reload ipsec ip
 table after sa tables
In-Reply-To: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
References: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1534185825-12451-2-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Restore the ipsec hardware IP table after reloading the SA tables.
This doesn't make much difference now, but will matter when we add
support for VF ipsec offloads.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index e515246..4340651 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -301,14 +301,6 @@ void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter)
 	ixgbe_ipsec_clear_hw_tables(adapter);
 	ixgbe_ipsec_start_engine(adapter);
 
-	/* reload the IP addrs */
-	for (i = 0; i < IXGBE_IPSEC_MAX_RX_IP_COUNT; i++) {
-		struct rx_ip_sa *ipsa = &ipsec->ip_tbl[i];
-
-		if (ipsa->used)
-			ixgbe_ipsec_set_rx_ip(hw, i, ipsa->ipaddr);
-	}
-
 	/* reload the Rx and Tx keys */
 	for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
 		struct rx_sa *rsa = &ipsec->rx_tbl[i];
@@ -322,6 +314,14 @@ void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter)
 		if (tsa->used)
 			ixgbe_ipsec_set_tx_sa(hw, i, tsa->key, tsa->salt);
 	}
+
+	/* reload the IP addrs */
+	for (i = 0; i < IXGBE_IPSEC_MAX_RX_IP_COUNT; i++) {
+		struct rx_ip_sa *ipsa = &ipsec->ip_tbl[i];
+
+		if (ipsa->used)
+			ixgbe_ipsec_set_rx_ip(hw, i, ipsa->ipaddr);
+	}
 }
 
 /**
-- 
2.7.4

