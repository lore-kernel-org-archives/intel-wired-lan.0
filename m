From: Guedes, Andre <andre.guedes@intel.com>
Date: Wed, 27 Sep 2017 23:11:01 +0000
Subject: [Intel-wired-lan] [next-queue PATCH 2/3] net/sched: Introduce
 Credit Based Shaper (CBS) qdisc
In-Reply-To: <4b0e1610-c9df-191d-496e-4be04c785d2f@intel.com>
References: <20170926233916.11774-1-vinicius.gomes@intel.com>
 <20170926233916.11774-3-vinicius.gomes@intel.com>
 <CAM_iQpVrz+e=TYHYqaYyUWRP528GSZXx8EnN1yPhZK8eLvP4Yw@mail.gmail.com>
 <87lgkzg7xv.fsf@intel.com> <4b0e1610-c9df-191d-496e-4be04c785d2f@intel.com>
Message-ID: <1506553861.4536.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2017-09-27 at 15:57 -0700, Jesus Sanchez-Palencia wrote:
> Hi,
> 
> 
> On 09/27/2017 02:14 PM, Vinicius Costa Gomes wrote:
> > Hi,
> > 
> > Cong Wang <xiyou.wangcong@gmail.com> writes:
> > 
> > > On Tue, Sep 26, 2017 at 4:39 PM, Vinicius Costa Gomes
> > > <vinicius.gomes@intel.com> wrote:
> > > > +static int cbs_init(struct Qdisc *sch, struct nlattr *opt)
> > > > +{
> > > > +???????struct cbs_sched_data *q = qdisc_priv(sch);
> > > > +???????struct net_device *dev = qdisc_dev(sch);
> > > > +
> > > > +???????if (!opt)
> > > > +???????????????return -EINVAL;
> > > > +
> > > > +???????/* FIXME: this means that we can only install this qdisc
> > > > +????????* "under" mqprio. Do we need a more generic way to retrieve
> > > > +????????* the queue, or do we pass the netdev_queue to the driver?
> > > > +????????*/
> > > > +???????q->queue = TC_H_MIN(sch->parent) - 1 - netdev_get_num_tc(dev);
> > > > +
> > > > +???????return cbs_change(sch, opt);
> > > > +}
> > > 
> > > Yeah it is ugly to assume its parent is mqprio, at least you should
> > > error out if it is not the case.
> > 
> > Will add an error for this, for now.
> > 
> > > 
> > > I am not sure how we can solve this elegantly, perhaps you should
> > > extend mqprio rather than add a new one?
> > 
> > Is the alternative hinted in the FIXME worse? Instead of passing the
> > index of the hardware queue to the driver we pass the pointer to a
> > netdev_queue to the driver and it "discovers" the HW queue from that.

I don't see why we should move the queue index "discovery" into the driver. The
driver layer should be dead simple and getting the queue index from the upper
layer (qdisc) looks right to me.

> What if we keep passing the index, but calculate it from the netdev_queue
> pointer instead?
> 
> i.e.:??q->queue = sch->dev_queue - netdev_get_tx_queue(dev, 0);
> 
> At least it wouldn't rely on the root qdisc being of any specific type.

+1

- Andre
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3262 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170927/a1a550c0/attachment-0001.bin>
