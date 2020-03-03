From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:04:41 +0000
Subject: [Intel-wired-lan] [PATCH S40 03/15] ice: Improve clarity of
 prints and variables
In-Reply-To: <20200227181505.61720-3-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
 <20200227181505.61720-3-anthony.l.nguyen@intel.com>
Message-ID: <7d26b3310bb947ce8b805306e3c7038a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 27, 2020 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S40 03/15] ice: Improve clarity of prints and
> variables
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when the device runs out of MSI-X interrupts a cryptic and
> unhelpful message is printed. This will cause confusion when hitting this case.
> Fix this by clearing up the error message for both SR-IOV and non SR-IOV use
> cases.
> 
> Also, make a few minor changes to increase clarity of variables.
> 1. Change per VF MSI-X and queue pair variables in the PF structure.
> 2. Use ICE_NONQ_VECS_VF when determining pf->num_msix_per_vf
> instead of the magic number "1". This vector is reserved for the OICR.
> 
> All of the resource tracking functions were moved to avoid adding any
> forward declaration function prototypes.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   4 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 200 ++++++++++--------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  66 +++---
>  3 files changed, 145 insertions(+), 125 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


