From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 12 Jan 2021 17:37:53 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: acquire VSI pointer only after
 VF is initialized
In-Reply-To: <20201130131257.28856-1-sassmann@kpanic.de>
References: <20201130131257.28856-1-sassmann@kpanic.de>
Message-ID: <BN6PR11MB15729586015B697F769A2426ABAA0@BN6PR11MB1572.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Stefan Assmann
> Sent: poniedzia?ek, 30 listopada 2020 14:13
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH] i40e: acquire VSI pointer only after VF is
> initialized
> 
> This change simplifies the VF initialization check and also minimizes the delay
> between acquiring the VSI pointer and using it. As known by the commit
> being fixed, there is a risk of the VSI pointer getting changed. Therefore
> minimize the delay between getting and using the pointer.
> 
> Fixes: 9889707b06ac ("i40e: Fix crash caused by stress setting of VF MAC
> addresses")
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 729c4f0d5ac5..bf6034c3a6ea 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -4046,20 +4046,16 @@ int i40e_ndo_set_vf_mac(struct net_device
> *netdev, int vf_id, u8 *mac)
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
>  	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) { @@ -4068,6
> +4064,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id,
> u8 *mac)
>  		ret = -EAGAIN;
>  		goto error_param;
>  	}
> +	vsi = pf->vsi[vf->lan_vsi_idx];
> 
>  	if (is_multicast_ether_addr(mac)) {
>  		dev_err(&pf->pdev->dev,

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

