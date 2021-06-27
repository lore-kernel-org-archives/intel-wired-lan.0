From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sun, 27 Jun 2021 20:02:33 +0000
Subject: [Intel-wired-lan] [PATCH net-next v4 04/12] taprio: Replace
 tc_map_to_queue_mask()
In-Reply-To: <20210626003314.3159402-5-vinicius.gomes@intel.com>
References: <20210626003314.3159402-1-vinicius.gomes@intel.com>
 <20210626003314.3159402-5-vinicius.gomes@intel.com>
Message-ID: <20210627200232.mq6bzsxwn25dmill@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jun 25, 2021 at 05:33:06PM -0700, Vinicius Costa Gomes wrote:
> Replaces tc_map_to_queue_mask() by netdev_tc_map_to_queue_mask() that
> was just introduced.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  net/sched/sch_taprio.c | 26 ++++----------------------
>  1 file changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 58586f98c648..4e411ca3a9eb 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1201,25 +1201,6 @@ static void taprio_offload_config_changed(struct taprio_sched *q)
>  	spin_unlock(&q->current_entry_lock);
>  }
>  
> -static u32 tc_map_to_queue_mask(struct net_device *dev, u32 tc_mask)
> -{
> -	u32 i, queue_mask = 0;
> -
> -	for (i = 0; i < dev->num_tc; i++) {
> -		u32 offset, count;
> -
> -		if (!(tc_mask & BIT(i)))
> -			continue;
> -
> -		offset = dev->tc_to_txq[i].offset;
> -		count = dev->tc_to_txq[i].count;
> -
> -		queue_mask |= GENMASK(offset + count - 1, offset);
> -	}
> -
> -	return queue_mask;
> -}
> -
>  static void taprio_sched_to_offload(struct net_device *dev,
>  				    struct sched_gate_list *sched,
>  				    struct tc_taprio_qopt_offload *offload)
> @@ -1236,7 +1217,7 @@ static void taprio_sched_to_offload(struct net_device *dev,
>  
>  		e->command = entry->command;
>  		e->interval = entry->interval;
> -		e->gate_mask = tc_map_to_queue_mask(dev, entry->gate_mask);
> +		e->gate_mask = netdev_tc_map_to_queue_mask(dev, entry->gate_mask);
>  
>  		i++;
>  	}
> @@ -1536,14 +1517,15 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
>  	if (tb[TCA_TAPRIO_ATTR_PREEMPT_TCS]) {
>  		u32 preempt = nla_get_u32(tb[TCA_TAPRIO_ATTR_PREEMPT_TCS]);
>  		struct tc_preempt_qopt_offload qopt = { };
> +		u32 all_tcs_mask = GENMASK(mqprio->num_tc, 0);
>  
> -		if (preempt == U32_MAX) {
> +		if ((preempt & all_tcs_mask) == all_tcs_mask) {

Ouch, this patch does more than it says on the box.
If it did only what the commit message said, it could have just as well
been squashed with the previous one (and this extra change squashed with
the "preemptible queues in taprio" patch. Practically it means that
these last two patches should go before the "preemptible queues in taprio" one.

>  			NL_SET_ERR_MSG(extack, "At least one queue must be not be preemptible");
>  			err = -EINVAL;
>  			goto free_sched;
>  		}
>  
> -		qopt.preemptible_queues = tc_map_to_queue_mask(dev, preempt);
> +		qopt.preemptible_queues = netdev_tc_map_to_queue_mask(dev, preempt);
>  
>  		err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_PREEMPT,
>  						    &qopt);
> -- 
> 2.32.0
> 
