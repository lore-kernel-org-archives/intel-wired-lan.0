From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 4 May 2017 23:29:05 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: fix handling of HW ATR eviction
In-Reply-To: <1493934784.48207.0.camel@intel.com>
References: <20170504211636.21192-1-jacob.e.keller@intel.com>
 <1493934784.48207.0.camel@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857E20FB4@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Kirsher, Jeffrey T
> Sent: Thursday, May 04, 2017 2:53 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; Intel Wired LAN <intel-wired-
> lan at lists.osuosl.org>
> Cc: Duyck, Alexander H <alexander.h.duyck@intel.com>; Singhai, Anjali
> <anjali.singhai@intel.com>
> Subject: Re: [PATCH] i40e: fix handling of HW ATR eviction
> 
> On Thu, 2017-05-04 at 14:16 -0700, Jacob Keller wrote:
> > A recent commit to refactor the driver and remove the
> > hw_disabled_flags
> > field accidentally introduced two regressions. First, we overwrote
> > pf->flags which removed various key flags including the MSI-X
> > settings.
> >
> > Additionally, it was intended that we have now two flags,
> > HW_ATR_EVICT_CAPABLe and HW_ATR_EVICT_ENABLED, but this was not
> done,
> > and we accidentally were mis-using HW_ATR_EVICT_CAPABLE everywhere.
> >
> > This patch adds the missing piece, HW_ATR_EVICT_ENABLED, and safely
> > updates pf->flags instead of overwriting it.
> >
> > Without this patch we will have many problems including disabling
> > MSI-X
> > support, and we'll attempt to use HW ATR eviction on devices which do
> > not support it.
> >
> > Fixes: 47994c119a36 ("i40e: remove hw_disabled_flags in favor of
> > using separate flag bits", 2017-04-19)
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> > Ok. For real, this actually cleans up and adds the missing feature
> > that
> > we should have had. I'm working on the rest, but this should fix the
> > issue you were seeing without introducing other regressions.
> >
> > ?drivers/net/ethernet/intel/i40e/i40e.h???????? | 1 +
> > ?drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ++--
> > ?drivers/net/ethernet/intel/i40e/i40e_main.c??? | 7 ++++---
> > ?drivers/net/ethernet/intel/i40e/i40e_txrx.c??? | 4 ++--
> > ?4 files changed, 9 insertions(+), 7 deletions(-)
> 
>  Ok is this the "final" version of the fix???

Yes thanks.

Regards,
Jake
