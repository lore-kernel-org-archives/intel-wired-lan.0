From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jul 2020 01:23:43 +0000
Subject: [Intel-wired-lan] [PATCH S49 11/15] ice: update reporting of
 autoneg capabilities
In-Reply-To: <20200709161614.61098-11-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
 <20200709161614.61098-11-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB214579B869831477EFF32E308C760@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S49 11/15] ice: update reporting of autoneg
> capabilities
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Firmware now reports AN28, AN32, and AN73. Add a helper and check these
> new values and report PHY autoneg capability.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  3 +++
>  drivers/net/ethernet/intel/ice/ice_common.c     | 15 +++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h     |  1 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c    |  8 ++++----
>  drivers/net/ethernet/intel/ice/ice_main.c       |  8 ++++++--
>  5 files changed, 29 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


