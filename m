From: Mauro Rodrigues <maurosr@linux.vnet.ibm.com>
Date: Mon, 23 Apr 2018 15:51:43 -0300
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix free irq process when
 removing device due to PCI Errors]
In-Reply-To: <f7422ddf-db30-14e6-efa9-14c4e14d9eaa@gpiccoli.net>
References: <20180418175613.GA2121@korriban>
 <f7422ddf-db30-14e6-efa9-14c4e14d9eaa@gpiccoli.net>
Message-ID: <20180423185143.GA7337@korriban>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Guilherme, thanks for your review, answer to your suggestion is
inline.

On Wed, Apr 18, 2018 at 03:14:14PM -0300, Guilherme G. Piccoli wrote:
> Thanks Mauro, nice fix! A minor suggestion below.
> Other than that, feel free to add:
> 
> Reviewed-by: Guilherme G. Piccoli <kernel@gpiccoli.net>
> 
> >
> > [...]
> >diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> >index afadba9..d170de8 100644
> >--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> >+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> >@@ -6679,7 +6679,8 @@ int ixgbe_close(struct net_device *netdev)
> >
> >  	ixgbe_ptp_stop(adapter);
> >
> >-	if (netif_device_present(netdev))
> >+	if (netif_device_present(netdev) ||
> >+	    adapter->pdev->error_state == pci_channel_io_perm_failure)
> 
> How about using pci_channel_offline() here instead of manually
> checking the error_state flag? It's a minor though heheh

So the thing here is that I want to proceed through out this path only
when the device is in pci_channle_io_perm_failure. Looking at the
function you suggested there is a third state that would return True
here which is pci_channel_io_frozen, it's also a concern that this list
of possible values can increase eventually as well, so I would rather
keep this as is.

I've just realized that I need to fix this in ixgbevf as well, so I'll
send a second version of this one soon.

Thanks,

Mauro
> 
> Cheers,
> 
> 
> Guilherme
> 
> >  		ixgbe_close_suspend(adapter);
> >
> >  	ixgbe_fdir_filter_exit(adapter);
> >
> 

