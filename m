From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 29 Jan 2021 23:16:05 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 6/8] igc: Add support for
 tuning frame preemption via ethtool
In-Reply-To: <87pn1nsabj.fsf@vcostago-mobl2.amr.corp.intel.com>
References: <20210122224453.4161729-1-vinicius.gomes@intel.com>
 <20210122224453.4161729-7-vinicius.gomes@intel.com>
 <20210126003243.x3c44pmxmieqsa6e@skbuf>
 <87pn1nsabj.fsf@vcostago-mobl2.amr.corp.intel.com>
Message-ID: <20210129231604.vzndqnf3tkcgo4ya@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 29, 2021 at 01:27:28PM -0800, Vinicius Costa Gomes wrote:
> >> +static int igc_ethtool_set_preempt(struct net_device *netdev,
> >> +				   struct ethtool_fp *fpcmd,
> >> +				   struct netlink_ext_ack *extack)
> >> +{
> >> +	struct igc_adapter *adapter = netdev_priv(netdev);
> >> +	int i;
> >> +
> >> +	if (fpcmd->add_frag_size < 68 || fpcmd->add_frag_size > 260) {
> >> +		NL_SET_ERR_MSG_MOD(extack, "Invalid value for add-frag-size");
> >> +		return -EINVAL;
> >> +	}
> >
> > This check should belong in ethtool, since there's nothing unusual about
> > this supported range.
> >
> > Also, I believe that Jakub requested the min-frag-size to be passed as
> > 0, 1, 2, 3 as the standard specifies it, and not its multiplied
> > version?
> 
> Later, Michal Kubechek suggested using the multiplied value, to be
> future proof and less dependent on some specific standard version.

Imagine you're adding frame preemption to some LLDP agent and you want
to pass that data to the kernel. Case (a) you read the value as {0, 1,
2, 3} and you pass it to the kernel as {0, 1, 2, 3}. Case (b) you read
the value as {0, 1, 2, 3}, you prove to the kernel that you're a smart
boy and you know the times 64 multiplication table minus 4, and if you
pass the exam, the kernel calls ethtool_frag_size_to_mult again, to
retrieve the {0, 1, 2, 3} form which it'll use to program the hardware
with (oh and btw, ethtool_frag_size_to_mult allows any value to be
passed in, so it tricks users into thinking that any other value except
60, 124, 188, 252 might have a different effect, cause them to wonder
what is 123 even rounded to, etc).
And halfway through writing the user space code for case (b), you're
thinking "good thing I'm making this LLDP TLV more future-proof by
multiplying it with 64..."

Also, so shady this specific standard called IEEE 802.3-2018.....
Frame preemption is past draft status, it's safe to say it won't change
in backwards-incompatible ways, this isn't Python. If anything, we'll
give them another reason not to.

> >> +	adapter->frame_preemption_active = fpcmd->enabled;
> >> +	adapter->add_frag_size = fpcmd->add_frag_size;
> >> +
> >> +	if (!adapter->frame_preemption_active)
> >> +		goto done;
> >> +
> >> +	/* Enabling frame preemption requires TSN mode to be enabled,
> >> +	 * which requires a schedule to be active. So, if there isn't
> >> +	 * a schedule already configured, configure a simple one, with
> >> +	 * all queues open, with 1ms cycle time.
> >> +	 */
> >> +	if (adapter->base_time)
> >> +		goto done;
> >
> > Unless I'm missing something, you are interpreting an adapter->base_time
> > value of zero as "no Qbv schedule on port", as if it was invalid to have
> > a base-time of zero, which it isn't.
> 
> This HW has specific limitations, it doesn't allow a base_time in the
> past. So a base_time of zero can be used to signify "No Qbv".

Oh and by past you mean future?

	/* If we program the controller's BASET registers with a time
	 * in the future, it will hold all the packets until that
	 * time, causing a lot of TX Hangs, so to avoid that, we
	 * reject schedules that would start in the future.
	 */
	if (!is_base_time_past(qopt->base_time, &now))
		return false;

Buggy hardware notwithstanding, but you wrote in "man 8 tc-taprio" that

       base-time
              Specifies the instant in nanoseconds, using the reference
              of clockid, defining the time when the schedule starts. If
              'base-time' is a time in the past, the schedule will start
              at

              base-time + (N * cycle-time)

              where N is the smallest integer so the resulting time is
              greater than "now", and "cycle-time" is the sum of all the
              intervals of the entries in the schedule

Does that not apply to schedules offloaded on Intel hardware?
You're okay with any base-time in the past (your hardware basically
requires them) but the base-time of zero is somehow special and not
valid because?

> > Out of curiosity, where is the ring to traffic class mapping configured
> > in the igc driver? I suppose that you have more rings than traffic classes.
> 
> The driver follows the default behaviour, that netdev->queue[0] maps to
> ring[0], queue[1] to ring[1], and so on. And by default ring[0] has
> higher priority than ring[1], ring[1] higher than ring[2], and so on.
> 
> The HW only has 4 rings/queues.

I meant to ask: is the priority of rings 0, 1, 2, 3 configurable? If so,
where is it configured by the driver? I want to understand better the
world that you're coming from, with this whole "preemptable rings"
instead of "preemptable traffic classes" thing.
IEEE 802.1Q-2018 clause 12.30.1.1.1 framePreemptionAdminStatus talks
about reporting preemption status per priority/traffic class, not per
queue/ring. Granted, I may be trapped in my own strange world here, but
say a driver has 16 rings mapped to 8 priorities like enetc does, I
think it's super odd that taprio calls tc_map_to_queue_mask before
passing the gate_mask to ndo_setup_tc. It's the kind of thing that makes
you wonder if you should put some sort of paranoid conflict resolution
checks in the code, what if queues 0 and 1, which have the same
priority, have different values in the gate_mask, what do I program into
my hardware which operates per priority as the standard actually says?
