From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Sep 2019 18:08:15 +0000
Subject: [Intel-wired-lan] [next PATCH S10 01/10] i40e: Fix for
 persistent lldp support
In-Reply-To: <20190920091724.51767-1-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
Message-ID: <6ef49388ff0b454eb244b9c44dca70ab@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, September 20, 2019 2:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Wnuczko, Sylwia <sylwia.wnuczko@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S10 01/10] i40e: Fix for persistent lldp
> support
> 
> From: Sylwia Wnuczko <sylwia.wnuczko@intel.com>
> 
> This patch fixes function to read nvm module data and uses it to read current
> lldp agent configuration from nvm api version 1.8.
> 
> Signed-off-by: Sylwia Wnuczko <sylwia.wnuczko@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_dcb.h    |  3 +
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 61 ++++++++++---------
>  .../net/ethernet/intel/i40e/i40e_prototype.h  | 10 +--
>  4 files changed, 44 insertions(+), 34 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


