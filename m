From: Jiri Pirko <jiri@resnulli.us>
Date: Wed, 4 Oct 2017 08:36:50 +0200
Subject: [Intel-wired-lan] [next-queue PATCH v4 3/4] net/sched:
 Introduce Credit Based Shaper (CBS) qdisc
In-Reply-To: <20171004002831.18371-4-vinicius.gomes@intel.com>
References: <20171004002831.18371-1-vinicius.gomes@intel.com>
 <20171004002831.18371-4-vinicius.gomes@intel.com>
Message-ID: <20171004063650.GA1895@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Wed, Oct 04, 2017 at 02:28:30AM CEST, vinicius.gomes at intel.com wrote:
>This queueing discipline implements the shaper algorithm defined by
>the 802.1Q-2014 Section 8.6.8.2 and detailed in Annex L.
>
>It's primary usage is to apply some bandwidth reservation to user
>defined traffic classes, which are mapped to different queues via the
>mqprio qdisc.
>
>Initially, it only supports offloading the traffic shaping work to
>supporting controllers.
>
>Later, when a software implementation is added, the current dependency
>on being installed "under" mqprio can be lifted.
>
>Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
>---
> include/linux/netdevice.h      |   1 +
> include/net/pkt_sched.h        |   9 ++
> include/uapi/linux/pkt_sched.h |  17 ++++
> net/sched/Kconfig              |  11 ++
> net/sched/Makefile             |   1 +
> net/sched/sch_cbs.c            | 225 +++++++++++++++++++++++++++++++++++++++++
> 6 files changed, 264 insertions(+)
> create mode 100644 net/sched/sch_cbs.c
>
>diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>index e1d6ef130611..b8798adc214f 100644
>--- a/include/linux/netdevice.h
>+++ b/include/linux/netdevice.h
>@@ -775,6 +775,7 @@ enum tc_setup_type {
> 	TC_SETUP_CLSFLOWER,
> 	TC_SETUP_CLSMATCHALL,
> 	TC_SETUP_CLSBPF,
>+	TC_SETUP_CBS,

Please split this into 2 patches. One will introduce the new qdisc,
second will add offload capabilities.

[...]

	
>+static struct Qdisc_ops cbs_qdisc_ops __read_mostly = {
>+	.next		=	NULL,
>+	.id		=	"cbs",
>+	.priv_size	=	sizeof(struct cbs_sched_data),
>+	.enqueue	=	cbs_enqueue,
>+	.dequeue	=	qdisc_dequeue_head,
>+	.peek		=	qdisc_peek_dequeued,
>+	.init		=	cbs_init,
>+	.reset		=	qdisc_reset_queue,
>+	.destroy	=	cbs_destroy,
>+	.change		=	cbs_change,
>+	.dump		=	cbs_dump,
>+	.owner		=	THIS_MODULE,
>+};

I don't see a software implementation for this. Looks like you are
trying abuse tc subsystem to bypass kernel. Could you please explain
this? The golden rule is: implement in kernel, then offload.
