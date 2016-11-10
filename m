From: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Date: Thu, 10 Nov 2016 16:46:43 -0200
Subject: [Intel-wired-lan] [PATCH net v2] igb: re-assign hw address pointer
	on reset after PCI error
Message-ID: <1478803603-30306-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Whenever the igb driver detects the result of a read operation returns
a value composed only by F's (like 0xFFFFFFFF), it will detach the
net_device, clear the hw_addr pointer and warn to the user that adapter's
link is lost - those steps happen on igb_rd32().

In case a PCI error happens on Power architecture, there's a recovery
mechanism called EEH, that will reset the PCI slot and call driver's
handlers to reset the adapter and network functionality as well.

We observed that once hw_addr is NULL after the error is detected on
igb_rd32(), it's never assigned back, so in the process of resetting
the network functionality we got a NULL pointer dereference in both
igb_configure_tx_ring() and igb_configure_rx_ring(). In order to avoid
such bug, this patch re-assigns the hw_addr value in the slot_reset
handler.

Reported-by: Anthony H. Thai <ahthai@us.ibm.com>
Reported-by: Harsha Thyagaraja <hathyaga@in.ibm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index edc9a6a..136ee9e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7878,6 +7878,11 @@ static pci_ers_result_t igb_io_slot_reset(struct pci_dev *pdev)
 		pci_enable_wake(pdev, PCI_D3hot, 0);
 		pci_enable_wake(pdev, PCI_D3cold, 0);
 
+		/* In case of PCI error, adapter lose its HW address
+		 * so we should re-assign it here.
+		 */
+		hw->hw_addr = adapter->io_addr;
+
 		igb_reset(adapter);
 		wr32(E1000_WUS, ~0);
 		result = PCI_ERS_RESULT_RECOVERED;
-- 
2.1.0

