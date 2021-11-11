From: cgel.zte@gmail.com <cgel.zte@gmail.com>
Date: Thu, 11 Nov 2021 09:07:12 +0000
Subject: [Intel-wired-lan] [PATCH linux-next] e1000e: Remove useless
 variables
Message-ID: <20211111090712.158901-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: luo penghao <luo.penghao@zte.com.cn>

This variable is not used in the function.

The clang_analyzer complains as follows:

drivers/net/ethernet/intel/e1000e/netdev.c:916:19 warning
drivers/net/ethernet/intel/e1000e/netdev.c:1310:19 warning

Value stored to 'hw' during its initialization is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index ebcb2a3..8a79681 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -914,7 +914,6 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 	struct e1000_adapter *adapter = rx_ring->adapter;
 	struct net_device *netdev = adapter->netdev;
 	struct pci_dev *pdev = adapter->pdev;
-	struct e1000_hw *hw = &adapter->hw;
 	union e1000_rx_desc_extended *rx_desc, *next_rxd;
 	struct e1000_buffer *buffer_info, *next_buffer;
 	u32 length, staterr;
@@ -1308,7 +1307,6 @@ static bool e1000_clean_rx_irq_ps(struct e1000_ring *rx_ring, int *work_done,
 				  int work_to_do)
 {
 	struct e1000_adapter *adapter = rx_ring->adapter;
-	struct e1000_hw *hw = &adapter->hw;
 	union e1000_rx_desc_packet_split *rx_desc, *next_rxd;
 	struct net_device *netdev = adapter->netdev;
 	struct pci_dev *pdev = adapter->pdev;
-- 
2.15.2


