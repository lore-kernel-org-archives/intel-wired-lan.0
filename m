From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 23 Oct 2018 23:17:36 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Update status codes
In-Reply-To: <20181019211103.13873-1-alice.michael@intel.com>
References: <20181019211103.13873-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D310FC8@FMSMSX152.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, October 19, 2018 2:11 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Update status codes
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Add a few new status code which will be used by the ice driver, and rename
> a few to make them more consistent. Error code are mapped to similar
> values as in i40e_status.h, so as to be compatible with older VF drivers not
> using this status enum.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  2 +-
>  include/linux/avf/virtchnl.h                       | 12 +++++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


