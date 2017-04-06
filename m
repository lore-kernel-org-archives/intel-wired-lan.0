From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Apr 2017 21:37:19 +0000
Subject: [Intel-wired-lan] [next S66 v2 02/11] i40e: Swap use of
 pf->flags	and pf->hw_disabled_flags for ATR Eviction
In-Reply-To: <20170405115103.67374-2-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
 <20170405115103.67374-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B12B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 5, 2017 4:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S66 v2 02/11] i40e: Swap use of pf->flags and
> pf->hw_disabled_flags for ATR Eviction
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This is a minor cleanup so that we are always updating pf->flags when we
> make a change to the private flags instead of updating a mix of either
> pf->flags and/or pf->hw_disabled_flags.
> 
> In addition I went through and cleaned out all the spots where we were
> using the X722 define in regards to this flag.
> 
> Lastly since we changed the logic I went through and flushed out any
> redundancy and cleaned up the handling of the flags in the Tx path.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I79ff95a7272bb2533251ff11ef91e89ccb80b610
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


