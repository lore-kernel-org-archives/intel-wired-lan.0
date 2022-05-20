From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 20 May 2022 09:06:12 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 01/11] ethtool: Add
 support for configuring frame preemption
In-Reply-To: <20220520011538.1098888-2-vinicius.gomes@intel.com>
References: <20220520011538.1098888-1-vinicius.gomes@intel.com>
 <20220520011538.1098888-2-vinicius.gomes@intel.com>
Message-ID: <20220520090611.5gcguajnucyj7uli@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vinicius,

On Thu, May 19, 2022 at 06:15:28PM -0700, Vinicius Costa Gomes wrote:
> Frame preemption (described in IEEE 802.3-2018, Section 99 in
> particular) defines the concept of preemptible and express queues. It
> allows traffic from express queues to "interrupt" traffic from
> preemptible queues, which are "resumed" after the express traffic has
> finished transmitting.
> 
> Expose the UAPI bits for applications to enable using ethtool-netlink.
> Also expose the kernel ethtool functions, so device drivers can
> support it.
> 
> Frame preemption can only be used when both the local device and the
> link partner support it.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---

This looks good to me. Just one comment below.

> +int ethnl_set_preempt(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct ethnl_req_info req_info = {};
> +	struct nlattr **tb = info->attrs;
> +	struct ethtool_fp preempt = {};
> +	struct net_device *dev;
> +	bool mod = false;
> +	int ret;
> +
> +	ret = ethnl_parse_header_dev_get(&req_info,
> +					 tb[ETHTOOL_A_PREEMPT_HEADER],
> +					 genl_info_net(info), info->extack,
> +					 true);
> +	if (ret < 0)
> +		return ret;
> +	dev = req_info.dev;
> +
> +	ret = -EOPNOTSUPP;
> +	if (!dev->ethtool_ops->get_preempt ||
> +	    !dev->ethtool_ops->set_preempt)
> +		goto out_dev;
> +
> +	rtnl_lock();
> +	ret = ethnl_ops_begin(dev);
> +	if (ret < 0)
> +		goto out_rtnl;
> +
> +	ret = dev->ethtool_ops->get_preempt(dev, &preempt);
> +	if (ret < 0) {
> +		GENL_SET_ERR_MSG(info, "failed to retrieve frame preemption settings");
> +		goto out_ops;
> +	}
> +
> +	ret = ethnl_update_bitset32(&preempt.preemptible_mask, PREEMPT_QUEUES_COUNT,
> +				    tb[ETHTOOL_A_PREEMPT_PREEMPTIBLE_MASK],
> +				    NULL, info->extack, &mod);
> +	if (ret < 0)
> +		goto out_ops;
> +
> +	ethnl_update_bool32(&preempt.enabled,
> +			    tb[ETHTOOL_A_PREEMPT_ENABLED], &mod);
> +	ethnl_update_u32(&preempt.add_frag_size,
> +			 tb[ETHTOOL_A_PREEMPT_ADD_FRAG_SIZE], &mod);
> +	ret = 0;
> +	if (!mod)
> +		goto out_ops;
> +
> +	ret = dev->ethtool_ops->set_preempt(dev, &preempt, info->extack);
> +	if (ret < 0) {
> +		GENL_SET_ERR_MSG(info, "frame preemption settings update failed");

If you pass the extack to ->set_preempt, would you consider not
overwriting it immediately afterwards on error?

> +		goto out_ops;
> +	}
> +
> +	ethtool_notify(dev, ETHTOOL_MSG_PREEMPT_NTF, NULL);
> +
> +out_ops:
> +	ethnl_ops_complete(dev);
> +out_rtnl:
> +	rtnl_unlock();
> +out_dev:
> +	dev_put(dev);
> +	return ret;
> +}
> -- 
> 2.35.3
>
