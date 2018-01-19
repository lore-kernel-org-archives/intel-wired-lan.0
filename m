From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 19 Jan 2018 16:18:43 -0500
Subject: [Intel-wired-lan] [RFC v2 net-next 06/10] net/sched: Introduce
 the TBS Qdisc
In-Reply-To: <20180117230621.26074-7-jesus.sanchez-palencia@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-7-jesus.sanchez-palencia@intel.com>
Message-ID: <CAF=yD-JX+tby+zaU60t+yiTSVBrm0sN4PaMV8cTVXiGm8mjseA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 17, 2018 at 6:06 PM, Jesus Sanchez-Palencia
<jesus.sanchez-palencia@intel.com> wrote:
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>
> TBS (Time Based Scheduler) uses the information added earlier in this
> series (the socket option SO_TXTIME and the new role of
> sk_buff->tstamp) to schedule traffic transmission based on absolute
> time.
>
> For some workloads, just bandwidth enforcement is not enough, and
> precise control of the transmission of packets is necessary.
>
> Example:
>
> $ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
>            map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0
>
> $ tc qdisc add dev enp2s0 parent 100:1 tbs delta 60000 clockid 11 offload 1
>
> In this example, the Qdisc will try to enable offloading (offload 1)
> the control of the transmission time to the network adapter, the
> time stamp in socket are in reference to the clockid '11' (CLOCK_TAI)
> and packets leave the Qdisc "delta" (60000) nanoseconds before its
> transmission time.
>
> When offloading is disabled, the network adapter will ignore the
> sk_buff time stamp, and so, the transmission time will be only "best
> effort" from the Qdisc.
>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
> ---

> +static struct sk_buff *timerqueue_erase(struct Qdisc *sch,
> +                                       struct sk_buff *skb, bool drop)
> +{
> +       struct tbs_sched_data *q = qdisc_priv(sch);
> +
> +       rb_erase(&skb->rbnode, &q->head);
> +
> +       if (drop) {
> +               struct sk_buff *to_free = NULL;
> +
> +               qdisc_drop(skb, sch, &to_free);
> +               kfree_skb_list(to_free);
> +       } else {
> +               qdisc_qstats_backlog_dec(sch, skb);
> +               qdisc_bstats_update(sch, skb);
> +
> +               q->last = skb->tstamp;
> +       }
> +
> +       sch->q.qlen--;
> +
> +       /* The rbnode field in the skb re-uses these fields, now that
> +        * we are done with the rbnode, reset them.
> +        */
> +       skb->next = NULL;
> +       skb->prev = NULL;
> +       skb->dev = qdisc_dev(sch);
> +
> +       return skb;
> +}

Return value is not used in either caller.
