From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 24 May 2016 20:50:49 +0000
Subject: [Intel-wired-lan] [PATCH v3 1/5] igb: introduce ptp_flags
 variable	and use it to replace IGB_FLAG_PTP
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81EFFFBC@ORSMSX101.amr.corp.intel.com>
References: <20160518210424.20744-1-jacob.e.keller@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81EFFFBC@ORSMSX101.amr.corp.intel.com>
Message-ID: <1464123049.5045.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-05-24 at 02:30 +0000, Brown, Aaron F wrote:
> > 
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.
> > org] On
> > Behalf Of Jacob Keller
> > Sent: Wednesday, May 18, 2016 2:04 PM
> > To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> > Subject: [Intel-wired-lan] [PATCH v3 1/5] igb: introduce ptp_flags
> > variable
> > and use it to replace IGB_FLAG_PTP
> > 
> > Upcoming patches will introduce new PTP specific flags. To avoid
> > cluttering the normal flags variable, introduce PTP specific
> > "ptp_flags"
> > variable for this purpose, and move IGB_FLAG_PTP to become
> > IGB_PTP_ENABLED.
> > 
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> > ?drivers/net/ethernet/intel/igb/igb.h?????| 5 ++++-
> > ?drivers/net/ethernet/intel/igb/igb_ptp.c | 8 ++++----
> > ?2 files changed, 8 insertions(+), 5 deletions(-)
> This series seemed completely fine for regression, but once I started
> testing ptp I quickly ran into several bugs.??One showed up with this
> patch, the other (and more serious one) shows up in patch 3/5.
> 
> With just this patch from the series applied an i211 and a dual port
> 82580 [maybe more I only ran just this patch against those parts]
> running `ptp4l -m -I ethX` starts getting a number of "clearing Rx
> timestamp" messages intermixed with the timestamp display.??This is
> very consistent, one RX timestamp hang??message for every 6 updates
> to ptp shown.
> 
> Patch 3/5 causes more serious problems.??On the i211 the?
> - Panic when ptp4l is started on dual port 82580 (Bartonville ~
> either port)??Not captured to logs and on system w/o usable serial
> port ~ but have snapshot of screen.
> 
> Having 3/5 igb: re-use igb_ptp_reset in igb_ptp_init, or later on top
> of queue causes more serious issues:
> - The i211 stops getting / displaying timestamp info, rather it
> displays "received SYNC without timestamp" along with the frequent
> "clearing RX timestamp hang" messages introduced with 1/5.
> - The dual port 82580, however, gets a panic on the screen the moment
> ptp4l is launched against it.??Seems to be a spinlock causing a
> Kernel panic - not syncing: Fatal exception in interrupt.??The trace
> does not get captured to logs and this particular box does not have a
> working serial port to capture the trace via a serial console.??I do
> have a bitmap screen shot (I'll forward to Jacob separately) and will
> try to get and capture the trace on another machine.
> 
> With the entire series applied I get the same behavior as with
> 3/5.??I have run that on a few more machines and it appears the
> Kernel Panic / freeze also occurs with i350 parts so I should be able
> to capture the trace on a serial console with one of the i350s
> tomorrow.

I'll send a v4 shortly, I think I have it resolved.

Thanks,
Jake
