From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 16 Nov 2017 11:54:46 -0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher/next-queue 8/9] ixgbe: add
 the Rx ipsec offload processing
In-Reply-To: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
References: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1510862087-1924-9-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add the ipsec check and processing into the Rx handler.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index a434675..2bb4c5f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2424,6 +2424,9 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 			}
 		}
 #endif /* IXGBE_FCOE */
+		/* was IPsec offload processing done?  */
+		if (adapter->flags2 & IXGBE_FLAG2_IPSEC_ENABLED)
+			ixgbe_ipsec_process_rx_offload(rx_ring, rx_desc, skb);
 
 		ixgbe_rx_skb(q_vector, skb);
 
-- 
2.7.4

