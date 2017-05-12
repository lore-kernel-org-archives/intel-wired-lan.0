From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 May 2017 18:05:48 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 07/14] i40e/virtchnl:
 refactor	code for validate checks
In-Reply-To: <20170511182321.147850-8-jesse.brandeburg@intel.com>
References: <20170511182321.147850-1-jesse.brandeburg@intel.com>
 <20170511182321.147850-8-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA32DD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Thursday, May 11, 2017 11:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 07/14] i40e/virtchnl: refactor
> code for validate checks
> 
> This change updates the arguments passed to the validate function and fixes
> the caller, as well as uses the new return values added to virtchnl.h
> 
> One other minor tweak, remove a duplicate set to zero of valid_len.
> 
> This is in preparation for moving the function to virtchnl.h.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 36 ++++++++++++------
> ----
>  include/linux/avf/virtchnl.h                       | 17 ++++++++++
>  2 files changed, 37 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


