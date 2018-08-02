From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 Aug 2018 18:34:07 +0000
Subject: [Intel-wired-lan] [next PATCH S93 10/11] i40e: Add AQ command
 for rearrange NVM structure
In-Reply-To: <20180731104148.11896-10-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
 <20180731104148.11896-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2DB3A3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 31, 2018 3:42 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Azarewicz, Piotr <piotr.azarewicz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S93 10/11] i40e: Add AQ command for
> rearrange NVM structure
> 
> From: Piotr Azarewicz <piotr.azarewicz@intel.com>
> 
> During switching between old NVM structure approach (called structured
> NVM) to new one (called flat NVM) or backward flash needs to be
> rearranged to required NVM structure. This is a part of transition from one
> NVM structure to another. The function is introduced to command firmware
> to start rearrangement process.
> 
> Signed-off-by: Piotr Azarewicz <piotr.azarewicz@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 35
> ++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  3 ++
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  2 ++
>  4 files changed, 42 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


