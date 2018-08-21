From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:30:24 +0000
Subject: [Intel-wired-lan] [PATCH v4 09/13] ice: Update to interrupts
 enabled in OICR
In-Reply-To: <20180809132903.22819-10-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
 <20180809132903.22819-10-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545A4C@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4 09/13] ice: Update to interrupts enabled
> in OICR
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Remove the following interrupt causes that are not applicable or not
> handled:
> - PFINT_OICR_HLP_RDY_M
> - PFINT_OICR_CPM_RDY_M
> - PFINT_OICR_GPIO_M
> - PFINT_OICR_STORM_DETECT_M
> 
> Add the following interrupt cause that's actually handled in ice_misc_intr:
> - PFINT_OICR_PE_CRITERR_M
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> Removed
> defines from ice_hw_autogen.h]
> ---
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h | 8 --------
>  drivers/net/ethernet/intel/ice/ice_main.c       | 9 +++------
>  2 files changed, 3 insertions(+), 14 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


