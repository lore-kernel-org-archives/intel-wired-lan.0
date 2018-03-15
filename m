From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 15 Mar 2018 14:23:21 -0700
Subject: [Intel-wired-lan] [next-queue 2/4] ixgbe: remove unneeded ipsec
 test in TX path
In-Reply-To: <1521149003-1433-1-git-send-email-shannon.nelson@oracle.com>
References: <1521149003-1433-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1521149003-1433-3-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since the ipsec data fields will be zero anyway in the non-ipsec
case, we can remove the conditional jump.

Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 153cd9e..a54f3d8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7864,10 +7864,8 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
 	vlan_macip_lens |= skb_network_offset(skb) << IXGBE_ADVTXD_MACLEN_SHIFT;
 	vlan_macip_lens |= first->tx_flags & IXGBE_TX_FLAGS_VLAN_MASK;
 
-	if (first->tx_flags & IXGBE_TX_FLAGS_IPSEC) {
-		fceof_saidx |= itd->sa_idx;
-		type_tucmd |= itd->flags | itd->trailer_len;
-	}
+	fceof_saidx |= itd->sa_idx;
+	type_tucmd |= itd->flags | itd->trailer_len;
 
 	ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, fceof_saidx, type_tucmd, 0);
 }
-- 
2.7.4

