From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jul 2020 01:25:31 +0000
Subject: [Intel-wired-lan] [PATCH S49 05/15] ice: refactor FC functions
In-Reply-To: <20200709161614.61098-5-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
 <20200709161614.61098-5-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB214597329C28A32A4EA62FB38C760@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, July 9, 2020 9:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S49 05/15] ice: refactor FC functions
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Create a helper function for configuring requested flow control so that it can
> be utilized by other functions looking to configure flow control settings.
> Utilize the existing helper ice_copy_phy_caps_to_cfg() to copy a PHY
> capability to configuration instead duplicating the code for it.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 75 +++++++++++++--------
>  1 file changed, 46 insertions(+), 29 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


