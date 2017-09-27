From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 27 Sep 2017 13:23:22 -0700
Subject: [Intel-wired-lan] [next-queue PATCH 2/3] net/sched: Introduce
 Credit Based Shaper (CBS) qdisc
In-Reply-To: <20170926233916.11774-3-vinicius.gomes@intel.com>
References: <20170926233916.11774-1-vinicius.gomes@intel.com>
 <20170926233916.11774-3-vinicius.gomes@intel.com>
Message-ID: <CAM_iQpVrz+e=TYHYqaYyUWRP528GSZXx8EnN1yPhZK8eLvP4Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Sep 26, 2017 at 4:39 PM, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
> +static int cbs_init(struct Qdisc *sch, struct nlattr *opt)
> +{
> +       struct cbs_sched_data *q = qdisc_priv(sch);
> +       struct net_device *dev = qdisc_dev(sch);
> +
> +       if (!opt)
> +               return -EINVAL;
> +
> +       /* FIXME: this means that we can only install this qdisc
> +        * "under" mqprio. Do we need a more generic way to retrieve
> +        * the queue, or do we pass the netdev_queue to the driver?
> +        */
> +       q->queue = TC_H_MIN(sch->parent) - 1 - netdev_get_num_tc(dev);
> +
> +       return cbs_change(sch, opt);
> +}

Yeah it is ugly to assume its parent is mqprio, at least you should
error out if it is not the case.

I am not sure how we can solve this elegantly, perhaps you should
extend mqprio rather than add a new one?
