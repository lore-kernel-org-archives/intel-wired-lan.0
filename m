From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 17 May 2021 22:48:33 +0200
Subject: [Intel-wired-lan] [PATCH tip:irq/core v1] genirq: remove
 auto-set of the mask when setting the hint
In-Reply-To: <20210504092340.00006c61@intel.com>
Message-ID: <87pmxpdr32.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 04 2021 at 09:23, Jesse Brandeburg wrote:
> I'd add in addition that irqbalance daemon *stopped* paying attention
> to hints quite a while ago, so I'm not quite sure what purpose they
> serve.

The hint was added so that userspace has a better understanding where it
should place the interrupt. So if irqbalanced ignores it anyway, then
what's the point of the hint? IOW, why is it still used drivers?

Now there is another aspect to that. What happens if irqbalanced does
not run at all and a driver relies on the side effect of the hint
setting the initial affinity. Bah...

While none of the drivers (except the perf muck) actually prevents
userspace from fiddling with the affinity (via IRQF_NOBALANCING) a
deeper inspection shows that they actually might rely on the current
behaviour if irqbalanced is disabled. Of course every driver has its own
convoluted way to do that and all of those functions are well
documented. What a mess.

If the hint still serves a purpose then we can provide a variant which
solely applies the hint and does not fiddle with the actual affinity,
but if the hint is useless anyway then we have a way better option to
clean that up.

Most users are in networking, there are a few in crypto, a couple of
leftovers in scsi, virtio and a handfull of oddball drivers.

The perf muck wants to be cleaned up anyway as it's just crystal clear
abuse.

Thanks,

        tglx
