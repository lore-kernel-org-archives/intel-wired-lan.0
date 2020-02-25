From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Tue, 25 Feb 2020 19:16:36 +0000
Subject: [Intel-wired-lan] [PATCH][next] ice: remove redundant
 assignment to pointer vsi
In-Reply-To: <20200222171054.171505-1-colin.king@canonical.com>
References: <20200222171054.171505-1-colin.king@canonical.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A184010B0500CE@ORSMSX113.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Colin King
> Sent: Saturday, February 22, 2020 9:11 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S . Miller
> <davem@davemloft.net>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH][next] ice: remove redundant assignment to
> pointer vsi
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer vsi is being re-assigned a value that is never read,
> the assignment is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")

What version of coverity and what options were used?

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> index 169b72a94b9d..2c8e334c47a0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> @@ -2191,7 +2191,6 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8
> *msg)
>  		set_bit(vf_q_id, vf->rxq_ena);
>  	}
> 
> -	vsi = pf->vsi[vf->lan_vsi_idx];
>  	q_map = vqs->tx_queues;
>  	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_BASE_QS_PER_VF) {
>  		if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
> --
> 2.25.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
