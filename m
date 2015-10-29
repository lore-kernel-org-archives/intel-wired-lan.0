From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Thu, 29 Oct 2015 19:12:25 +0000
Subject: [Intel-wired-lan] [next PATCH 3/5] fm10k: Cleanup exception
 handling for changing queues
In-Reply-To: <20151027235924.30048.24399.stgit@localhost.localdomain>
References: <20151027235341.30048.46286.stgit@localhost.localdomain>
 <20151027235924.30048.24399.stgit@localhost.localdomain>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC6F428@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, October 27, 2015 4:59 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 3/5] fm10k: Cleanup exception
> handling for changing queues
> 
> This patch is meant to cleanup the exception handling for the paths where
> we reset the interrupts and then reconfigure them.  In all of these paths
> we had very different levels of exception handling.  I have updated the
> driver so that all of the paths should result in a similar state if we
> fail.
> 
> Specifically the driver will now unload the mailbox interrupt, free the
> queue vectors and MSI-X, and then detach the interface.
> 
> In addition for any of the PCIe related resets I have added a check with
> the hw_ready function to just make sure the registers are in a readable
> state prior to reopening the interface.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |   17 +++++--
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c    |   55
> ++++++++++++++++++-----
>  2 files changed, 55 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
> index 38fe2d8c8388..4855686d2b4e 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
> @@ -1176,19 +1176,28 @@ int fm10k_setup_tc(struct net_device *dev, u8
> tc)
> 
>  	err = fm10k_init_queueing_scheme(interface);
>  	if (err)
> -		return err;
> +		goto err_queueing_scheme;
> 
>  	err = fm10k_mbx_request_irq(interface);
>  	if (err)
> -		return err;
> +		goto err_mbx_irq;
> 
> -	if (netif_running(dev))
> -		fm10k_open(dev);
> +	err = netif_running(dev) ? fm10k_open(dev) : 0;
> +	if (err)
> +		goto err_open;
> 
>  	/* flag to indicate SWPRI has yet to be updated */
>  	interface->flags |= FM10K_FLAG_SWPRI_CONFIG;
> 
>  	return 0;
> +err_open:
> +	fm10k_mbx_free_irq(interface);
> +err_mbx_irq:
> +	fm10k_clear_queueing_scheme(interface);
> +err_queueing_scheme:
> +	netif_device_detach(dev);
> +
> +	return err;
>  }
> 
>  static int fm10k_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> index 15327d274d72..7b33cddfc6be 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> @@ -185,7 +185,13 @@ static void fm10k_reinit(struct fm10k_intfc
> *interface)
>  	}
> 
>  	/* reassociate interrupts */
> -	fm10k_mbx_request_irq(interface);
> +	err = fm10k_mbx_request_irq(interface);
> +	if (err)
> +		goto err_mbx_irq;
> +
> +	err = fm10k_hw_ready(interface);
> +	if (err)
> +		goto err_open;
> 
>  	/* update hardware address for VFs if perm_addr has changed */
>  	if (hw->mac.type == fm10k_mac_vf) {
> @@ -205,14 +211,23 @@ static void fm10k_reinit(struct fm10k_intfc
> *interface)
>  	/* reset clock */
>  	fm10k_ts_reset(interface);
> 
> -	if (netif_running(netdev))
> -		fm10k_open(netdev);
> -
> +	err = netif_running(netdev) ? fm10k_open(netdev) : 0;
> +	if (err)
> +		goto err_open;
> +

Jeff, the above blank-line separator line in Alex' original submission looks fine here but
in your next-queue tree dev-queue branch there is additional whitespace (2 tabs).
How did that happen?

>  	fm10k_iov_resume(interface->pdev);
> 
> +	rtnl_unlock();
> +
> +	clear_bit(__FM10K_RESETTING, &interface->state);
> +
> +	return;
> +err_open:
> +	fm10k_mbx_free_irq(interface);
> +err_mbx_irq:
> +	fm10k_clear_queueing_scheme(interface);
>  reinit_err:
> -	if (err)
> -		netif_device_detach(netdev);
> +	netif_device_detach(netdev);
> 
>  	rtnl_unlock();
> 
> @@ -2130,16 +2145,22 @@ static int fm10k_resume(struct pci_dev *pdev)
>  	rtnl_lock();
> 
>  	err = fm10k_init_queueing_scheme(interface);
> -	if (!err) {
> -		fm10k_mbx_request_irq(interface);
> -		if (netif_running(netdev))
> -			err = fm10k_open(netdev);
> -	}
> +	if (err)
> +		goto err_queueing_scheme;
> 
> -	rtnl_unlock();
> +	err = fm10k_mbx_request_irq(interface);
> +	if (err)
> +		goto err_mbx_irq;
> 
> +	err = fm10k_hw_ready(interface);
>  	if (err)
> -		return err;
> +		goto err_open;
> +
> +	err = netif_running(netdev) ? fm10k_open(netdev) : 0;
> +	if (err)
> +		goto err_open;
> +

Ditto here

> +	rtnl_unlock();
> 
>  	/* assume host is not ready, to prevent race with watchdog in case
> we
>  	 * actually don't have connection to the switch
> @@ -2157,6 +2178,14 @@ static int fm10k_resume(struct pci_dev *pdev)
>  	netif_device_attach(netdev);
> 
>  	return 0;
> +err_open:
> +	fm10k_mbx_free_irq(interface);
> +err_mbx_irq:
> +	fm10k_clear_queueing_scheme(interface);
> +err_queueing_scheme:
> +	rtnl_unlock();
> +
> +	return err;
>  }
> 
>  /**
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
