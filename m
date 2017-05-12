From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 May 2017 17:59:50 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 09/14] virtchnl:
	finish	conversion to virtchnl interface
In-Reply-To: <20170511182321.147850-10-jesse.brandeburg@intel.com>
References: <20170511182321.147850-1-jesse.brandeburg@intel.com>
 <20170511182321.147850-10-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA313C@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v3 09/14] virtchnl: finish
> conversion to virtchnl interface
> 
> This patch implements the complete version of the virtchnl.h file with final
> renames, and fixes the related code in i40e and i40evf.
> 
> It also expands comments, and adds details on the usage of certain fields.
> 
> In addition, due to the changes a couple of casts are needed to prevent
> errors found by sparse after renaming some fields.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  18 +--
>  drivers/net/ethernet/intel/i40evf/i40e_common.c    |   2 +-
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |   2 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  11 +-
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |   6 +-
>  include/linux/avf/virtchnl.h                       | 128 +++++++++++++--------
>  6 files changed, 102 insertions(+), 65 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


