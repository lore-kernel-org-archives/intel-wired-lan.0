From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 25 May 2016 20:08:55 +0000
Subject: [Intel-wired-lan] [PATCH v4 1/5] igb: introduce ptp_flags
 variable	and use it to replace IGB_FLAG_PTP
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81F005BD@ORSMSX101.amr.corp.intel.com>
References: <20160524205631.21225-1-jacob.e.keller@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81F005BD@ORSMSX101.amr.corp.intel.com>
Message-ID: <1464206935.31989.5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-05-24 at 23:37 +0000, Brown, Aaron F wrote:
> > 
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.
> > org] On
> > Behalf Of Jacob Keller
> > Sent: Tuesday, May 24, 2016 1:56 PM
> > To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> > Subject: [Intel-wired-lan] [PATCH v4 1/5] igb: introduce ptp_flags
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
> > ?drivers/net/ethernet/intel/igb/igb_ptp.c | 7 ++++---
> > ?2 files changed, 8 insertions(+), 4 deletions(-)
> > 
> On a quick check this (v3) series resolves both the issues I
> described earlier.??All the systems I saw problem on are now happily
> bouncing ptp4l packets across the wire for more than a minute or
> two.??Given it would blow up almost immediately before those issues
> seem to be gone.??Now to put it through the rest of its paces ;)

Thanks.

Regards,
Jake
