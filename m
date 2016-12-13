From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 13 Dec 2016 20:51:26 +0000
Subject: [Intel-wired-lan] [PATCH net v2] igb: re-assign hw address
 pointer	on reset after PCI error
In-Reply-To: <1478803603-30306-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1478803603-30306-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81FE9879@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Guilherme G. Piccoli
> Sent: Thursday, November 10, 2016 10:47 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; gpiccoli at linux.vnet.ibm.com
> Subject: [Intel-wired-lan] [PATCH net v2] igb: re-assign hw address pointer on
> reset after PCI error
> 
> Whenever the igb driver detects the result of a read operation returns
> a value composed only by F's (like 0xFFFFFFFF), it will detach the
> net_device, clear the hw_addr pointer and warn to the user that adapter's
> link is lost - those steps happen on igb_rd32().
> 
> In case a PCI error happens on Power architecture, there's a recovery
> mechanism called EEH, that will reset the PCI slot and call driver's
> handlers to reset the adapter and network functionality as well.
> 
> We observed that once hw_addr is NULL after the error is detected on
> igb_rd32(), it's never assigned back, so in the process of resetting
> the network functionality we got a NULL pointer dereference in both
> igb_configure_tx_ring() and igb_configure_rx_ring(). In order to avoid
> such bug, this patch re-assigns the hw_addr value in the slot_reset
> handler.
> 
> Reported-by: Anthony H. Thai <ahthai@us.ibm.com>
> Reported-by: Harsha Thyagaraja <hathyaga@in.ibm.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 5 +++++
>  1 file changed, 5 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
