From: Guilherme G. Piccoli <kernel@gpiccoli.net>
Date: Wed, 18 Apr 2018 15:14:14 -0300
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix free irq process when
 removing device due to PCI Errors]
In-Reply-To: <20180418175613.GA2121@korriban>
References: <20180418175613.GA2121@korriban>
Message-ID: <f7422ddf-db30-14e6-efa9-14c4e14d9eaa@gpiccoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks Mauro, nice fix! A minor suggestion below.
Other than that, feel free to add:

Reviewed-by: Guilherme G. Piccoli <kernel@gpiccoli.net>

> 
 > [...]
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index afadba9..d170de8 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -6679,7 +6679,8 @@ int ixgbe_close(struct net_device *netdev)
> 
>   	ixgbe_ptp_stop(adapter);
> 
> -	if (netif_device_present(netdev))
> +	if (netif_device_present(netdev) ||
> +	    adapter->pdev->error_state == pci_channel_io_perm_failure)

How about using pci_channel_offline() here instead of manually
checking the error_state flag? It's a minor though heheh

Cheers,


Guilherme

>   		ixgbe_close_suspend(adapter);
> 
>   	ixgbe_fdir_filter_exit(adapter);
> 
