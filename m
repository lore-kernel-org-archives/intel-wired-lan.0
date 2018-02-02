From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 2 Feb 2018 23:25:37 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Do not call
 netif_device_detach() when PCIe link goes missing
In-Reply-To: <20180123102841.9350-1-mika.westerberg@linux.intel.com>
References: <20180123102841.9350-1-mika.westerberg@linux.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7D1013@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Mika Westerberg
> Sent: Tuesday, January 23, 2018 2:29 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Ferenc Boldog <ferenc.boldog@gmail.com>; Nikolay Bogoychev
> <nheart@gmail.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Subject: [PATCH] igb: Do not call netif_device_detach() when PCIe link goes
> missing
> 
> When the driver notices that PCIe link is gone by reading 0xffffffff
> from a register it clears hw->hw_addr and then calls netif_device_detach().
> This happens when the PCIe device is physically unplugged for example
> the user disconnected the Thunderbolt cable.
> 
> However, netif_device_detach() prevents netif_unregister() from bringing
> the device down properly including tearing down MSI-X vectors. This
> triggers following crash during the driver removal:
> 
>   igb 0000:0b:00.0 enp11s0f0: PCIe link lost, device now detached
>   ------------[ cut here ]------------
>   kernel BUG at drivers/pci/msi.c:352!
>   invalid opcode: 0000 [#1] PREEMPT SMP PTI
>   ...
>   Call Trace:
>    pci_disable_msix+0xc9/0xf0
>    igb_reset_interrupt_capability+0x58/0x60 [igb]
>    igb_remove+0x90/0x100 [igb]
>    pci_device_remove+0x31/0xa0
>    device_release_driver_internal+0x152/0x210
>    pci_stop_bus_device+0x78/0xa0
>    pci_stop_bus_device+0x38/0xa0
>    pci_stop_bus_device+0x38/0xa0
>    pci_stop_bus_device+0x26/0xa0
>    pci_stop_bus_device+0x38/0xa0
>    pci_stop_and_remove_bus_device+0x9/0x20
>    trim_stale_devices+0xee/0x130
>    ? _raw_spin_unlock_irqrestore+0xf/0x30
>    trim_stale_devices+0x8f/0x130
>    ? _raw_spin_unlock_irqrestore+0xf/0x30
>    trim_stale_devices+0xa1/0x130
>    ? get_slot_status+0x8b/0xc0
>    acpiphp_check_bridge.part.7+0xf9/0x140
>    acpiphp_hotplug_notify+0x170/0x1f0
>    ...
> 
> To prevent the crash do not call netif_device_detach() in igb_rd32().
> This should be fine because hw->hw_addr is set to NULL preventing future
> hardware access of the now missing device.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=198181
> Reported-by: Ferenc Boldog <ferenc.boldog@gmail.com>
> Reported-by: Nikolay Bogoychev <nheart@gmail.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
