From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 6 Aug 2021 07:26:53 +0000
Subject: [Intel-wired-lan] [PATCH net-next 13/15] iavf: Set RSS LUT and
 key in reset handle path
In-Reply-To: <20210604165335.33329-13-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
 <20210604165335.33329-13-anthony.l.nguyen@intel.com>
Message-ID: <DM8PR11MB5621A235D39CEFA250B87D47ABF39@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> 
> iavf driver should set RSS LUT and key unconditionally in reset path.
> Currently, the driver does not do that. This patch fixes this issue.
> 
> Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index e7b9c64db3b5..892aa22b39da 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1534,11 +1534,6 @@ static int iavf_reinit_interrupt_scheme(struct
> iavf_adapter *adapter)
>  	set_bit(__IAVF_VSI_DOWN, adapter->vsi.state);
> 
>  	iavf_map_rings_to_vectors(adapter);
> -
> -	if (RSS_AQ(adapter))
> -		adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_RSS;
> -	else
> -		err = iavf_init_rss(adapter);
>  err:
>  	return err;
>  }
> @@ -2233,6 +2228,14 @@ static void iavf_reset_task(struct work_struct
> *work)
>  			goto reset_err;
>  	}
> 
> +	if (RSS_AQ(adapter)) {
> +		adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_RSS;
> +	} else {
> +		err = iavf_init_rss(adapter);
> +		if (err)
> +			goto reset_err;
> +	}
> +
>  	adapter->aq_required |= IAVF_FLAG_AQ_GET_CONFIG;
>  	adapter->aq_required |= IAVF_FLAG_AQ_MAP_VECTORS;
> 
> --
> 2.20.1

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
