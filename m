From: Duyck, Alexander H <alexander.h.duyck@intel.com>
Date: Tue, 15 Nov 2016 16:36:15 +0000
Subject: [Intel-wired-lan] [PATCH] igb: close/suspend race in
 netif_device_detach
In-Reply-To: <1479225683-24889-1-git-send-email-todd.fujinaka@intel.com>
References: <1479225683-24889-1-git-send-email-todd.fujinaka@intel.com>
Message-ID: <1479227773.681.91.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-11-15 at 08:01 -0800, Todd Fujinaka wrote:
> Similar to ixgbe, when an interface is part of a namespace it is
> possible that igb_close() may be called while __igb_shutdown() is
> running which ends up in a double free WARN and/or a BUG in
> free_msi_irqs().
> 
> Extend the rtnl_lock() to protect the call to netif_device_detach() and
> igb_clear_interrupt_scheme() in __igb_shutdown() and check for
> netif_device_present() to avoid calling igb_clear_interrupt_scheme() a
> second time in igb_close() and igb_remove().
> 
> Also extend the rtnl lock in igb_resume() to netif_device_attach().
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 4feca69..c040cc7 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2930,7 +2930,10 @@ static void igb_remove(struct pci_dev *pdev)
>  
>  	unregister_netdev(netdev);
>  
> -	igb_clear_interrupt_scheme(adapter);
> +	rtnl_lock();
> +	if (netif_device_present(netdev))
> +		igb_clear_interrupt_scheme(adapter);
> +	rtnl_unlock();
>  
>  	pci_iounmap(pdev, adapter->io_addr);
>  	if (hw->flash_address)

This part of the patch isn't necessary. ?The call to unregister_netdev
will take the rtnl lock and free the netdev so you can't race against
anything anyway.

The rest of the changes below look good.

> @@ -3275,7 +3278,9 @@ static int __igb_close(struct net_device *netdev, bool suspending)
>  
>  int igb_close(struct net_device *netdev)
>  {
> -	return __igb_close(netdev, false);
> +	if (netif_device_present(netdev))
> +		return __igb_close(netdev, false);
> +	return 0;
>  }
>  
>  /**
> @@ -7537,6 +7542,7 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
>  	int retval = 0;
>  #endif
>  
> +	rtnl_lock();
>  	netif_device_detach(netdev);
>  
>  	if (netif_running(netdev))
> @@ -7545,6 +7551,7 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
>  	igb_ptp_suspend(adapter);
>  
>  	igb_clear_interrupt_scheme(adapter);
> +	rtnl_unlock();
>  
>  #ifdef CONFIG_PM
>  	retval = pci_save_state(pdev);
> @@ -7663,16 +7670,15 @@ static int igb_resume(struct device *dev)
>  
>  	wr32(E1000_WUS, ~0);
>  
> -	if (netdev->flags & IFF_UP) {
> -		rtnl_lock();
> +	rtnl_lock();
> +	if (!err && netif_running(netdev))
>  		err = __igb_open(netdev, true);
> -		rtnl_unlock();
> -		if (err)
> -			return err;
> -	}
>  
> -	netif_device_attach(netdev);
> -	return 0;
> +	if (!err)
> +		netif_device_attach(netdev);
> +	rtnl_unlock();
> +
> +	return err;
>  }
>  
>  static int igb_runtime_idle(struct device *dev)
