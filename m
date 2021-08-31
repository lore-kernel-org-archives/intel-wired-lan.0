From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 31 Aug 2021 06:44:10 -0700
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20210831115233.239720-2-maciej.machnikowski@intel.com>
References: <20210831115233.239720-1-maciej.machnikowski@intel.com>
 <20210831115233.239720-2-maciej.machnikowski@intel.com>
Message-ID: <20210831064410.635eb329@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 31 Aug 2021 13:52:32 +0200 Maciej Machnikowski wrote:
> This patch series introduces basic interface for reading the Ethernet
> Equipment Clock (EEC) state on a SyncE capable device. This state gives
> information about the source of the syntonization signal and the state
> of EEC. This interface is required to implement Synchronization Status
> Messaging on upper layers.
> 
> Initial implementation returns:
>  - SyncE EEC state
>  - Source of signal driving SyncE EEC (SyncE, GNSS, PTP or External)
>  - Current index of the pin driving the EEC to track multiple recovered
>    clock paths
> 
> SyncE EEC state read needs to be implemented as ndo_get_eec_state
> function.
> 
> Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>

> +#define EEC_FLAG_STATE_VAL	(1 << 0)
> +#define EEC_FLAG_SRC_VAL	(1 << 1)
> +#define EEC_FLAG_PIN_VAL	(1 << 2)
> +
> +struct if_eec_state_msg {
> +	__u8 flags;
> +	__u8 state;
> +	__u8 src;
> +	__u8 pin;
> +	__u32 ifindex;
> +};

Break it up into attributes, please. It's the idiomatic way of dealing
with multiple values these days in netlink. Makes validation,
extensiblility, feature discover etc. etc. much easier down the line.

> +static int rtnl_fill_eec_state(struct sk_buff *msg, struct net_device *dev,
> +			       u32 portid, u32 seq, struct netlink_callback *cb,
> +			       int flags, struct netlink_ext_ack *extack)
> +{
> +	const struct net_device_ops *ops = dev->netdev_ops;
> +	struct if_eec_state_msg *state;
> +	struct nlmsghdr *nlh;
> +	int err;
> +
> +	ASSERT_RTNL();
> +
> +	if (!ops->ndo_get_eec_state)
> +		return -EOPNOTSUPP;
> +
> +	nlh = nlmsg_put(msg, portid, seq, RTM_GETEECSTATE,
> +			sizeof(*state), flags);
> +	if (!nlh)
> +		return -EMSGSIZE;
> +
> +	state = nlmsg_data(nlh);
> +
> +	memset(state, 0, sizeof(*state));
> +	err = ops->ndo_get_eec_state(dev, state, extack);
> +	if (err)
> +		return err;

return ops->ndo_get_eec_state(dev, state, extack);

Even tho it's perfectly fine as is IMO there are bots out there
matching on this pattern so let's not feed them.

> +	return 0;
> +}
> +
> +static int rtnl_eec_state_get(struct sk_buff *skb, struct nlmsghdr *nlh,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct net *net = sock_net(skb->sk);
> +	struct if_eec_state_msg *state;
> +	struct net_device *dev;
> +	struct sk_buff *nskb;
> +	int err;
> +
> +	state = nlmsg_data(nlh);
> +	if (state->ifindex > 0)
> +		dev = __dev_get_by_index(net, state->ifindex);
> +	else
> +		return -EINVAL;

Keep the expected path unindented:

	if (state->ifindex <= 0)
		return -EINVAL;

	dev = __dev_get_by_index(net, state->ifindex);
	if (!dev)
		return -ENODEV;

That said I'm not sure why rtnl_stats_get() checks the ifindex is
positive in the first place (which is what I assumed inspired you).
We can just call __dev_get_by_index() and have it fail AFAICS.

> +	if (!dev)
> +		return -ENODEV;
> +
> +	nskb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!nskb)
> +		return -ENOBUFS;
> +
> +	err = rtnl_fill_eec_state(nskb, dev, NETLINK_CB(skb).portid,
> +				  nlh->nlmsg_seq, NULL, nlh->nlmsg_flags,
> +				  extack);
> +	if (err < 0)
> +		kfree_skb(nskb);
> +	else
> +		err = rtnl_unicast(nskb, net, NETLINK_CB(skb).portid);
> +
> +	return err;
> +}
