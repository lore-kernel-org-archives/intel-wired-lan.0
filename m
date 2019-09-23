From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Sep 2019 18:13:39 +0000
Subject: [Intel-wired-lan] [next PATCH S10 09/10] i40e: Fix LED blinking
 flow for X710T*L devices.
In-Reply-To: <20190920091724.51767-9-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
 <20190920091724.51767-9-alice.michael@intel.com>
Message-ID: <819c834d44e4481e8a42eb62bc0c49b2@intel.com>
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
> Cc: Milosek, Damian <damian.milosek@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S10 09/10] i40e: Fix LED blinking flow
> for X710T*L devices.
> 
> From: Damian Milosek <damian.milosek@intel.com>
> 
> Add X710T*L device specific operations (in port LED detection and handling of
> GLGEN_GPIO_CTL.PIN_FUNC field) to enable LED blinking.
> 
> Signed-off-by: Damian Milosek <damian.milosek@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 29
> +++++++++++++++++--  drivers/net/ethernet/intel/i40e/i40e_devids.h |  2
> ++
>  2 files changed, 28 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


