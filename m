From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 27 Sep 2017 14:14:52 -0700
Subject: [Intel-wired-lan] [next-queue PATCH 2/3] net/sched: Introduce
	Credit Based Shaper (CBS) qdisc
In-Reply-To: <CAM_iQpVrz+e=TYHYqaYyUWRP528GSZXx8EnN1yPhZK8eLvP4Yw@mail.gmail.com>
References: <20170926233916.11774-1-vinicius.gomes@intel.com>
 <20170926233916.11774-3-vinicius.gomes@intel.com>
 <CAM_iQpVrz+e=TYHYqaYyUWRP528GSZXx8EnN1yPhZK8eLvP4Yw@mail.gmail.com>
Message-ID: <87lgkzg7xv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Cong Wang <xiyou.wangcong@gmail.com> writes:

> On Tue, Sep 26, 2017 at 4:39 PM, Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>> +static int cbs_init(struct Qdisc *sch, struct nlattr *opt)
>> +{
>> +       struct cbs_sched_data *q = qdisc_priv(sch);
>> +       struct net_device *dev = qdisc_dev(sch);
>> +
>> +       if (!opt)
>> +               return -EINVAL;
>> +
>> +       /* FIXME: this means that we can only install this qdisc
>> +        * "under" mqprio. Do we need a more generic way to retrieve
>> +        * the queue, or do we pass the netdev_queue to the driver?
>> +        */
>> +       q->queue = TC_H_MIN(sch->parent) - 1 - netdev_get_num_tc(dev);
>> +
>> +       return cbs_change(sch, opt);
>> +}
>
> Yeah it is ugly to assume its parent is mqprio, at least you should
> error out if it is not the case.

Will add an error for this, for now.

>
> I am not sure how we can solve this elegantly, perhaps you should
> extend mqprio rather than add a new one?

Is the alternative hinted in the FIXME worse? Instead of passing the
index of the hardware queue to the driver we pass the pointer to a
netdev_queue to the driver and it "discovers" the HW queue from that.


Cheers,
--
Vinicius
