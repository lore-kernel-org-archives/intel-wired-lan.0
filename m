From: Sabrina Dubroca <sd@queasysnail.net>
Date: Thu, 11 Nov 2021 17:01:02 +0100
Subject: [Intel-wired-lan] [PATCH v3 net-next 2/6] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20211110114448.2792314-3-maciej.machnikowski@intel.com>
References: <20211110114448.2792314-1-maciej.machnikowski@intel.com>
 <20211110114448.2792314-3-maciej.machnikowski@intel.com>
Message-ID: <YY0+PmNU4MSGfgqA@hog>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Maciej,

2021-11-10, 12:44:44 +0100, Maciej Machnikowski wrote:
> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index 5888492a5257..1d8662afd6bd 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -185,6 +185,9 @@ enum {
>  	RTM_GETNEXTHOPBUCKET,
>  #define RTM_GETNEXTHOPBUCKET	RTM_GETNEXTHOPBUCKET
>  
> +	RTM_GETEECSTATE = 124,
> +#define RTM_GETEECSTATE	RTM_GETEECSTATE

I'm not sure about this. All the other RTM_GETxxx are such that
RTM_GETxxx % 4 == 2. Following the current pattern, 124 should be
reserved for RTM_NEWxxx, and RTM_GETEECSTATE would be 126.

Also, why are you leaving a gap (which you end up filling in patch
4/6)?

> +
>  	__RTM_MAX,
>  #define RTM_MAX		(((__RTM_MAX + 3) & ~3) - 1)
>  };
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 2af8aeeadadf..03bc773d0e69 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -5467,6 +5467,83 @@ static int rtnl_stats_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  	return skb->len;
>  }
>  
> +static int rtnl_fill_eec_state(struct sk_buff *skb, struct net_device *dev,
> +			       u32 portid, u32 seq, struct netlink_callback *cb,
> +			       int flags, struct netlink_ext_ack *extack)
> +{
[...]
> +	nlh = nlmsg_put(skb, portid, seq, RTM_GETEECSTATE, sizeof(*state_msg),
> +			flags);
> +	if (!nlh)
> +		return -EMSGSIZE;
> +
> +	state_msg = nlmsg_data(nlh);
> +	state_msg->ifindex = dev->ifindex;

Why stuff this in a struct instead of using an attribute?

> +
> +	if (nla_put_u32(skb, IFLA_EEC_STATE, state))
> +		return -EMSGSIZE;
> +
> +	if (!ops->ndo_get_eec_src)
> +		goto end_msg;
> +
> +	err = ops->ndo_get_eec_src(dev, &src_idx, extack);
> +	if (err)
> +		return err;
> +
> +	if (nla_put_u32(skb, IFLA_EEC_SRC_IDX, src_idx))
> +		return -EMSGSIZE;
> +
> +end_msg:
> +	nlmsg_end(skb, nlh);
> +	return 0;
> +}
> +

Thanks,

-- 
Sabrina

