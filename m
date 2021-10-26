From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 26 Oct 2021 14:32:36 -0700
Subject: [Intel-wired-lan] [RFC v5 net-next 4/5] rtnetlink: Add support
 for SyncE recovered clock configuration
In-Reply-To: <20211026173146.1031412-5-maciej.machnikowski@intel.com>
References: <20211026173146.1031412-1-maciej.machnikowski@intel.com>
 <20211026173146.1031412-5-maciej.machnikowski@intel.com>
Message-ID: <20211026143236.050af4e9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Please add a write up of how things fit together in Documentation/.
I'm sure reviewers and future users will appreciate that.

Some nits below.

On Tue, 26 Oct 2021 19:31:45 +0200 Maciej Machnikowski wrote:
> Add support for RTNL messages for reading/configuring SyncE recovered
> clocks.
> The messages are:
> RTM_GETRCLKRANGE: Reads the allowed pin index range for the recovered
> 		  clock outputs. This can be aligned to PHY outputs or
> 		  to EEC inputs, whichever is better for a given
> 		  application
> 
> RTM_GETRCLKSTATE: Read the state of recovered pins that output recovered
> 		  clock from a given port. The message will contain the
> 		  number of assigned clocks (IFLA_RCLK_STATE_COUNT) and
> 		  a N pin inexes in IFLA_RCLK_STATE_OUT_IDX

Do we need two separate calls for the gets?

> RTM_SETRCLKSTATE: Sets the redirection of the recovered clock for
> 		  a given pin


> +struct if_set_rclk_msg {
> +	__u32 ifindex;
> +	__u32 out_idx;
> +	__u32 flags;

Why not break this out into separate attrs?

> +++ b/net/core/rtnetlink.c
> @@ -5524,8 +5524,10 @@ static int rtnl_eec_state_get(struct sk_buff *skb, struct nlmsghdr *nlh,
>  
>  	state = nlmsg_data(nlh);
>  	dev = __dev_get_by_index(net, state->ifindex);
> -	if (!dev)
> +	if (!dev) {
> +		NL_SET_ERR_MSG(extack, "unknown ifindex");
>  		return -ENODEV;
> +	}
>  
>  	nskb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>  	if (!nskb)

Belongs in previous patch?
