From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jul 2019 22:59:54 +0000
Subject: [Intel-wired-lan] [PATCH S22 15/16] ice: Remove flag to track
 VF interrupt status
In-Reply-To: <20190626092027.52845-15-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
 <20190626092027.52845-15-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FBE93@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, June 26, 2019 2:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Abodunrin, Akeem G <akeem.g.abodunrin@intel.com>
> Subject: [Intel-wired-lan] [PATCH S22 15/16] ice: Remove flag to track VF
> interrupt status
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> As a result of refactoring of VF VSIs interrupts code, there is no need to track
> its configuration status again with ICE_VF_STATE_CFG_INTR flag - In fact, it is
> not being checked anywhere in the code right now, so this patch removes
> the dead code as applicable to the flag.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 11 -----------
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  5 -----
>  2 files changed, 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


