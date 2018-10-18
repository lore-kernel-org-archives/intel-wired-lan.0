From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Oct 2018 21:45:14 +0000
Subject: [Intel-wired-lan] [PATCH 6/7] ice: Allocate VF interrupts and
 set queue map
In-Reply-To: <20181018153709.32664-7-anirudh.venkataramanan@intel.com>
References: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
 <20181018153709.32664-7-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D30F751@FMSMSX152.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, October 18, 2018 8:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 6/7] ice: Allocate VF interrupts and set
> queue map
> 
> Allocate VF interrupts using VPINT_ALLOC_PCI. Multiple interrupts are
> specified as a range from "first" to "last".
> 
> Also, according to the spec, the queue mapping for a VF needs to be set in
> both contig and scatter queue modes. So make this change as well.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h  |  6 ++++++
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 15 +++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


