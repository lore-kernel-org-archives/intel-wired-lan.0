From: Rose, Gregory V <gregory.v.rose@intel.com>
Date: Fri, 28 Aug 2015 14:28:24 +0000
Subject: [Intel-wired-lan] [PATCH v8 1/3] if_link: Add control trust VF
In-Reply-To: <7F861DC0615E0C47A872E6F3C5FCDDBD05F28E5B@BPXM14GP.gisp.nec.co.jp>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05F28E5B@BPXM14GP.gisp.nec.co.jp>
Message-ID: <C5551D9AAB213A418B7FD5E4A6F30A078939424F@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Hiroshi Shimamoto [mailto:h-shimamoto at ct.jp.nec.com]
> Sent: Thursday, August 27, 2015 11:58 PM
> To: Or Gerlitz; Alexander Duyck; Skidmore, Donald C; Rose, Gregory V;
> Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org; nhorman at redhat.com;
> jogreene at redhat.com; Linux Netdev List; Choi, Sy Jong; Rony Efraim; Edward
> Cree; David Miller; sassmann at redhat.com
> Subject: [PATCH v8 1/3] if_link: Add control trust VF
> 
> From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> 
> Add netlink directives and ndo entry to trust VF user.
> 
> This controls the special permission of VF user.
> The administrator will dedicatedly trust VF user to use some features
> which impacts security and/or performance.
> 
> The administrator never turn it on unless VF user is fully trusted.
> 
> Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> CC: Choi, Sy Jong <sy.jong.choi@intel.com>> ---

Thank you for persisting in this!

Acked-By: Greg Rose <gregory.v.rose@intel.com>

I'll leave the patches for ixgbe to Don Skidmore to review. 

>  include/linux/if_link.h      |  1 +
>  include/linux/netdevice.h    |  3 +++
>  include/uapi/linux/if_link.h |  6 ++++++
>  net/core/rtnetlink.c         | 24 +++++++++++++++++++++---
>  4 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/if_link.h b/include/linux/if_link.h index
> ae5d0d2..f923d15 100644
> --- a/include/linux/if_link.h
> +++ b/include/linux/if_link.h
> @@ -24,5 +24,6 @@ struct ifla_vf_info {
>  	__u32 min_tx_rate;
>  	__u32 max_tx_rate;
>  	__u32 rss_query_en;
> +	__u32 trusted;
>  };
>  #endif /* _LINUX_IF_LINK_H */
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h index
> 6163ecb..7db19e7 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -880,6 +880,7 @@ typedef u16 (*select_queue_fallback_t)(struct
> net_device *dev,
>   * int (*ndo_set_vf_rate)(struct net_device *dev, int vf, int
> min_tx_rate,
>   *			  int max_tx_rate);
>   * int (*ndo_set_vf_spoofchk)(struct net_device *dev, int vf, bool
> setting);
> + * int (*ndo_set_vf_trust)(struct net_device *dev, int vf, bool
> + setting);
>   * int (*ndo_get_vf_config)(struct net_device *dev,
>   *			    int vf, struct ifla_vf_info *ivf);
>   * int (*ndo_set_vf_link_state)(struct net_device *dev, int vf, int
> link_state); @@ -1121,6 +1122,8 @@ struct net_device_ops {
>  						   int max_tx_rate);
>  	int			(*ndo_set_vf_spoofchk)(struct net_device *dev,
>  						       int vf, bool setting);
> +	int			(*ndo_set_vf_trust)(struct net_device *dev,
> +						    int vf, bool setting);
>  	int			(*ndo_get_vf_config)(struct net_device *dev,
>  						     int vf,
>  						     struct ifla_vf_info *ivf);
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 313c305..2d6abd4 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -498,6 +498,7 @@ enum {
>  				 * on/off switch
>  				 */
>  	IFLA_VF_STATS,		/* network device statistics */
> +	IFLA_VF_TRUST,		/* Trust VF */
>  	__IFLA_VF_MAX,
>  };
> 
> @@ -559,6 +560,11 @@ enum {
> 
>  #define IFLA_VF_STATS_MAX (__IFLA_VF_STATS_MAX - 1)
> 
> +struct ifla_vf_trust {
> +	__u32 vf;
> +	__u32 setting;
> +};
> +
>  /* VF ports management section
>   *
>   *	Nested layout of set/get msg is:
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c index
> 788ceed..2836bf1 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -831,7 +831,8 @@ static inline int rtnl_vfinfo_size(const struct
> net_device *dev,
>  			 /* IFLA_VF_STATS_BROADCAST */
>  			 nla_total_size(sizeof(__u64)) +
>  			 /* IFLA_VF_STATS_MULTICAST */
> -			 nla_total_size(sizeof(__u64)));
> +			 nla_total_size(sizeof(__u64)) +
> +			 nla_total_size(sizeof(struct ifla_vf_trust)));
>  		return size;
>  	} else
>  		return 0;
> @@ -1154,6 +1155,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
> struct net_device *dev,
>  			struct ifla_vf_link_state vf_linkstate;
>  			struct ifla_vf_rss_query_en vf_rss_query_en;
>  			struct ifla_vf_stats vf_stats;
> +			struct ifla_vf_trust vf_trust;
> 
>  			/*
>  			 * Not all SR-IOV capable drivers support the @@ -1163,6
> +1165,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb, struct
> net_device *dev,
>  			 */
>  			ivi.spoofchk = -1;
>  			ivi.rss_query_en = -1;
> +			ivi.trusted = -1;
>  			memset(ivi.mac, 0, sizeof(ivi.mac));
>  			/* The default value for VF link state is "auto"
>  			 * IFLA_VF_LINK_STATE_AUTO which equals zero @@ -1176,7
> +1179,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb, struct
> net_device *dev,
>  				vf_tx_rate.vf =
>  				vf_spoofchk.vf =
>  				vf_linkstate.vf =
> -				vf_rss_query_en.vf = ivi.vf;
> +				vf_rss_query_en.vf =
> +				vf_trust.vf = ivi.vf;
> 
>  			memcpy(vf_mac.mac, ivi.mac, sizeof(ivi.mac));
>  			vf_vlan.vlan = ivi.vlan;
> @@ -1187,6 +1191,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
> struct net_device *dev,
>  			vf_spoofchk.setting = ivi.spoofchk;
>  			vf_linkstate.link_state = ivi.linkstate;
>  			vf_rss_query_en.setting = ivi.rss_query_en;
> +			vf_trust.setting = ivi.trusted;
>  			vf = nla_nest_start(skb, IFLA_VF_INFO);
>  			if (!vf) {
>  				nla_nest_cancel(skb, vfinfo);
> @@ -1204,7 +1209,9 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
> struct net_device *dev,
>  				    &vf_linkstate) ||
>  			    nla_put(skb, IFLA_VF_RSS_QUERY_EN,
>  				    sizeof(vf_rss_query_en),
> -				    &vf_rss_query_en))
> +				    &vf_rss_query_en) ||
> +			    nla_put(skb, IFLA_VF_TRUST,
> +				    sizeof(vf_trust), &vf_trust))
>  				goto nla_put_failure;
>  			memset(&vf_stats, 0, sizeof(vf_stats));
>  			if (dev->netdev_ops->ndo_get_vf_stats)
> @@ -1341,6 +1348,7 @@ static const struct nla_policy
> ifla_vf_policy[IFLA_VF_MAX+1] = {
>  	[IFLA_VF_LINK_STATE]	= { .len = sizeof(struct ifla_vf_link_state)
> },
>  	[IFLA_VF_RSS_QUERY_EN]	= { .len = sizeof(struct
> ifla_vf_rss_query_en) },
>  	[IFLA_VF_STATS]		= { .type = NLA_NESTED },
> +	[IFLA_VF_TRUST]		= { .len = sizeof(struct ifla_vf_trust) },
>  };
> 
>  static const struct nla_policy ifla_vf_stats_policy[IFLA_VF_STATS_MAX +
> 1] = { @@ -1580,6 +1588,16 @@ static int do_setvfinfo(struct net_device
> *dev, struct nlattr **tb)
>  			return err;
>  	}
> 
> +	if (tb[IFLA_VF_TRUST]) {
> +		struct ifla_vf_trust *ivt = nla_data(tb[IFLA_VF_TRUST]);
> +
> +		err = -EOPNOTSUPP;
> +		if (ops->ndo_set_vf_trust)
> +			err = ops->ndo_set_vf_trust(dev, ivt->vf, ivt->setting);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	return err;
>  }
> 
> --
> 1.8.3.1

