From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 19 Jan 2021 15:03:42 -0800
Subject: [Intel-wired-lan] [PATCH net-next v2 1/8] ethtool: Add support
 for configuring frame preemption
In-Reply-To: <20210119005224.yqrpyr2d7xawhbtf@skbuf>
References: <20210119004028.2809425-1-vinicius.gomes@intel.com>
 <20210119004028.2809425-2-vinicius.gomes@intel.com>
 <20210119005224.yqrpyr2d7xawhbtf@skbuf>
Message-ID: <87v9bszfzl.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vladimir,

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> On Mon, Jan 18, 2021 at 04:40:21PM -0800, Vinicius Costa Gomes wrote:
>> +int ethnl_set_preempt(struct sk_buff *skb, struct genl_info *info)
>> +{
>> +	struct ethnl_req_info req_info = {};
>> +	struct nlattr **tb = info->attrs;
>> +	struct ethtool_fp preempt = {};
>> +	struct net_device *dev;
>> +	bool mod = false;
>> +	int ret;
>> +
>> +	ret = ethnl_parse_header_dev_get(&req_info,
>> +					 tb[ETHTOOL_A_PREEMPT_HEADER],
>> +					 genl_info_net(info), info->extack,
>> +					 true);
>> +	if (ret < 0)
>> +		return ret;
>> +	dev = req_info.dev;
>> +	ret = -EOPNOTSUPP;
>> +	if (!dev->ethtool_ops->get_preempt ||
>> +	    !dev->ethtool_ops->set_preempt)
>> +		goto out_dev;
>> +
>> +	rtnl_lock();
>
> I'm a bit of a noob when it comes to ethtool (netlink or otherwise).
> Why do you take the rtnl_mutex when updating some purely hardware
> values, what netdev state is there to protect? Can this get->modify->set
> sequence be serialized using other locking mechanism than rtnl_mutex?

From what I understand, configuration changes to netdevice should be
protected by rtnl_mutex, for example, to avoid the device disappearing
while the configuration is in progress. I don't think there's any other
finer grained lock that can be used here.


Cheers,
-- 
Vinicius
