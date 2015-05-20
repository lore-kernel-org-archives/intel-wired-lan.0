From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Wed, 20 May 2015 18:14:15 +0000
Subject: [Intel-wired-lan] [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
In-Reply-To: <7F861DC0615E0C47A872E6F3C5FCDDBD05EB28F4@BPXM14GP.gisp.nec.co.jp>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05EB28F4@BPXM14GP.gisp.nec.co.jp>
Message-ID: <F6FB0E698C9B3143BDF729DF22286646912FB5E4@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Hiroshi Shimamoto [mailto:h-shimamoto at ct.jp.nec.com]
> Sent: Tuesday, May 19, 2015 5:06 PM
> To: Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org
> Cc: Skidmore, Donald C; Or Gerlitz; David Miller; Linux Netdev List;
> nhorman at redhat.com; sassmann at redhat.com; jogreene at redhat.com;
> Choi, Sy Jong; Edward Cree; Rony Efraim
> Subject: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
> 
> From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> 
> Implement the new netdev op to trust VF in ixgbe and make VF multicast
> promiscuous mode enabled only in trusted VF.
> 
> The administrator can make VF trusted by ip command which supports trust
> message.
>  # ip link set dev eth0 vf 1 trust on
> 
> After making VF untrusted, ixgbe disables VF multicast promiscuous feature
> requested from VF.
>  # ip link set dev eth0 vf 1 trust off
> 
> Only trusted VF can enable VF multicast promiscuous mode and handle over
> 30 IPv6 addresses on VM, because VF multicast promiscuous mode may hurt
> performance.
> 
> Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> Reviewed-by: Hayato Momma <h-momma@ce.jp.nec.com>
> CC: Choi, Sy Jong <sy.jong.choi@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  5 ++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 38
> +++++++++++++++++++++++---
> drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h |  2 ++
>  4 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index 08e65b6..5181a4d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -153,6 +153,7 @@ struct vf_data_storage {
>  	u16 vlan_count;
>  	u8 spoofchk_enabled;
>  	bool rss_query_enabled;
> +	u8 trusted;
>  	unsigned int vf_api;
>  };
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index b1ea707..263cb40 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -3679,6 +3679,10 @@ static void ixgbe_configure_virtualization(struct
> ixgbe_adapter *adapter)
>  		/* Enable/Disable RSS query feature  */
>  		ixgbe_ndo_set_vf_rss_query_en(adapter->netdev, i,
>  					  adapter-
> >vfinfo[i].rss_query_enabled);
> +
> +		/* Reconfigure features in trusted */
> +		ixgbe_ndo_set_vf_trust(adapter->netdev, i,
> +				       adapter->vfinfo[i].trusted);
>  	}
>  }
> 
> @@ -8182,6 +8186,7 @@ static const struct net_device_ops
> ixgbe_netdev_ops = {
>  	.ndo_set_vf_rate	= ixgbe_ndo_set_vf_bw,
>  	.ndo_set_vf_spoofchk	= ixgbe_ndo_set_vf_spoofchk,
>  	.ndo_set_vf_rss_query_en = ixgbe_ndo_set_vf_rss_query_en,
> +	.ndo_set_vf_trust	= ixgbe_ndo_set_vf_trust,
>  	.ndo_get_vf_config	= ixgbe_ndo_get_vf_config,
>  	.ndo_get_stats64	= ixgbe_get_stats64,
>  #ifdef CONFIG_IXGBE_DCB
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> index 615f651..6c602bc 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> @@ -117,8 +117,11 @@ static int __ixgbe_enable_sriov(struct ixgbe_adapter
> *adapter)
>  			 */
>  			adapter->vfinfo[i].rss_query_enabled = 0;
> 
> -			/* Turn multicast promiscuous mode off for all VFs */
> +			/* Disallow VF multicast promiscuous capability
> +			 * and turn it off for all VFs
> +			 */
>  			adapter->vfinfo[i].mc_promisc = false;
> +			adapter->vfinfo[i].trusted = false;
>  		}
> 
>  		return 0;
> @@ -329,9 +332,14 @@ static int ixgbe_enable_vf_mc_promisc(struct
> ixgbe_adapter *adapter, u32 vf)
>  	hw = &adapter->hw;
>  	vmolr = IXGBE_READ_REG(hw, IXGBE_VMOLR(vf));
> 
> -	e_info(drv, "VF %u: enabling multicast promiscuous\n", vf);
> -
> -	vmolr |= IXGBE_VMOLR_MPE;
> +	if (adapter->vfinfo[vf].trusted) {
> +		e_info(drv, "VF %u: enabling multicast promiscuous\n", vf);
> +		vmolr |= IXGBE_VMOLR_MPE;
> +	} else {
> +		e_info(drv, "VF %u: disabling multicast promiscuous "
> +		       "on untrusted VF.\n", vf);
> +		vmolr &= ~IXGBE_VMOLR_MPE;
> +	}
> 
>  	IXGBE_WRITE_REG(hw, IXGBE_VMOLR(vf), vmolr);
> 
> @@ -1492,6 +1500,27 @@ int ixgbe_ndo_set_vf_rss_query_en(struct
> net_device *netdev, int vf,
>  	return 0;
>  }
> 
> +int ixgbe_ndo_set_vf_trust(struct net_device *netdev, int vf, bool
> +setting) {
> +	struct ixgbe_adapter *adapter = netdev_priv(netdev);
> +
> +	if (vf >= adapter->num_vfs)
> +		return -EINVAL;
> +
> +	/* nothing to do */
> +	if (adapter->vfinfo[vf].trusted == setting)
> +		return 0;
> +
> +	adapter->vfinfo[vf].trusted = setting;
> +
> +	/* Reconfigure features which are only allowed for trusted VF */
> +	/* VF multicast promiscuous mode */
> +	if (adapter->vfinfo[vf].mc_promisc)
> +		ixgbe_enable_vf_mc_promisc(adapter, vf);
> +
> +	return 0;
> +}
> +
>  int ixgbe_ndo_get_vf_config(struct net_device *netdev,
>  			    int vf, struct ifla_vf_info *ivi)  { @@ -1506,5 +1535,6
> @@ int ixgbe_ndo_get_vf_config(struct net_device *netdev,
>  	ivi->qos = adapter->vfinfo[vf].pf_qos;
>  	ivi->spoofchk = adapter->vfinfo[vf].spoofchk_enabled;
>  	ivi->rss_query_en = adapter->vfinfo[vf].rss_query_enabled;
> +	ivi->trusted = adapter->vfinfo[vf].trusted;
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
> index 2c197e6..d85e6fc 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
> @@ -49,6 +49,8 @@ int ixgbe_ndo_set_vf_bw(struct net_device *netdev,
> int vf, int min_tx_rate,  int ixgbe_ndo_set_vf_spoofchk(struct net_device
> *netdev, int vf, bool setting);  int ixgbe_ndo_set_vf_rss_query_en(struct
> net_device *netdev, int vf,
>  				  bool setting);
> +int ixgbe_ndo_set_vf_trust(struct net_device *netdev,
> +			    int vf, bool setting);
>  int ixgbe_ndo_get_vf_config(struct net_device *netdev,
>  			    int vf, struct ifla_vf_info *ivi);  void
> ixgbe_check_vf_rate_limit(struct ixgbe_adapter *adapter);
> --
> 1.8.3.1

Hey Hiroshi,

In general I like your patch set.   There is a little complexity I?m not sure I understand.  I'm assuming that:

 adapter->vfinfo[vf].trusted - Clearly stores if the PF trusts a given VF (i.e. allows it to go into "risky" configurations)

What I'm a bit unclear about is:

adapter->vfinfo[vf].mc_promisc - This seems to record that the VF at one time as requested over 30 MC.

I don't understand the reason for this bit.  Wouldn't it be simpler and more straightforward to simply use the trusted bit?   I guess specifically I don't understand why we would call ixgbe_enable_vf_mc_promisc() in ixgbe_ndo_set_vf_trust() if mc_promisc is set.  Wouldn't just setting the trusted bit allow the next IXGBE_VF_SET_MC_PROMISC mailbox message to (possibly) turn on MC Promisc mode?

Thanks,
-Don Skidmore <donald.c.skidmore@intel.com>


