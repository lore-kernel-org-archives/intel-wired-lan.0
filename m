From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 19 Jan 2021 00:52:24 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 1/8] ethtool: Add support
 for configuring frame preemption
In-Reply-To: <20210119004028.2809425-2-vinicius.gomes@intel.com>
References: <20210119004028.2809425-1-vinicius.gomes@intel.com>
 <20210119004028.2809425-2-vinicius.gomes@intel.com>
Message-ID: <20210119005224.yqrpyr2d7xawhbtf@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jan 18, 2021 at 04:40:21PM -0800, Vinicius Costa Gomes wrote:
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
> +	ret = -EOPNOTSUPP;
> +	if (!dev->ethtool_ops->get_preempt ||
> +	    !dev->ethtool_ops->set_preempt)
> +		goto out_dev;
> +
> +	rtnl_lock();

I'm a bit of a noob when it comes to ethtool (netlink or otherwise).
Why do you take the rtnl_mutex when updating some purely hardware
values, what netdev state is there to protect? Can this get->modify->set
sequence be serialized using other locking mechanism than rtnl_mutex?

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
> +	ethnl_update_u8(&preempt.enabled,
> +			tb[ETHTOOL_A_PREEMPT_ENABLED], &mod);
> +	ethnl_update_u32(&preempt.add_frag_size,
> +			 tb[ETHTOOL_A_PREEMPT_ADD_FRAG_SIZE], &mod);
> +	ret = 0;
> +	if (!mod)
> +		goto out_ops;
> +
> +	ret = dev->ethtool_ops->set_preempt(dev, &preempt, info->extack);
> +	if (ret < 0) {
> +		GENL_SET_ERR_MSG(info, "frame preemption settings update failed");
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
