From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 11 Oct 2017 14:40:00 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v5 4/5] net/sched: Add
	support for HW offloading for CBS
In-Reply-To: <20171011070751.GC2039@nanopsycho>
References: <20171011004400.14946-1-vinicius.gomes@intel.com>
 <20171011004400.14946-5-vinicius.gomes@intel.com>
 <20171011070751.GC2039@nanopsycho>
Message-ID: <87shepmki7.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jiri Pirko <jiri@resnulli.us> writes:

[...]

>>+static void disable_cbs_offload(struct net_device *dev,
>>+				struct cbs_sched_data *q)
>>+{
>>+	struct tc_cbs_qopt_offload cbs = { };
>>+	const struct net_device_ops *ops;
>>+	int err;
>>+
>>+	if (!q->offload)
>>+		return;
>>+
>>+	ops = dev->netdev_ops;
>>+	if (!ops->ndo_setup_tc)
>>+		return;
>>+
>>+	cbs.queue = q->queue;
>>+	cbs.enable = 0;
>>+
>>+	err = ops->ndo_setup_tc(dev, TC_SETUP_CBS, &cbs);
>>+	if (err < 0)
>>+		pr_warn("Couldn't disable CBS offload for queue %d\n",
>>+			cbs.queue);
>
> Hmm, you have separete helper for disable, yet you have enable spread
> over cbs_change. Please push the enable code into enable_cbs_offload.
> While you are at it, change the names to cbs_ to maintain the qdisc
> prefix in function names: cbs_offload_enable/cbs_offload_disable
>

Sure.


Cheers,
--
Vinicius
