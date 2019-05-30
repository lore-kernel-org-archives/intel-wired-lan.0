From: Patel, Vedang <vedang.patel@intel.com>
Date: Thu, 30 May 2019 00:15:48 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 3/7] taprio: Add the
 skeleton to enable hardware offloading
In-Reply-To: <20190529140620.68fa8e64@cakuba.netronome.com>
References: <1559065608-27888-1-git-send-email-vedang.patel@intel.com>
 <1559065608-27888-4-git-send-email-vedang.patel@intel.com>
 <20190528154510.41b50723@cakuba.netronome.com>
 <62E2DD49-AC21-46DE-8E5B-EBC67230FA7D@intel.com>
 <20190529121440.46c40967@cakuba.netronome.com>
 <A9D05E0B-FC24-4904-B3E5-1E069C92A3DA@intel.com>
 <20190529140620.68fa8e64@cakuba.netronome.com>
Message-ID: <6A7007D1-3557-4865-89E3-7CC4C4217574@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On May 29, 2019, at 2:06 PM, Jakub Kicinski <jakub.kicinski at netronome.com<mailto:jakub.kicinski@netronome.com>> wrote:

On Wed, 29 May 2019 20:05:16 +0000, Patel, Vedang wrote:
[Sending the email again since the last one was rejected by netdev because it was html.]

On May 29, 2019, at 12:14 PM, Jakub Kicinski <jakub.kicinski at netronome.com<mailto:jakub.kicinski@netronome.com>> wrote:

On Wed, 29 May 2019 17:06:49 +0000, Patel, Vedang wrote:
On May 28, 2019, at 3:45 PM, Jakub Kicinski <jakub.kicinski at netronome.com<mailto:jakub.kicinski@netronome.com>> wrote:
On Tue, 28 May 2019 10:46:44 -0700, Vedang Patel wrote:
From: Vinicius Costa Gomes <vinicius.gomes at intel.com<mailto:vinicius.gomes@intel.com>>

This adds the UAPI and the core bits necessary for userspace to
request hardware offloading to be enabled.

The future commits will enable hybrid or full offloading for taprio. This
commit sets up the infrastructure to enable it via the netlink interface.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes at intel.com<mailto:vinicius.gomes@intel.com>>
Signed-off-by: Vedang Patel <vedang.patel at intel.com<mailto:vedang.patel@intel.com>>

Other qdiscs offload by default, this offload-level selection here is a
little bit inconsistent with that :(

There are 2 different offload modes introduced in this patch.

1. Txtime offload mode: This mode depends on skip_sock_check flag being set in the etf qdisc. Also, it requires some manual configuration which might be specific to the network adapter card. For example, for the i210 card, the user will have to route all the traffic to the highest priority queue and install etf qdisc with offload enabled on that queue. So, I don?t think this mode should be enabled by default.

Excellent, it looks like there will be driver patches necessary for
this offload to function, also it seems your offload enable function
still contains this after the series:

/* FIXME: enable offloading */

Please only post offload infrastructure when fully fleshed out and with
driver patches making use of it.

The above comment refers to the full offload mode described below. It
is not needed for txtime offload mode. Txtime offload mode is
essentially setting the transmit time for each packet  depending on
what interval it is going to be transmitted instead of relying on the
hrtimers to open gates and send packets. More details about why
exactly this is done is mentioned in patch #5[1] of this series.

From looking at this set it looks like I can add that qdisc to any
netdev now *with* offload, and as long as the driver has _any_
ndo_setup_tc implementation taprio will not return an error.

Perhaps this mode of operation should not be called offload?  Can't
the ETF qdisc underneath run in software mode?

Yeah, it doesn?t make much sense to run ETF in software mode but it can be done. What about naming it txtime-assist instead?
What we can do is just add the txtime offload related flag and add
the full offload flag whenever the driver bits are ready. Does that
address your concern?

That would be a step in the right direction.  And please remove all the
other unused code from the series.  AFAICT this is what the enable
offload function looks like after your set - what's the point of the
'err' variable?

Yes. This patch seems to have a few really silly mistakes. I apologize for that. I willl clean it up and send another version of the series. There is no unused code anywhere else in the series.
+static int taprio_enable_offload(struct net_device *dev,
+  struct tc_mqprio_qopt *mqprio,
+  struct taprio_sched *q,
+  struct sched_gate_list *sched,
+  struct netlink_ext_ack *extack,
+  u32 offload_flags)
+{
+ const struct net_device_ops *ops = dev->netdev_ops;
+ int err = 0;
+
+ if (TXTIME_OFFLOAD_IS_ON(offload_flags))
+ goto done;
+
+ if (!FULL_OFFLOAD_IS_ON(offload_flags)) {
+ NL_SET_ERR_MSG(extack, "Offload mode is not supported");
+ return -EOPNOTSUPP;
+ }
+
+ if (!ops->ndo_setup_tc) {
+ NL_SET_ERR_MSG(extack, "Specified device does not support taprio offload");
+ return -EOPNOTSUPP;
+ }
+
+ /* FIXME: enable offloading */
+
+done:
+ if (err == 0) {
+ q->dequeue = taprio_dequeue_offload;
+ q->peek = taprio_peek_offload;
+  q->offload_flags = offload_flags;
+ }
+
+ return err;
+}

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190530/d12ab5f9/attachment-0001.html>
