From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Thu, 3 Jun 2021 10:42:03 +0200
Subject: [Intel-wired-lan] [PATCH intel-next 2/2] ice: introduce XDP Tx
 fallback path
In-Reply-To: <20210601113236.42651-3-maciej.fijalkowski@intel.com>
References: <20210601113236.42651-1-maciej.fijalkowski@intel.com>
 <20210601113236.42651-3-maciej.fijalkowski@intel.com>
Message-ID: <20210603104203.26e5fee4@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue,  1 Jun 2021 13:32:36 +0200
Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:

> Under rare circumstances there might be a situation where a requirement
> of having a XDP Tx queue per core could not be fulfilled and some of the
> Tx resources would have to be shared between cores. This yields a need
> for placing accesses to xdp_rings array onto critical section protected
> by spinlock.
> 
> Design of handling such scenario is to at first find out how many queues
> are there that XDP could use. Any number that is not less than the half
> of a count of cores of platform is allowed. XDP queue count < cpu count
> is signalled via new VSI state ICE_VSI_XDP_FALLBACK which carries the
> information further down to Rx rings where new ICE_TX_XDP_LOCKED is set
> based on the mentioned VSI state. This ring flag indicates that locking
> variants for getting/putting xdp_ring need to be used in fast path.
> 
> For XDP_REDIRECT the impact on standard case (one XDP ring per CPU) can
> be reduced a bit by providing a separate ndo_xdp_xmit and swap it at
> configuration time. However, due to the fact that net_device_ops struct
> is a const, it is not possible to replace a single ndo, so for the
> locking variant of ndo_xdp_xmit, whole net_device_ops needs to be
> replayed.

I like this approach of having a separate ndo_xdp_xmit.  Slightly
unfortunately that we have setup an entire net_device_ops struct for
the purpose.

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

> 
> It has an impact on performance (1-2 %) of a non-fallback path as
> branches are introduced.

The XDP_TX path are slightly affected by this, but the XDP_REDIRECT
should not see any slowdown (I hope).


> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          | 37 +++++++++
>  drivers/net/ethernet/intel/ice/ice_base.c     |  5 ++
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  4 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     | 76 ++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 62 ++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 13 +++-
>  7 files changed, 191 insertions(+), 8 deletions(-)
> 
[...]
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 1915b6a734e2..6473134b492f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
[...]
> @@ -2355,6 +2357,12 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog)
>  	if (__ice_vsi_get_qs(&xdp_qs_cfg))
>  		goto err_map_xdp;
>  
> +	if (test_bit(ICE_VSI_XDP_FALLBACK, vsi->state)) {
> +		vsi->netdev->netdev_ops = &ice_netdev_ops_xdp_locked;
> +		netdev_warn(vsi->netdev,
> +			    "Could not allocate one XDP Tx ring per CPU, XDP_TX/XDP_REDIRECT actions will be slower\n");
> +	}
> +
>  	if (ice_xdp_alloc_setup_rings(vsi))
>  		goto clear_xdp_rings;
>  
> @@ -2470,6 +2478,10 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi)
>  
>  	devm_kfree(ice_pf_to_dev(pf), vsi->xdp_rings);
>  	vsi->xdp_rings = NULL;
> +	if (test_bit(ICE_VSI_XDP_FALLBACK, vsi->state)) {
> +		clear_bit(ICE_VSI_XDP_FALLBACK, vsi->state);
> +		vsi->netdev->netdev_ops = &ice_netdev_ops;
> +	}
>  
>  	if (ice_is_reset_in_progress(pf->state) || !vsi->q_vectors[0])
>  		return 0;
[...]
> @@ -6987,3 +7025,37 @@ static const struct net_device_ops ice_netdev_ops = {
>  	.ndo_xdp_xmit = ice_xdp_xmit,
>  	.ndo_xsk_wakeup = ice_xsk_wakeup,
>  };
> +
> +static const struct net_device_ops ice_netdev_ops_xdp_locked = {
> +	.ndo_open = ice_open,
> +	.ndo_stop = ice_stop,
> +	.ndo_start_xmit = ice_start_xmit,
> +	.ndo_features_check = ice_features_check,
> +	.ndo_set_rx_mode = ice_set_rx_mode,
> +	.ndo_set_mac_address = ice_set_mac_address,
> +	.ndo_validate_addr = eth_validate_addr,
> +	.ndo_change_mtu = ice_change_mtu,
> +	.ndo_get_stats64 = ice_get_stats64,
> +	.ndo_set_tx_maxrate = ice_set_tx_maxrate,
> +	.ndo_set_vf_spoofchk = ice_set_vf_spoofchk,
> +	.ndo_set_vf_mac = ice_set_vf_mac,
> +	.ndo_get_vf_config = ice_get_vf_cfg,
> +	.ndo_set_vf_trust = ice_set_vf_trust,
> +	.ndo_set_vf_vlan = ice_set_vf_port_vlan,
> +	.ndo_set_vf_link_state = ice_set_vf_link_state,
> +	.ndo_get_vf_stats = ice_get_vf_stats,
> +	.ndo_vlan_rx_add_vid = ice_vlan_rx_add_vid,
> +	.ndo_vlan_rx_kill_vid = ice_vlan_rx_kill_vid,
> +	.ndo_set_features = ice_set_features,
> +	.ndo_bridge_getlink = ice_bridge_getlink,
> +	.ndo_bridge_setlink = ice_bridge_setlink,
> +	.ndo_fdb_add = ice_fdb_add,
> +	.ndo_fdb_del = ice_fdb_del,
> +#ifdef CONFIG_RFS_ACCEL
> +	.ndo_rx_flow_steer = ice_rx_flow_steer,
> +#endif
> +	.ndo_tx_timeout = ice_tx_timeout,
> +	.ndo_bpf = ice_xdp,
> +	.ndo_xdp_xmit = ice_xdp_xmit_locked,
> +	.ndo_xsk_wakeup = ice_xsk_wakeup,
> +};

LGTM. Kept above code to ease review review of ndo_xdp_xmit /
net_device_ops swap for others.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

