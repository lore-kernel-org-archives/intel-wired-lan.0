From: Jonathan Toppins <jtoppins@redhat.com>
Date: Fri, 28 Jan 2022 09:59:21 -0500
Subject: [Intel-wired-lan] [PATCH net] ice: Avoid RTNL lock when
 re-creating auxiliary device
In-Reply-To: <20220121002756.1105566-1-david.m.ertman@intel.com>
References: <20220121002756.1105566-1-david.m.ertman@intel.com>
Message-ID: <afdb2b42-84bf-ae5e-abbb-808c4e669f58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/20/22 19:27, Dave Ertman wrote:
> If a call to re-create the auxiliary device happens in a context that has
> already taken the RTNL lock, then the call flow that recreates auxiliary
> device can hang if there is another attempt to claim the RTNL lock by the
> auxiliary driver.
> 
> To avoid this, any call to re-create auxiliary devices that comes from
> an source that is holding the RTNL lock (e.g. netdev notifier when
> interface exits a bond) should execute in a separate thread.  To
> accomplish this, add a flag to the PF that will be evaluated in the
> service task and dealt with there.
> 
> Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>

Reviewed-by: Jonathan Toppins <jtoppins@redhat.com>

---
This looks like it will fix the issue and we tested internally and did 
not see the issue.

> ---
>   drivers/net/ethernet/intel/ice/ice.h      | 3 ++-
>   drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 4e16d185077d..a9fa701aaa95 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -483,6 +483,7 @@ enum ice_pf_flags {
>   	ICE_FLAG_VF_TRUE_PROMISC_ENA,
>   	ICE_FLAG_MDD_AUTO_RESET_VF,
>   	ICE_FLAG_LINK_LENIENT_MODE_ENA,
> +	ICE_FLAG_PLUG_AUX_DEV,
>   	ICE_PF_FLAGS_NBITS		/* must be last */
>   };
>   
> @@ -887,7 +888,7 @@ static inline void ice_set_rdma_cap(struct ice_pf *pf)
>   	if (pf->hw.func_caps.common_cap.rdma && pf->num_rdma_msix) {
>   		set_bit(ICE_FLAG_RDMA_ENA, pf->flags);
>   		set_bit(ICE_FLAG_AUX_ENA, pf->flags);
> -		ice_plug_aux_dev(pf);
> +		set_bit(ICE_FLAG_PLUG_AUX_DEV, pf->flags);
>   	}
>   }
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 30814435f779..b948a865f359 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -2253,6 +2253,9 @@ static void ice_service_task(struct work_struct *work)
>   		return;
>   	}
>   
> +	if (test_and_clear_bit(ICE_FLAG_PLUG_AUX_DEV, pf->flags))
> +		ice_plug_aux_dev(pf);
> +
>   	ice_clean_adminq_subtask(pf);
>   	ice_check_media_subtask(pf);
>   	ice_check_for_hang_subtask(pf);

