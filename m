From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Aug 2017 16:29:46 +0000
Subject: [Intel-wired-lan] [next PATCH S78-V8 03/12] i40e: use admin
 queue	for setting LEDs behavior
In-Reply-To: <20170822105754.29486-4-alice.michael@intel.com>
References: <20170822105754.29486-1-alice.michael@intel.com>
 <20170822105754.29486-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E9F293@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 22, 2017 3:58 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Stachura, Mariusz <mariusz.stachura@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S78-V8 03/12] i40e: use admin queue
> for setting LEDs behavior
> 
> From: Mariusz Stachura <mariusz.stachura@intel.com>
> 
> Instead of accessing register directly, use newly added AQC in order to blink
> LEDs. Introduce and utilize a new flag to prevent excessive API version
> checking.
> 
> Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c |   6 ++
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 115
> ++++++++++++++++++++------
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |   1 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h |   2 +
>  4 files changed, 100 insertions(+), 24 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


