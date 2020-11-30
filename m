From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 30 Nov 2020 11:31:54 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: acquire VSI pointer only after
 VF is initialized
In-Reply-To: <20201130131257.28856-1-sassmann@kpanic.de>
References: <20201130131257.28856-1-sassmann@kpanic.de>
Message-ID: <263c6e31-62a3-e73d-6f63-23216b15fdd0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 11/30/2020 5:12 AM, Stefan Assmann wrote:
> This change simplifies the VF initialization check and also minimizes
> the delay between acquiring the VSI pointer and using it. As known by
> the commit being fixed, there is a risk of the VSI pointer getting
> changed. Therefore minimize the delay between getting and using the
> pointer.
> 
> Fixes: 9889707b06ac ("i40e: Fix crash caused by stress setting of VF MAC addresses")
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>

Ok.

> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 729c4f0d5ac5..bf6034c3a6ea 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -4046,20 +4046,16 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
>  		goto error_param;
>  
>  	vf = &pf->vf[vf_id];
> -	vsi = pf->vsi[vf->lan_vsi_idx];
>  
>  	/* When the VF is resetting wait until it is done.
>  	 * It can take up to 200 milliseconds,
>  	 * but wait for up to 300 milliseconds to be safe.
> -	 * If the VF is indeed in reset, the vsi pointer has
> -	 * to show on the newly loaded vsi under pf->vsi[id].
> +	 * Acquire the vsi pointer only after the VF has been
> +	 * properly initialized.
>  	 */
>  	for (i = 0; i < 15; i++) {
> -		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
> -			if (i > 0)
> -				vsi = pf->vsi[vf->lan_vsi_idx];
> +		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
>  			break;
> -		}
>  		msleep(20);
>  	}
>  	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
> @@ -4068,6 +4064,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
>  		ret = -EAGAIN;
>  		goto error_param;
>  	}
> +	vsi = pf->vsi[vf->lan_vsi_idx];
>  

Yea, this makes more sense to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  	if (is_multicast_ether_addr(mac)) {
>  		dev_err(&pf->pdev->dev,
> 
