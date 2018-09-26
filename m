From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:53:18 +0000
Subject: [Intel-wired-lan] [PATCH 08/16] ice: Change pf state behavior
 to protect reset path
In-Reply-To: <20180920002319.10971-9-anirudh.venkataramanan@intel.com>
References: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
 <20180920002319.10971-9-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC487@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 08/16] ice: Change pf state behavior to
> protect reset path
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Currently, there is no bit, or set of bits, that protect the entirety of the reset
> path.
> 
> If the reset is originated by the driver, then the relevant one of the following
> bits will be set when the reset is scheduled:
> __ICE_PFR_REQ
> __ICE_CORER_REQ
> __ICE_GLOBR_REQ
> This bit will not be cleared until after the rebuild has completed.
> 
> If the reset is originated by the FW, then the first the driver knows of it will
> be the reception of the OICR interrupt.  The __ICE_RESET_OICR_RECV bit will
> be set in the interrupt handler.  This will also be the indicator in a SW
> originated reset that we have completed the pre-OICR tasks and have
> informed the FW that a reset was requested.
> 
> To utilize these bits, change the function:
> ice_is_reset_recovery_pending()
> 	to be:
> ice_is_reset_in_progress()
> 
> The new function will check all of the above bits in the pf->state and will
> return a true if one or more of these bits are set.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 13 +++++----
> drivers/net/ethernet/intel/ice/ice_lib.h  |  2 +-
> drivers/net/ethernet/intel/ice/ice_main.c | 44 +++++++++++++++------------
> ----
>  4 files changed, 31 insertions(+), 30 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


