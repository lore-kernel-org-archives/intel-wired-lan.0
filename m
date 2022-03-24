From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Thu, 24 Mar 2022 03:09:25 -0400
Subject: [Intel-wired-lan] [PATCH net] ice: Clear default forwarding VSI
 during VSI release
In-Reply-To: <20220322142554.3253428-1-ivecera@redhat.com>
References: <20220322142554.3253428-1-ivecera@redhat.com>
Message-ID: <YjwZJU7PIKCcndC1@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 22, 2022 at 03:25:54PM +0100, Ivan Vecera wrote:
> VSI is set as default forwarding one when promisc mode is set for
> PF interface, when PF is switched to switchdev mode or when VF
> driver asks to enable allmulticast or promisc mode for the VF
> interface (when vf-true-promisc-support priv flag is off).
> The third case is buggy because in that case VSI associated with
> VF remains as default one after VF removal.
> 
> Reproducer:
> 1. Create VF
>    echo 1 > sys/class/net/ens7f0/device/sriov_numvfs
> 2. Enable allmulticast or promisc mode on VF
>    ip link set ens7f0v0 allmulticast on
>    ip link set ens7f0v0 promisc on
> 3. Delete VF
>    echo 0 > sys/class/net/ens7f0/device/sriov_numvfs
> 4. Try to enable promisc mode on PF
>    ip link set ens7f0 promisc on
> 
> Although it looks that promisc mode on PF is enabled the opposite
> is true because ice_vsi_sync_fltr() responsible for IFF_PROMISC
> handling first checks if any other VSI is set as default forwarding
> one and if so the function does not do anything. At this point
> it is not possible to enable promisc mode on PF without re-probe
> device.
> 
> To resolve the issue this patch clear default forwarding VSI
> during ice_vsi_release() when the VSI to be released is the default
> one.
> 
> Fixes: 01b5e89aab49 ("ice: Add VF promiscuous support")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 53256aca27c7..20d755822d43 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3147,6 +3147,8 @@ int ice_vsi_release(struct ice_vsi *vsi)
>  		}
>  	}
>  
> +	if (ice_is_vsi_dflt_vsi(pf->first_sw, vsi))
> +		ice_clear_dflt_vsi(pf->first_sw);
>  	ice_fltr_remove_all(vsi);
>  	ice_rm_vsi_lan_cfg(vsi->port_info, vsi->idx);
>  	err = ice_rm_vsi_rdma_cfg(vsi->port_info, vsi->idx);
Thanks for fixing it.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.34.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
