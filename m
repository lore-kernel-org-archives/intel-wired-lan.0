From: Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Tue, 23 Jan 2018 13:28:41 +0300
Subject: [Intel-wired-lan] [PATCH] igb: Do not call netif_device_detach()
 when PCIe link goes missing
Message-ID: <20180123102841.9350-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When the driver notices that PCIe link is gone by reading 0xffffffff
from a register it clears hw->hw_addr and then calls netif_device_detach().
This happens when the PCIe device is physically unplugged for example
the user disconnected the Thunderbolt cable.

However, netif_device_detach() prevents netif_unregister() from bringing
the device down properly including tearing down MSI-X vectors. This
triggers following crash during the driver removal:

  igb 0000:0b:00.0 enp11s0f0: PCIe link lost, device now detached
  ------------[ cut here ]------------
  kernel BUG at drivers/pci/msi.c:352!
  invalid opcode: 0000 [#1] PREEMPT SMP PTI
  ...
  Call Trace:
   pci_disable_msix+0xc9/0xf0
   igb_reset_interrupt_capability+0x58/0x60 [igb]
   igb_remove+0x90/0x100 [igb]
   pci_device_remove+0x31/0xa0
   device_release_driver_internal+0x152/0x210
   pci_stop_bus_device+0x78/0xa0
   pci_stop_bus_device+0x38/0xa0
   pci_stop_bus_device+0x38/0xa0
   pci_stop_bus_device+0x26/0xa0
   pci_stop_bus_device+0x38/0xa0
   pci_stop_and_remove_bus_device+0x9/0x20
   trim_stale_devices+0xee/0x130
   ? _raw_spin_unlock_irqrestore+0xf/0x30
   trim_stale_devices+0x8f/0x130
   ? _raw_spin_unlock_irqrestore+0xf/0x30
   trim_stale_devices+0xa1/0x130
   ? get_slot_status+0x8b/0xc0
   acpiphp_check_bridge.part.7+0xf9/0x140
   acpiphp_hotplug_notify+0x170/0x1f0
   ...

To prevent the crash do not call netif_device_detach() in igb_rd32().
This should be fine because hw->hw_addr is set to NULL preventing future
hardware access of the now missing device.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198181
Reported-by: Ferenc Boldog <ferenc.boldog@gmail.com>
Reported-by: Nikolay Bogoychev <nheart@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index c208753ff5b7..b1de866e70b2 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -774,8 +774,7 @@ u32 igb_rd32(struct e1000_hw *hw, u32 reg)
 	if (!(~value) && (!reg || !(~readl(hw_addr)))) {
 		struct net_device *netdev = igb->netdev;
 		hw->hw_addr = NULL;
-		netif_device_detach(netdev);
-		netdev_err(netdev, "PCIe link lost, device now detached\n");
+		netdev_err(netdev, "PCIe link lost\n");
 	}
 
 	return value;
-- 
2.15.1

