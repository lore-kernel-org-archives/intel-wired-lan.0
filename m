From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 2 Mar 2016 22:55:16 +0000
Subject: [Intel-wired-lan] [PATCH v3] fm10k: cleanup fm10k stats and
 remove debug-statistics
In-Reply-To: <1456958894.2822.17.camel@intel.com>
References: <1456951531-15783-1-git-send-email-jacob.e.keller@intel.com>
 <1456958894.2822.17.camel@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB58579E7F52@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Kirsher, Jeffrey T
> Sent: Wednesday, March 02, 2016 2:48 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; Intel Wired LAN <intel-
> wired-lan at lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [PATCH v3] fm10k: cleanup fm10k stats and
> remove debug-statistics
> 
> On Wed, 2016-03-02 at 12:45 -0800, Jacob Keller wrote:
> > This change fixes up subtle issues with the current fm10k ethtool
> > stats.
> > Primarily, support of debug-statistics and per-queue length
> > statistics
> > is not something the current API can handle. Due to the way that
> > ethtool
> > works, the number of statistics needs to be static for the life time
> > of
> > a given device. Our use of debug-statistics does not really allow for
> > this, so this patch drops its use.
> >
> > Finish this cleanup by reworking the per-queue stats to use the new
> > helper functions which reduce the duplicate and error prone code.
> >
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> >
> > Notes:
> > ??? - v3
> > ??? * based on comments upstream, make queues static
> > ??? * remove debug-statistics support since this can break the
> > ethtool API
> >
> > ??? - v4
> > ??? * remove extra debug stats strings forgotten in previous rework
> >
> > This is based on the fact that the ethtool API cannot really support
> > variable statistics lengths.
> >
> > ?drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 127 ++++++-------
> > ----------
> > ?1 file changed, 33 insertions(+), 94 deletions(-)
> 
> So is this really v4? ?So much fun when I see multiple patches with the
> same version number. :-(

Ooops yes. I forgot to update the send-email command when I resent.. Sorry! :(

Regards,
Jake
