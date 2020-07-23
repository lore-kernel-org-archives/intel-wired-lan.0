From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jul 2020 01:23:11 +0000
Subject: [Intel-wired-lan] [PATCH S49 12/15] ice: Rename low_power_ctrl
In-Reply-To: <20200709161614.61098-12-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
 <20200709161614.61098-12-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21450EA963EAB152481BEC008C760@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S49 12/15] ice: Rename low_power_ctrl
> 
> From: Lev Faerman <lev.faerman@intel.com>
> 
> Rename the low_power_ctrl field to low_power_ctrl_an to be properly
> descriptive of it being an autonegotiation field.
> 
> Signed-off-by: Lev Faerman <lev.faerman@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h    |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_common.c    | 18 +++++++++---------
>  2 files changed, 11 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


