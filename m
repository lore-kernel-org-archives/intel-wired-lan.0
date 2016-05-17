From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 16 May 2016 19:29:02 -0700
Subject: [Intel-wired-lan] [net v2 0/5] igb: fix ptp suspend/resume issue
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81EFDD0D@ORSMSX101.amr.corp.intel.com>
References: <20160511231824.22542-1-jacob.e.keller@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81EFDD0D@ORSMSX101.amr.corp.intel.com>
Message-ID: <1463452142.2649.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-05-17 at 01:57 +0000, Brown, Aaron F wrote:
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org]
> On
> > Behalf Of Jacob Keller
> > Sent: Wednesday, May 11, 2016 4:18 PM
> > To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> > Cc: Vidya Sagar <sagar.tv@gmail.com>
> > Subject: [Intel-wired-lan] [net v2 0/5] igb: fix ptp suspend/resume
> issue
> >?
> > This patch series (properly) fixes the issue with igb's workqueue item
> > for overflow check from causing a surprise remove event. To do this,
> > properly suspend the workqueue items in suspend and then resume them
> > again during the resume flow.
> >?
> > The patch series has a few extra steps to reduce code duplication and
> > implement suspend and resume properly, which makes the overall fix a
> bit
> > more complicated, and thus review is welcome.
> >?
> > A smaller fix would be to implement suspend and resume irrespective of
> > the current igb_ptp_stop and igb_ptp_init but this seems more likely to
> > introduce bugs especially if either function ever changes in the
> future.
> >?
> > In addition, the ptp_flags variable is added mostly to simplify the
> work
> > of writing several complex MAC type checks in the ptp code while doing
> > this.
> >?
> > Jacob Keller (5):
> >?? igb: introduce ptp_flags variable and use it to replace IGB_FLAG_PTP
> >?? igb: introduce IGB_PTP_OVERFLOW_CHECK flag
> >?? igb: introduce igb_ptp_resume function
> >?? igb: implement igb_ptp_suspend
> >?? igb: call igb_ptp_suspend/igb_ptp_resume during suspend/resume cycle
> >?
> >? drivers/net/ethernet/intel/igb/igb.h????? |?? 8 ++-
> >? drivers/net/ethernet/intel/igb/igb_main.c |?? 4 +-
> >? drivers/net/ethernet/intel/igb/igb_ptp.c? | 110 ++++++++++++++++----
> ---------
> > -
> >? 3 files changed, 68 insertions(+), 54 deletions(-)
> 
> I have not isolated it to the exact patch yet, but one of the patches in
> this series is causing my systems to lock up with a call trace.? I am
> currently unable to capture the trace in any form other than a bitmap
> (which I'll send to Jacob but am not attaching here.)? The trace is
> really several splats a few minutes apart.? The exact text / procedure
> calls of the first one seems to vary, but it seems to be in a wakeup
> routing with "do_page_fault", "? _raw_spin_lock_irq", "?
> timecounter_read", "? _raw_spin_lock_irqsave", "igb_ptp_gettime_82576"
> and "igb_ptp_overflow_check" showing up prominently in at least a few
> instances.? Usually it moves to the next trace before I can get a
> snapshot.? The follow on trace is where it usually stops with a RIP:,
> bunch of hex, stack info and a Call Trace saying "arch_cpu_idle",
> "default_idle_call", "cpu_startup_entry" and "start_secondary" called
> out.

Andrew thought it was with patch 3 in the series, at least that is what his
initial git bisect was telling him.

I am going to go ahead and drop the entire series for now, so that we can
work offline to resolve the issue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160516/17129f83/attachment.asc>
