From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Feb 2019 20:17:09 +0000
Subject: [Intel-wired-lan] [next PATCH S2-V2 08/12] i40e: Changed
 maximum supported FW API version to 1.8
In-Reply-To: <20190206230826.24970-8-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
 <20190206230826.24970-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D365FDC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, February 6, 2019 3:08 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Ludkiewicz, Adam <adam.ludkiewicz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S2-V2 08/12] i40e: Changed maximum
> supported FW API version to 1.8
> 
> From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> 
> A new FW has been released, which uses API version 1.8.
> 
> Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 4 ++--
> drivers/net/ethernet/intel/iavf/i40e_adminq_cmd.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


