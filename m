From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Feb 2018 19:53:12 +0000
Subject: [Intel-wired-lan] [PATCH V2] i40e: i40e_open() should fail if
 forcing link state returned error
In-Reply-To: <20180202111047.64740-1-alice.michael@intel.com>
References: <20180202111047.64740-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94973B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, February 2, 2018 3:11 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Stachura, Mariusz <mariusz.stachura@intel.com>
> Subject: [Intel-wired-lan] [PATCH V2] i40e: i40e_open() should fail if forcing
> link state returned error
> 
> From: Mariusz Stachura <mariusz.stachura@intel.com>
> 
> Based on upstream review comments, ndo_open function should not
> succeed if there were issues with forcing link state to be UP.
> This patch also fixes an issue with looping through enum values.
> 
> Added I40E_PHY_TYPES_BITMASK define with all phy types OR-ed together
> in one bitmask.  Added after phy type definition, so it will be hard to forget to
> include new phy types to the bitmask.
> 
> Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 37
> +++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c       | 28 +++++++++--------
>  2 files changed, 53 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


