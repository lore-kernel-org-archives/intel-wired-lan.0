From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 09:37:52 -0600
Subject: [Intel-wired-lan] [PATCH 4/7] igbvf: Use smp_rmb rather than
 read_barrier_depends
In-Reply-To: <1510846675-15169-1-git-send-email-brking@linux.vnet.ibm.com>
References: <1510846675-15169-1-git-send-email-brking@linux.vnet.ibm.com>
Message-ID: <1510846675-15169-5-git-send-email-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The original issue being fixed in this patch was seen with the ixgbe
driver, but the same issue exists with igbvf as well, as the code is
very similar. read_barrier_depends is not sufficient to ensure
loads following it are not speculatively loaded out of order
by the CPU, which can result in stale data being loaded, causing
potential system crashes.

Cc: stable<stable@vger.kernel.org>
Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 1ed5569..6f5888b 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -810,7 +810,7 @@ static bool igbvf_clean_tx_irq(struct igbvf_ring *tx_ring)
 			break;
 
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
 
 		/* if DD is not set pending work has not been completed */
 		if (!(eop_desc->wb.status & cpu_to_le32(E1000_TXD_STAT_DD)))
-- 
1.8.3.1

