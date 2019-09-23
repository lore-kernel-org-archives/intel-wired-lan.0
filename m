From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Sep 2019 18:10:55 +0000
Subject: [Intel-wired-lan] [next PATCH S10 04/10] i40e: Extract
 detection of HW flags into a function
In-Reply-To: <20190920091724.51767-4-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
 <20190920091724.51767-4-alice.michael@intel.com>
Message-ID: <f6b1a5f50d8d41279ac110146041a8f5@intel.com>
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
> Cc: Azarewicz, Piotr <piotr.azarewicz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S10 04/10] i40e: Extract detection of
> HW flags into a function
> 
> From: Piotr Azarewicz <piotr.azarewicz@intel.com>
> 
> Move code detecting HW flags based on device type and FW API version into
> a single function.
> 
> Signed-off-by: Piotr Azarewicz <piotr.azarewicz@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 71 +++++++++++++++----
> drivers/net/ethernet/intel/i40e/i40e_common.c |  4 --
>  2 files changed, 58 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


