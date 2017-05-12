From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 May 2017 17:57:13 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 03/14] i40e: use new
 unified	virtchnl header file
In-Reply-To: <20170511182321.147850-4-jesse.brandeburg@intel.com>
References: <20170511182321.147850-1-jesse.brandeburg@intel.com>
 <20170511182321.147850-4-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA30FA@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v3 03/14] i40e: use new unified
> virtchnl header file
> 
> This patch changes the i40e driver to start using the new virtchnl interface
> header file, and removes an already existing duplicate of the i40e_virtchnl.h
> file contained in the i40e directory.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
>  delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h           |   2 +-
>  drivers/net/ethernet/intel/i40e/i40e_common.c    |   2 +-
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h |   2 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl.h  | 449 -----------------------
>  4 files changed, 3 insertions(+), 452 deletions(-)  delete mode 100644
> drivers/net/ethernet/intel/i40e/i40e_virtchnl.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


