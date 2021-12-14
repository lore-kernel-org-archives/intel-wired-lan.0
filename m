From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue, 14 Dec 2021 13:53:25 +0100
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix incorrect netdev's
 real number of RX/TX queues
In-Reply-To: <20211214101016.5959-1-jedrzej.jagielski@intel.com>
References: <20211214101016.5959-1-jedrzej.jagielski@intel.com>
Message-ID: <20211214125325.1081251-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Tue, 14 Dec 2021 10:10:16 +0000

> There was a wrong queues representation in sysfs during
> driver's reinitialization in case of online cpus number is
> less than combined queues. It was caused by stopped
> NetworkManager, which is responsible for calling vsi_open
> function during driver's initialization.
> In specific situation (ex. 12 cpus online) there were 16 queues
> in /sys/class/net/<iface>/queues. In case of modifying queues with
> value higher, than number of online cpus, then it caused write
> errors and other errors.
> Add updating of sysfs's queues representation during driver
> initialization.
> 
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Lukasz Cieplicki <lukaszx.cieplicki@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 22 +++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 5322f44ed6ce..850264c4285b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -14074,6 +14074,25 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  	return NULL;
>  }
>  
> +/**
> + * i40e_netif_set_realnum_tx_rx_queues - Update number of tx/rx queues
> + * @vsi: vsi structure
> + *
> + * This updates netdev's number of tx/rx queues
> + *
> + * Returns status of setting tx/rx queues
> + **/
> +static int i40e_netif_set_realnum_tx_rx_queues(struct i40e_vsi *vsi)
> +{
> +	netif_set_real_num_rx_queues(
> +		vsi->netdev,
> +		vsi->num_queue_pairs);
> +
> +	return netif_set_real_num_tx_queues(
> +		vsi->netdev,
> +		vsi->num_queue_pairs);
> +}

CHECK: Lines should not end with a '('
#393: FILE: drivers/net/ethernet/intel/i40e/i40e_main.c:14087:
+	netif_set_real_num_rx_queues(

CHECK: Lines should not end with a '('
#397: FILE: drivers/net/ethernet/intel/i40e/i40e_main.c:14091:
+	return netif_set_real_num_tx_queues(

The first parameter (vsi->netdev) fits into 79/80 chars, so only
the second one should be wrapped.

Please run `checkpatch --codespell --strict` on every patch you
create.

> +
>  /**
>   * i40e_vsi_setup - Set up a VSI by a given type
>   * @pf: board private structure
> @@ -14203,6 +14222,9 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>  	case I40E_VSI_MAIN:
>  	case I40E_VSI_VMDQ2:
>  		ret = i40e_config_netdev(vsi);
> +		if (ret)
> +			goto err_netdev;
> +		ret = i40e_netif_set_realnum_tx_rx_queues(vsi);
>  		if (ret)
>  			goto err_netdev;
>  		ret = register_netdev(vsi->netdev);
> -- 
> 2.27.0

Thanks,
Al
