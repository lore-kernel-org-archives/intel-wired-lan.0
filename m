From: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
Date: Wed, 18 Dec 2019 09:53:08 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: fix missing cpu_to_le64 on
 buffer_addr
Message-ID: <20191218095308.2397408-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following warning suggests there is a missing cpu_to_le64() in
the e1000_flush_tx_ring() function (it is also the behaviour
elsewhere in the driver to do cpu_to_le64() on the buffer_addr
when setting it)

drivers/net/ethernet/intel/e1000e/netdev.c:3813:30: warning: incorrect type in assignment (different base types)
drivers/net/ethernet/intel/e1000e/netdev.c:3813:30:    expected restricted __le64 [usertype] buffer_addr
drivers/net/ethernet/intel/e1000e/netdev.c:3813:30:    got unsigned long long [usertype] dma

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: intel-wired-lan at lists.osuosl.org
Cc: netdev at vger.kernel.org
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index fe7997c18a10..b317ac024819 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3810,7 +3810,7 @@ static void e1000_flush_tx_ring(struct e1000_adapter *adapter)
 	tdt = er32(TDT(0));
 	BUG_ON(tdt != tx_ring->next_to_use);
 	tx_desc =  E1000_TX_DESC(*tx_ring, tx_ring->next_to_use);
-	tx_desc->buffer_addr = tx_ring->dma;
+	tx_desc->buffer_addr = cpu_to_le64(tx_ring->dma);
 
 	tx_desc->lower.data = cpu_to_le32(txd_lower | size);
 	tx_desc->upper.data = 0;
-- 
2.24.0

