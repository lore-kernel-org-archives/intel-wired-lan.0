From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 6 Jul 2021 08:05:24 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: improve locking of
 mac_filter_hash
In-Reply-To: <20210304093430.42421-1-sassmann@kpanic.de>
References: <20210304093430.42421-1-sassmann@kpanic.de>
Message-ID: <CY4PR11MB157684F676290E6B6544F961AB1B9@CY4PR11MB1576.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Stefan Assmann
> Sent: czwartek, 4 marca 2021 10:35
> To: intel-wired-lan at lists.osuosl.org
> Cc: pabeni at redhat.com; netdev at vger.kernel.org; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH] i40e: improve locking of mac_filter_hash
> 
> i40e_config_vf_promiscuous_mode() calls
> i40e_getnum_vf_vsi_vlan_filters() without acquiring the
> mac_filter_hash_lock spinlock.
> 
> This is unsafe because mac_filter_hash may get altered in another thread
> while i40e_getnum_vf_vsi_vlan_filters() traverses the hashes.
> 
> Simply adding the spinlock in i40e_getnum_vf_vsi_vlan_filters() is not
> possible as it already gets called in i40e_get_vlan_list_sync() with the
> spinlock held. Therefore adding a wrapper that acquires the spinlock and call
> the correct function where appropriate.
> 
> Fixes: 37d318d7805f ("i40e: Remove scheduling while atomic possibility")
> Fix-suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 23 ++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 1b6ec9be155a..61d3e9a00f65 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -1101,12 +1101,12 @@ static int i40e_quiesce_vf_pci(struct i40e_vf *vf)
> }
> 
>  /**
> - * i40e_getnum_vf_vsi_vlan_filters
> + * __i40e_getnum_vf_vsi_vlan_filters
>   * @vsi: pointer to the vsi
>   *
>   * called to get the number of VLANs offloaded on this VF
>   **/
> -static int i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi)
> +static int __i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi)
>  {
>  	struct i40e_mac_filter *f;
>  	u16 num_vlans = 0, bkt;
> @@ -1119,6 +1119,23 @@ static int i40e_getnum_vf_vsi_vlan_filters(struct
> i40e_vsi *vsi)
>  	return num_vlans;
>  }
> 
> +/**
> + * i40e_getnum_vf_vsi_vlan_filters
> + * @vsi: pointer to the vsi
> + *
> + * wrapper for __i40e_getnum_vf_vsi_vlan_filters() with spinlock held
> +**/ static int i40e_getnum_vf_vsi_vlan_filters(struct i40e_vsi *vsi) {
> +	int num_vlans;
> +
> +	spin_lock_bh(&vsi->mac_filter_hash_lock);
> +	num_vlans = __i40e_getnum_vf_vsi_vlan_filters(vsi);
> +	spin_unlock_bh(&vsi->mac_filter_hash_lock);
> +
> +	return num_vlans;
> +}
> +
>  /**
>   * i40e_get_vlan_list_sync
>   * @vsi: pointer to the VSI
> @@ -1136,7 +1153,7 @@ static void i40e_get_vlan_list_sync(struct i40e_vsi
> *vsi, u16 *num_vlans,
>  	int bkt;
> 
>  	spin_lock_bh(&vsi->mac_filter_hash_lock);
> -	*num_vlans = i40e_getnum_vf_vsi_vlan_filters(vsi);
> +	*num_vlans = __i40e_getnum_vf_vsi_vlan_filters(vsi);
>  	*vlan_list = kcalloc(*num_vlans, sizeof(**vlan_list), GFP_ATOMIC);
>  	if (!(*vlan_list))
>  		goto err;
> --
> 2.29.2

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

