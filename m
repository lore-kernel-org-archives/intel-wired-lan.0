From: Patel, Vedang <vedang.patel@intel.com>
Date: Fri, 7 Jun 2019 20:42:55 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 4/6] taprio: Add support
 for txtime-assist mode.
In-Reply-To: <20190606162132.0591cc37@cakuba.netronome.com>
References: <1559843458-12517-1-git-send-email-vedang.patel@intel.com>
 <1559843458-12517-5-git-send-email-vedang.patel@intel.com>
 <20190606162132.0591cc37@cakuba.netronome.com>
Message-ID: <FF3C8B8E-421E-4C93-8895-C21A38BB55EE@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks Jacub for the feedback. My comments are inline.

I will wait a few more days for more feedback/discussions on the series and then post the next version of the series. 

> On Jun 6, 2019, at 4:21 PM, Jakub Kicinski <jakub.kicinski@netronome.com> wrote:
> 
> On Thu,  6 Jun 2019 10:50:56 -0700, Vedang Patel wrote:
>> Currently, we are seeing non-critical packets being transmitted outside of
>> their timeslice. We can confirm that the packets are being dequeued at the
>> right time. So, the delay is induced in the hardware side.  The most likely
>> reason is the hardware queues are starving the lower priority queues.
>> 
>> In order to improve the performance of taprio, we will be making use of the
>> txtime feature provided by the ETF qdisc. For all the packets which do not
>> have the SO_TXTIME option set, taprio will set the transmit timestamp (set
>> in skb->tstamp) in this mode. TAPrio Qdisc will ensure that the transmit
>> time for the packet is set to when the gate is open. If SO_TXTIME is set,
>> the TAPrio qdisc will validate whether the timestamp (in skb->tstamp)
>> occurs when the gate corresponding to skb's traffic class is open.
>> 
>> Following two parameters added to support this mode:
>> - flags: used to enable txtime-assist mode. Will also be used to enable
>>  other modes (like hardware offloading) later.
>> - txtime-delay: This indicates the minimum time it will take for the packet
>>  to hit the wire after it reaches taprio_enqueue(). This is useful in
>>  determining whether we can transmit the packet in the remaining time if
>>  the gate corresponding to the packet is currently open.
>> 
>> An example configuration for enabling txtime-assist:
>> 
>> tc qdisc replace dev eth0 parent root handle 100 taprio \\
>>      num_tc 3 \\
>>      map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \\
>>      queues 1 at 0 1 at 0 1 at 0 \\
>>      base-time 1558653424279842568 \\
>>      sched-entry S 01 300000 \\
>>      sched-entry S 02 300000 \\
>>      sched-entry S 04 400000 \\
>>      flags 0x1 \\
>>      txtime-delay 40000 \\
>>      clockid CLOCK_TAI
>> 
>> tc qdisc replace dev $IFACE parent 100:1 etf skip_sock_check \\
>>      offload delta 200000 clockid CLOCK_TAI
>> 
>> Note that all the traffic classes are mapped to the same queue.  This is
>> only possible in taprio when txtime-assist is enabled. Also, note that the
>> ETF Qdisc is enabled with offload mode set.
>> 
>> In this mode, if the packet's traffic class is open and the complete packet
>> can be transmitted, taprio will try to transmit the packet immediately.
>> This will be done by setting skb->tstamp to current_time + the time delta
>> indicated in the txtime-delay parameter. This parameter indicates the time
>> taken (in software) for packet to reach the network adapter.
>> 
>> If the packet cannot be transmitted in the current interval or if the
>> packet's traffic is not currently transmitting, the skb->tstamp is set to
>> the next available timestamp value. This is tracked in the next_launchtime
>> parameter in the struct sched_entry.
>> 
>> The behaviour w.r.t admin and oper schedules is not changed from what is
>> present in software mode.
>> 
>> The transmit time is already known in advance. So, we do not need the HR
>> timers to advance the schedule and wakeup the dequeue side of taprio.  So,
>> HR timer won't be run when this mode is enabled.
>> 
>> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
>> ---
>> include/uapi/linux/pkt_sched.h |   4 +
>> net/sched/sch_taprio.c         | 344 +++++++++++++++++++++++++++++++++++++++--
>> 2 files changed, 331 insertions(+), 17 deletions(-)
>> 
>> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
>> index 69fc52e4d6bd..c085860ff637 100644
>> --- a/include/uapi/linux/pkt_sched.h
>> +++ b/include/uapi/linux/pkt_sched.h
>> @@ -1159,6 +1159,8 @@ enum {
>>  *       [TCA_TAPRIO_ATTR_SCHED_ENTRY_INTERVAL]
>>  */
>> 
>> +#define TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST 0x1
>> +
>> enum {
>> 	TCA_TAPRIO_ATTR_UNSPEC,
>> 	TCA_TAPRIO_ATTR_PRIOMAP, /* struct tc_mqprio_qopt */
>> @@ -1170,6 +1172,8 @@ enum {
>> 	TCA_TAPRIO_ATTR_ADMIN_SCHED, /* The admin sched, only used in dump */
>> 	TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME, /* s64 */
>> 	TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION, /* s64 */
>> +	TCA_TAPRIO_ATTR_FLAGS, /* u32 */
>> +	TCA_TAPRIO_ATTR_TXTIME_DELAY, /* s32 */
>> 	__TCA_TAPRIO_ATTR_MAX,
>> };
>> 
>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>> index a41d7d4434ee..a5676fb2b2dd 100644
>> --- a/net/sched/sch_taprio.c
>> +++ b/net/sched/sch_taprio.c
>> @@ -21,12 +21,17 @@
>> #include <net/pkt_sched.h>
>> #include <net/pkt_cls.h>
>> #include <net/sch_generic.h>
>> +#include <net/sock.h>
>> 
>> static LIST_HEAD(taprio_list);
>> static DEFINE_SPINLOCK(taprio_list_lock);
>> 
>> #define TAPRIO_ALL_GATES_OPEN -1
>> 
>> +#define FLAGS_VALID(flags) (!((flags) & ~TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST))
>> +#define TXTIME_ASSIST_IS_ENABLED(flags) (FLAGS_VALID((flags)) && \
>> +				 ((flags) & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST))
> 
> Thanks for the changes, since you now validate no unknown flags are
> passed, perhaps there is no need to check if flags are == ~0?
> 
> IS_ENABLED() could just do: (flags) & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST
> No?
> 
This is specifically done so that user does not have to specify the offload flags when trying to install the another schedule which will be switched to at a later point of time (i.e. the admin schedule introduced in Vinicius? last series). Setting taprio_flags to ~0 willl help us distinguish between the flags parameter not specified and flags set to 0.
>> @@ -708,6 +978,7 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
>> 	struct taprio_sched *q = qdisc_priv(sch);
>> 	struct net_device *dev = qdisc_dev(sch);
>> 	struct tc_mqprio_qopt *mqprio = NULL;
>> +	u32 taprio_flags = U32_MAX;
> 
> Then this should default to 0, i.e. no flag set..
> 
>> 	int i, err, clockid;
>> 	unsigned long flags;
>> 	ktime_t start;
>> @@ -720,7 +991,21 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
>> 	if (tb[TCA_TAPRIO_ATTR_PRIOMAP])
>> 		mqprio = nla_data(tb[TCA_TAPRIO_ATTR_PRIOMAP]);
>> 
>> -	err = taprio_parse_mqprio_opt(dev, mqprio, extack);
>> +	if (tb[TCA_TAPRIO_ATTR_FLAGS]) {
>> +		taprio_flags = nla_get_u32(tb[TCA_TAPRIO_ATTR_FLAGS]);
>> +
>> +		if (q->flags != 0) {
>> +			NL_SET_ERR_MSG(extack, "Changing 'flags' of a running schedule is not supported");
> 
> So the parameter must not be passed at all?  Perhaps it's fine if:
> 
> 	q->flags == taprio_flags
> 
> ?
> 
Yes, that is true. I will make the change in the next version.
> also: NL_SET_ERR_MSG_MOD() is better here
> 
>> +			return -ENOTSUPP;
> 
> Probably EINVAL or EOPNOTSUPP, ENOTSUPP is a high error code which libc
> doesn't understand, it's best avoided.
> 
Ok I will make that change in the next series.
>> +		} else if (!FLAGS_VALID(taprio_flags)) {
>> +			NL_SET_ERR_MSG(extack, "Specified 'flags' are not valid.");
> 
> nit: you didn't have a period at the end of the previous extack
> 
Will include it in the next series.
>> +			return -ENOTSUPP;
>> +		}
>> +
>> +		q->flags = taprio_flags;
>> +	}
>> +
>> +	err = taprio_parse_mqprio_opt(dev, mqprio, extack, taprio_flags);
>> 	if (err < 0)
>> 		return err;
>> 
>> @@ -779,7 +1064,11 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
>> 	/* Protects against enqueue()/dequeue() */
>> 	spin_lock_bh(qdisc_lock(sch));
>> 
>> -	if (!hrtimer_active(&q->advance_timer)) {
>> +	if (tb[TCA_TAPRIO_ATTR_TXTIME_DELAY])
>> +		q->txtime_delay = nla_get_s32(tb[TCA_TAPRIO_ATTR_TXTIME_DELAY]);
> 
> Perhaps this attribute should only be allowed if flags enabled
> txtime-assist?
> 
Yes, this is required change for incorporating feedback from Stephen Hemminger. It will be included in the next version.
>> +	if (!TXTIME_ASSIST_IS_ENABLED(taprio_flags) &&
>> +	    !hrtimer_active(&q->advance_timer)) {
>> 		hrtimer_init(&q->advance_timer, q->clockid, HRTIMER_MODE_ABS);
>> 		q->advance_timer.function = advance_sched;
>> 	}

