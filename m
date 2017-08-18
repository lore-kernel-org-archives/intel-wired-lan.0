From: Nambiar, Amritha <amritha.nambiar@intel.com>
Date: Thu, 17 Aug 2017 17:44:25 -0700
Subject: [Intel-wired-lan] [PATCH v2 1/6] [net-next]net: mqprio:
 Introduce new hardware offload mode in mqprio for offloading full TC
 configurations
In-Reply-To: <ef96bf2d-da52-1092-ccc4-550c269c8a90@oracle.com>
References: <150296373549.16167.14331445560838257351.stgit@anamdev.jf.intel.com>
 <150296404972.16167.10089566618280478918.stgit@anamdev.jf.intel.com>
 <ef96bf2d-da52-1092-ccc4-550c269c8a90@oracle.com>
Message-ID: <4a6913c8-b522-5d58-cdb5-dbfb1eef0021@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/17/2017 12:43 PM, Shannon Nelson wrote:
> Two little thoughts...
> sln
> 
> On 8/17/2017 3:00 AM, Amritha Nambiar wrote:
>> This patch introduces a new hardware offload mode in mqprio
>> which makes full use of the mqprio options, the TCs, the
>> queue configurations and the bandwidth rates for the TCs.
>> This is achieved by setting the value 2 for the "hw" option.
>> This new offload mode supports new attributes for traffic
>> class such as minimum and maximum values for bandwidth rate limits.
>>
>> Introduces a new datastructure 'tc_mqprio_qopt_offload' for offloading
>> mqprio queue options and use this to be shared between the kernel and
>> device driver. This contains a copy of the exisiting datastructure
>> for mqprio queue options. This new datastructure can be extended when
>> adding new attributes for traffic class such as bandwidth rate limits. The
>> existing datastructure for mqprio queue options will be shared between the
>> kernel and userspace.
>>
>> This patch enables configuring additional attributes associated
>> with a traffic class such as minimum and maximum bandwidth
>> rates and can be offloaded to the hardware in the new offload mode.
>> The min and max limits for bandwidth rates are provided
>> by the user along with the the TCs and the queue configurations
>> when creating the mqprio qdisc.
>>
>> Example:
>> # tc qdisc add dev eth0 root mqprio num_tc 2 map 0 0 0 0 1 1 1 1\
>>    queues 4 at 0 4 at 4 min_rate 10Mbit 20Mbit max_rate 55Mbit 60Mbit hw 2
>>
>> To dump the bandwidth rates:
>>
>> # tc qdisc show dev eth0
>>
>> qdisc mqprio 804a: root  tc 2 map 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0
>>               queues:(0:3) (4:7)
>>               min_rate:10Mbit 20Mbit
>>               max_rate:55Mbit 60Mbit
>>
>> v2 : Jiri's changes accepted upstream removes the struct
>> tc_to_netdev. Clean up the full offload related changes added to
>> mqprio_init() and mqprio_destroy() to rebase on these changes.
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
>> ---
>>   include/linux/netdevice.h      |    1
>>   include/net/pkt_cls.h          |    7 ++
>>   include/uapi/linux/pkt_sched.h |   13 +++
>>   net/sched/sch_mqprio.c         |  167 ++++++++++++++++++++++++++++++++++++++--
>>   4 files changed, 178 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 0f1c4cb..631f314 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -777,6 +777,7 @@ enum tc_setup_type {
>>   	TC_SETUP_CLSFLOWER,
>>   	TC_SETUP_CLSMATCHALL,
>>   	TC_SETUP_CLSBPF,
>> +	TC_SETUP_MQPRIO_EXT,
>>   };
>>   
>>   /* These structures hold the attributes of xdp state that are being passed
>> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
>> index e80edd8..55bf148 100644
>> --- a/include/net/pkt_cls.h
>> +++ b/include/net/pkt_cls.h
>> @@ -546,6 +546,13 @@ struct tc_cls_bpf_offload {
>>   	u32 gen_flags;
>>   };
>>   
>> +struct tc_mqprio_qopt_offload {
>> +	/* struct tc_mqprio_qopt must always be the first element */
>> +	struct tc_mqprio_qopt qopt;
>> +	u32 flags;
>> +	u64 min_rate[TC_QOPT_MAX_QUEUE];
>> +	u64 max_rate[TC_QOPT_MAX_QUEUE];
>> +};
>>   
>>   /* This structure holds cookie structure that is passed from user
>>    * to the kernel for actions and classifiers
>> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
>> index 099bf55..cf2a146 100644
>> --- a/include/uapi/linux/pkt_sched.h
>> +++ b/include/uapi/linux/pkt_sched.h
>> @@ -620,6 +620,7 @@ struct tc_drr_stats {
>>   enum {
>>   	TC_MQPRIO_HW_OFFLOAD_NONE,	/* no offload requested */
>>   	TC_MQPRIO_HW_OFFLOAD_TCS,	/* offload TCs, no queue counts */
>> +	TC_MQPRIO_HW_OFFLOAD,		/* fully supported offload */
>>   	__TC_MQPRIO_HW_OFFLOAD_MAX
>>   };
>>   
>> @@ -633,6 +634,18 @@ struct tc_mqprio_qopt {
>>   	__u16	offset[TC_QOPT_MAX_QUEUE];
>>   };
>>   
>> +#define TC_MQPRIO_F_MIN_RATE  0x1
>> +#define TC_MQPRIO_F_MAX_RATE  0x2
>> +
>> +enum {
>> +	TCA_MQPRIO_UNSPEC,
>> +	TCA_MQPRIO_MIN_RATE64,
>> +	TCA_MQPRIO_MAX_RATE64,
>> +	__TCA_MQPRIO_MAX,
>> +};
>> +
>> +#define TCA_MQPRIO_MAX (__TCA_MQPRIO_MAX - 1)
>> +
>>   /* SFB */
>>   
>>   enum {
>> diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
>> index 2165a05..d913111 100644
>> --- a/net/sched/sch_mqprio.c
>> +++ b/net/sched/sch_mqprio.c
>> @@ -18,10 +18,13 @@
>>   #include <net/netlink.h>
>>   #include <net/pkt_sched.h>
>>   #include <net/sch_generic.h>
>> +#include <net/pkt_cls.h>
>>   
>>   struct mqprio_sched {
>>   	struct Qdisc		**qdiscs;
>>   	int hw_offload;
>> +	u32 flags;
>> +	u64 min_rate[TC_QOPT_MAX_QUEUE], max_rate[TC_QOPT_MAX_QUEUE];
> 
> Put these on separate lines.

Will do in the next version.

> 
>>   };
>>   
>>   static void mqprio_destroy(struct Qdisc *sch)
>> @@ -39,9 +42,20 @@ static void mqprio_destroy(struct Qdisc *sch)
>>   	}
>>   
>>   	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc) {
>> -		struct tc_mqprio_qopt mqprio = {};
>> +		struct tc_mqprio_qopt_offload mqprio = { { 0 } };
>>   
>> -		dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_MQPRIO, &mqprio);
>> +		switch (priv->hw_offload) {
>> +		case TC_MQPRIO_HW_OFFLOAD_TCS:
>> +			dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_MQPRIO,
>> +						      &mqprio.qopt);
>> +			break;
>> +		case TC_MQPRIO_HW_OFFLOAD:
>> +			dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_MQPRIO_EXT,
>> +						      &mqprio);
>> +			break;
>> +		default:
>> +			return;
>> +		}
>>   	} else {
>>   		netdev_set_num_tc(dev, 0);
>>   	}
>> @@ -97,6 +111,24 @@ static int mqprio_parse_opt(struct net_device *dev, struct tc_mqprio_qopt *qopt)
>>   	return 0;
>>   }
>>   
>> +static const struct nla_policy mqprio_policy[TCA_MQPRIO_MAX + 1] = {
>> +	[TCA_MQPRIO_MIN_RATE64] = { .type = NLA_NESTED },
>> +	[TCA_MQPRIO_MAX_RATE64] = { .type = NLA_NESTED },
>> +};
>> +
>> +static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
>> +		      const struct nla_policy *policy, int len)
>> +{
>> +	int nested_len = nla_len(nla) - NLA_ALIGN(len);
>> +
>> +	if (nested_len >= nla_attr_size(0))
>> +		return nla_parse(tb, maxtype, nla_data(nla) + NLA_ALIGN(len),
>> +				 nested_len, policy, NULL);
>> +
>> +	memset(tb, 0, sizeof(struct nlattr *) * (maxtype + 1));
>> +	return 0;
>> +}
>> +
>>   static int mqprio_init(struct Qdisc *sch, struct nlattr *opt)
>>   {
>>   	struct net_device *dev = qdisc_dev(sch);
>> @@ -105,6 +137,10 @@ static int mqprio_init(struct Qdisc *sch, struct nlattr *opt)
>>   	struct Qdisc *qdisc;
>>   	int i, err = -EOPNOTSUPP;
>>   	struct tc_mqprio_qopt *qopt = NULL;
>> +	struct nlattr *tb[TCA_MQPRIO_MAX + 1];
>> +	struct nlattr *attr;
>> +	int rem;
>> +	int len = nla_len(opt) - NLA_ALIGN(sizeof(*qopt));
>>   
>>   	BUILD_BUG_ON(TC_MAX_QUEUE != TC_QOPT_MAX_QUEUE);
>>   	BUILD_BUG_ON(TC_BITMASK != TC_QOPT_BITMASK);
>> @@ -122,6 +158,51 @@ static int mqprio_init(struct Qdisc *sch, struct nlattr *opt)
>>   	if (mqprio_parse_opt(dev, qopt))
>>   		return -EINVAL;
>>   
>> +	if (len > 0) {
>> +		err = parse_attr(tb, TCA_MQPRIO_MAX, opt, mqprio_policy,
>> +				 sizeof(*qopt));
>> +		if (err < 0)
>> +			return err;
>> +
>> +		if (tb[TCA_MQPRIO_MIN_RATE64]) {
>> +			if (qopt->hw != TC_MQPRIO_HW_OFFLOAD)
>> +				return -EINVAL;
>> +
>> +			i = 0;
>> +			nla_for_each_nested(attr, tb[TCA_MQPRIO_MIN_RATE64],
>> +					    rem) {
>> +				if (nla_type(attr) != TCA_MQPRIO_MIN_RATE64)
>> +					return -EINVAL;
>> +
>> +				if (i >= qopt->num_tc)
>> +					return -EINVAL;
>> +
>> +				priv->min_rate[i] = *(u64 *)nla_data(attr);
>> +				i++;
>> +			}
>> +			priv->flags |= TC_MQPRIO_F_MIN_RATE;
>> +		}
>> +
>> +		if (tb[TCA_MQPRIO_MAX_RATE64]) {
>> +			if (qopt->hw != TC_MQPRIO_HW_OFFLOAD)
>> +				return -EINVAL;
>> +
>> +			i = 0;
>> +			nla_for_each_nested(attr, tb[TCA_MQPRIO_MAX_RATE64],
>> +					    rem) {
>> +				if (nla_type(attr) != TCA_MQPRIO_MAX_RATE64)
>> +					return -EINVAL;
>> +
>> +				if (i >= qopt->num_tc)
>> +					return -EINVAL;
>> +
>> +				priv->max_rate[i] = *(u64 *)nla_data(attr);
>> +				i++;
>> +			}
>> +			priv->flags |= TC_MQPRIO_F_MAX_RATE;
>> +		}
>> +	}
>> +
>>   	/* pre-allocate qdisc, attachment can't fail */
>>   	priv->qdiscs = kcalloc(dev->num_tx_queues, sizeof(priv->qdiscs[0]),
>>   			       GFP_KERNEL);
>> @@ -146,14 +227,35 @@ static int mqprio_init(struct Qdisc *sch, struct nlattr *opt)
>>   	 * supplied and verified mapping
>>   	 */
>>   	if (qopt->hw) {
> 
> In the changes above is a test for existence of ->ndo_setup_tc(), should 
> there be a similar test here as well?

We wouldn't be here if ndo_setup_tc does not exist. It gets checked
prior in mqprio_parse_opt() and returns if not found.

> 
>> -		struct tc_mqprio_qopt mqprio = *qopt;
>> +		struct tc_mqprio_qopt_offload mqprio = {.qopt = *qopt};
>>   
>> -		err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_MQPRIO,
>> -						    &mqprio);
>> +		switch (qopt->hw) {
>> +		case TC_MQPRIO_HW_OFFLOAD_TCS:
>> +			err = dev->netdev_ops->ndo_setup_tc(dev,
>> +							    TC_SETUP_MQPRIO,
>> +							    &mqprio.qopt);
>> +			break;
>> +		case TC_MQPRIO_HW_OFFLOAD:
>> +			mqprio.flags = priv->flags;
>> +			if (priv->flags & TC_MQPRIO_F_MIN_RATE)
>> +				for (i = 0; i < mqprio.qopt.num_tc; i++)
>> +					mqprio.min_rate[i] = priv->min_rate[i];
>> +
>> +			if (priv->flags & TC_MQPRIO_F_MAX_RATE)
>> +				for (i = 0; i < mqprio.qopt.num_tc; i++)
>> +					mqprio.max_rate[i] = priv->max_rate[i];
>> +
>> +			err = dev->netdev_ops->ndo_setup_tc(dev,
>> +							    TC_SETUP_MQPRIO_EXT,
>> +							    &mqprio);
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>>   		if (err)
>>   			return err;
>>   
>> -		priv->hw_offload = mqprio.hw;
>> +		priv->hw_offload = mqprio.qopt.hw;
>>   	} else {
>>   		netdev_set_num_tc(dev, qopt->num_tc);
>>   		for (i = 0; i < qopt->num_tc; i++)
>> @@ -223,11 +325,51 @@ static int mqprio_graft(struct Qdisc *sch, unsigned long cl, struct Qdisc *new,
>>   	return 0;
>>   }
>>   
>> +static int dump_rates(struct mqprio_sched *priv,
>> +		      struct tc_mqprio_qopt *opt, struct sk_buff *skb)
>> +{
>> +	struct nlattr *nest;
>> +	int i;
>> +
>> +	if (priv->flags & TC_MQPRIO_F_MIN_RATE) {
>> +		nest = nla_nest_start(skb, TCA_MQPRIO_MIN_RATE64);
>> +		if (!nest)
>> +			goto nla_put_failure;
>> +
>> +		for (i = 0; i < opt->num_tc; i++) {
>> +			if (nla_put(skb, TCA_MQPRIO_MIN_RATE64,
>> +				    sizeof(priv->min_rate[i]),
>> +				    &priv->min_rate[i]))
>> +				goto nla_put_failure;
>> +		}
>> +		nla_nest_end(skb, nest);
>> +	}
>> +
>> +	if (priv->flags & TC_MQPRIO_F_MAX_RATE) {
>> +		nest = nla_nest_start(skb, TCA_MQPRIO_MAX_RATE64);
>> +		if (!nest)
>> +			goto nla_put_failure;
>> +
>> +		for (i = 0; i < opt->num_tc; i++) {
>> +			if (nla_put(skb, TCA_MQPRIO_MAX_RATE64,
>> +				    sizeof(priv->max_rate[i]),
>> +				    &priv->max_rate[i]))
>> +				goto nla_put_failure;
>> +		}
>> +		nla_nest_end(skb, nest);
>> +	}
>> +	return 0;
>> +
>> +nla_put_failure:
>> +	nla_nest_cancel(skb, nest);
>> +	return -1;
>> +}
>> +
>>   static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
>>   {
>>   	struct net_device *dev = qdisc_dev(sch);
>>   	struct mqprio_sched *priv = qdisc_priv(sch);
>> -	unsigned char *b = skb_tail_pointer(skb);
>> +	struct nlattr *nla = (struct nlattr *)skb_tail_pointer(skb);
>>   	struct tc_mqprio_qopt opt = { 0 };
>>   	struct Qdisc *qdisc;
>>   	unsigned int i;
>> @@ -258,12 +400,17 @@ static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
>>   		opt.offset[i] = dev->tc_to_txq[i].offset;
>>   	}
>>   
>> -	if (nla_put(skb, TCA_OPTIONS, sizeof(opt), &opt))
>> +	if (nla_put(skb, TCA_OPTIONS, NLA_ALIGN(sizeof(opt)), &opt))
>>   		goto nla_put_failure;
>>   
>> -	return skb->len;
>> +	if (priv->flags & TC_MQPRIO_F_MIN_RATE ||
>> +	    priv->flags & TC_MQPRIO_F_MAX_RATE)
>> +		if (dump_rates(priv, &opt, skb) != 0)
>> +			goto nla_put_failure;
>> +
>> +	return nla_nest_end(skb, nla);
>>   nla_put_failure:
>> -	nlmsg_trim(skb, b);
>> +	nlmsg_trim(skb, nla);
>>   	return -1;
>>   }
>>   
>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>>
