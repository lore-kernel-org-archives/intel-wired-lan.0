From: Limonciello, Mario <Mario.Limonciello@dell.com>
Date: Mon, 7 Dec 2020 15:41:48 +0000
Subject: [Intel-wired-lan] [PATCH v3 0/7] Improve s0ix flows for systems
 i219LM
In-Reply-To: <d0f7e565-05e1-437e-4342-55eb73daa907@redhat.com>
References: <20201204200920.133780-1-mario.limonciello@dell.com>
 <d0f7e565-05e1-437e-4342-55eb73daa907@redhat.com>
Message-ID: <DM6PR19MB2636A4097B68DBB253C416D8FACE0@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> First of all thank you for working on this.
> 
> I must say though that I don't like the approach taken here very
> much.
> 
> This is not so much a criticism of this series as it is a criticism
> of the earlier decision to simply disable s0ix on all devices
> with the i219-LM + and active ME.

I was not happy with that decision either as it did cause regressions
on all of the "named" Comet Lake laptops that were in the market at
the time.  The "unnamed" ones are not yet released, and I don't feel
it's fair to call it a regression on "unreleased" hardware.

> 
> AFAIK there was a perfectly acceptable patch to workaround those
> broken devices, which increased a timeout:
> https://patchwork.ozlabs.org/project/intel-wired-
> lan/patch/20200323191639.48826-1-aaron.ma at canonical.com/
> 
> That patch was nacked because it increased the resume time
> *on broken devices*.
> 
> So it seems to me that we have a simple choice here:
> 
> 1. Longer resume time on devices with an improperly configured ME
> 2. Higher power-consumption on all non-buggy devices
> 
> Your patches 4-7 try to workaround 2. but IMHO those are just
> bandaids for getting the initial priorities *very* wrong.

They were done based upon the discussion in that thread you linked and others.
If the owners of this driver feel it's possible/scalable to follow your proposal
I'm happy to resubmit a new v4 series with these sets of patches:

1) Fixup for the exception corner case referenced in this thread
2) Patch 1 from this series that fixes cable connected case
3) Increase the timeout (from your referenced link)
4) Revert the ME disallow list

> 
> Instead of penalizing non-buggy devices with a higher power-consumption,
> we should default to penalizing the buggy devices with a higher
> resume time. And if it is decided that the higher resume time is
> a worse problem then the higher power-consumption, then there
> should be a list of broken devices and s0ix can be disabled on those.

I'm perfectly happy either way, my primary goal is that Dell's notebooks and
desktops that meet the architectural and firmware guidelines for appropriate
low power consumption over s0ix are not penalized.

> 
> The current allow-list approach is simply never going to work well
> leading to too high power-consumption on countless devices.
> This is going to be an endless game of whack-a-mole and as
> such really is a bad idea.

I envisioned that it would evolve over time.  For example if by the time Dell
finished shipping new CML models it was deemed that all the CML hardware was done
properly it could instead by an allow list of Dell + Comet Point.
If all of Tiger Lake are done properly 'maybe' by the time the ML ships maybe it
could be an allow list of Dell + CML or newer.

But even if the heuristic changed - this particular configuration needs to be tested
on every single new model.  All of the notebooks that have a Tested-By clause were
checked by Dell and Dell's partners.

> 
> A deny-list for broken devices is a much better approach, esp.
> since missing devices on that list will still work fine, they
> will just have a somewhat larger resume time.

I don't have configuration deemed buggy.  Since you were commenting in that other
thread with the patch from Aaaron It sounds like you do. Can you perhaps check if
that proposal actually works?

> 
> So what needs to happen IMHO is:
> 
> 1. Merge your fix from patch 1 of this set
> 2. Merge "e1000e: bump up timeout to wait when ME un-configure ULP mode"
> 3. Drop the e1000e_check_me check.
> 
> Then we also do not need the new "s0ix-enabled" ethertool flag
> because we do not need userspace to work-around us doing the
> wrong thing by default.

If we collectively agree to keep either an allow list "or" disallow list at
all I think you need a way check whether enabling this feature works.

If we are making an assertion it will always work properly all the time, I agree
that there is no need for an ethtool flag.

> 
> Note a while ago I had access to one of the devices having suspend/resume
> issues caused by the S0ix support (a Lenovo Thinkpad X1 Carbon gen 7)
> and I can confirm that the "e1000e: bump up timeout to wait when ME
> un-configure ULP mode" patch fixes the suspend/resume problem without
> any noticeable negative side-effects.
> 

Can you or someone else with this model please check with a current kernel
w/ reverting ME check and adding the patch from Vitaly (included as patch 1
in my series)?

> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> 
> 
> 
> >
> > Changes from v2 to v3:
> >  - Correct some grammar and spelling issues caught by Bjorn H.
> >    * s/s0ix/S0ix/ in all commit messages
> >    * Fix a typo in commit message
> >    * Fix capitalization of proper nouns
> >  - Add more pre-release systems that pass
> >  - Re-order the series to add systems only at the end of the series
> >  - Add Fixes tag to a patch in series.
> >
> > Changes from v1 to v2:
> >  - Directly incorporate Vitaly's dependency patch in the series
> >  - Split out s0ix code into it's own file
> >  - Adjust from DMI matching to PCI subsystem vendor ID/device matching
> >  - Remove module parameter and sysfs, use ethtool flag instead.
> >  - Export s0ix flag to ethtool private flags
> >  - Include more people and lists directly in this submission chain.
> >
> > Mario Limonciello (6):
> >   e1000e: Move all S0ix related code into its own source file
> >   e1000e: Export S0ix flags to ethtool
> >   e1000e: Add Dell's Comet Lake systems into S0ix heuristics
> >   e1000e: Add more Dell CML systems into S0ix heuristics
> >   e1000e: Add Dell TGL desktop systems into S0ix heuristics
> >   e1000e: Add another Dell TGL notebook system into S0ix heuristics
> >
> > Vitaly Lifshits (1):
> >   e1000e: fix S0ix flow to allow S0i3.2 subset entry
> >
> >  drivers/net/ethernet/intel/e1000e/Makefile  |   2 +-
> >  drivers/net/ethernet/intel/e1000e/e1000.h   |   4 +
> >  drivers/net/ethernet/intel/e1000e/ethtool.c |  40 +++
> >  drivers/net/ethernet/intel/e1000e/netdev.c  | 272 +----------------
> >  drivers/net/ethernet/intel/e1000e/s0ix.c    | 311 ++++++++++++++++++++
> >  5 files changed, 361 insertions(+), 268 deletions(-)
> >  create mode 100644 drivers/net/ethernet/intel/e1000e/s0ix.c
> >
> > --
> > 2.25.1
> >
> >

