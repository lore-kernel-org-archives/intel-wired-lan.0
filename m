From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 24 May 2016 02:31:55 +0000
Subject: [Intel-wired-lan] [PATCH v3 3/5] igb: re-use igb_ptp_reset
	in	igb_ptp_init
In-Reply-To: <20160518210424.20744-3-jacob.e.keller@intel.com>
References: <20160518210424.20744-1-jacob.e.keller@intel.com>
 <20160518210424.20744-3-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EFFFD2@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Wednesday, May 18, 2016 2:04 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v3 3/5] igb: re-use igb_ptp_reset in
> igb_ptp_init
> 
> Modify igb_ptp_init to take advantage of igb_ptp_reset, and remove
> duplicated work that was occurring in both igb_ptp_reset and
> igb_ptp_init.
> 
> In total, resetting the TSAUXC register, and resetting the system time
> both happen in igb_ptp_reset already. igb_ptp_reset now also takes care
> of starting the delayed work item for overflow checks, as well.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 45 ++++++++++++--------------------
>  1 file changed, 16 insertions(+), 29 deletions(-)

This is the same message I sent with 1/5 of this series, just adding it to this message to get the info captured with this patch in patchwork.

This series seemed completely fine for regression, but once I started testing ptp I quickly ran into several bugs.  One showed up with this patch, the other (and more serious one) shows up in patch 3/5.

With just this patch from the series applied an i211 and a dual port 82580 [maybe more I only ran just this patch against those parts] running `ptp4l -m -I ethX` starts getting a number of "clearing Rx timestamp" messages intermixed with the timestamp display.  This is very consistent, one RX timestamp hang  message for every 6 updates to ptp shown.

Patch 3/5 causes more serious problems.  On the i211 the 
- Panic when ptp4l is started on dual port 82580 (Bartonville ~ either port)  Not captured to logs and on system w/o usable serial port ~ but have snapshot of screen.

Having 3/5 igb: re-use igb_ptp_reset in igb_ptp_init, or later on top of queue causes more serious issues:
- The i211 stops getting / displaying timestamp info, rather it displays "received SYNC without timestamp" along with the frequent "clearing RX timestamp hang" messages introduced with 1/5.
- The dual port 82580, however, gets a panic on the screen the moment ptp4l is launched against it.  Seems to be a spinlock causing a Kernel panic - not syncing: Fatal exception in interrupt.  The trace does not get captured to logs and this particular box does not have a working serial port to capture the trace via a serial console.  I do have a bitmap screen shot (I'll forward to Jacob separately) and will try to get and capture the trace on another machine.

With the entire series applied I get the same behavior as with 3/5.  I have run that on a few more machines and it appears the Kernel Panic / freeze also occurs with i350 parts so I should be able to capture the trace on a serial console with one of the i350s tomorrow.
