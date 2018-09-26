From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 17:01:21 +0000
Subject: [Intel-wired-lan] [PATCH 15/16] ice: Align ice_reset_req enum
 values to hardware reset values
In-Reply-To: <20180920002319.10971-16-anirudh.venkataramanan@intel.com>
References: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
 <20180920002319.10971-16-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC55A@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 15/16] ice: Align ice_reset_req enum
> values to hardware reset values
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the ice_reset_req enum values have to be translated into a
> different set of values that the hardware understands for the same reset
> types. Avoid this translation by aligning ice_reset_req enum values to the
> ones that the hardware understands.
> 
> Also add and else if block to check for ICE_RESET_EMPR and put a dev_dbg
> message in the else case.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote
> commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c |  5 ++++-
> drivers/net/ethernet/intel/ice/ice_type.h | 14 ++++++++++----
>  2 files changed, 14 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


