From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 29 Jan 2021 13:13:24 -0800
Subject: [Intel-wired-lan] [PATCH net-next v3 2/8] taprio: Add support
 for frame preemption offload
In-Reply-To: <20210126000924.jjkjruzmh5lgrkry@skbuf>
References: <20210122224453.4161729-1-vinicius.gomes@intel.com>
 <20210122224453.4161729-3-vinicius.gomes@intel.com>
 <20210126000924.jjkjruzmh5lgrkry@skbuf>
Message-ID: <87wnvvsayz.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> On Fri, Jan 22, 2021 at 02:44:47PM -0800, Vinicius Costa Gomes wrote:
>> +	/* It's valid to enable frame preemption without any kind of
>> +	 * offloading being enabled, so keep it separated.
>> +	 */
>> +	if (tb[TCA_TAPRIO_ATTR_PREEMPT_TCS]) {
>> +		u32 preempt = nla_get_u32(tb[TCA_TAPRIO_ATTR_PREEMPT_TCS]);
>> +		struct tc_preempt_qopt_offload qopt = { };
>> +
>> +		if (preempt == U32_MAX) {
>> +			NL_SET_ERR_MSG(extack, "At least one queue must be not be preemptible");
>> +			err = -EINVAL;
>> +			goto free_sched;
>> +		}
>> +
>> +		qopt.preemptible_queues = tc_map_to_queue_mask(dev, preempt);
>> +
>> +		err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_PREEMPT,
>> +						    &qopt);
>> +		if (err)
>> +			goto free_sched;
>> +
>> +		q->preemptible_tcs = preempt;
>> +	}
>> +
>
> First I'm interested in the means: why check for preempt == U32_MAX when
> you determine that all traffic classes are preemptible? What if less
> than 32 traffic classes are used by the netdev? The check will be
> bypassed, won't it?

Good catch :-)

I wanted to have this (at least one express queue) handled in a
centralized way, but perhaps this should be handled best per driver.

>
> Secondly, why should at least one queue be preemptible? What's wrong
> with frame preemption being triggered by a tc-taprio window smaller than
> the packet size? This can happen regardless of traffic class.

It's the opposite, at least one queue needs to be marked
express/non-preemptible. But as I said above, perhaps this should be
handled in a per-driver way. I will remove this from taprio.

I think removing this check/limitation from taprio should solve the
second part of your question, right?


Cheers,
-- 
Vinicius
