From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jul 2020 01:25:02 +0000
Subject: [Intel-wired-lan] [PATCH S49 08/15] ice: add link lenient and
 default override support
In-Reply-To: <20200709161614.61098-8-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
 <20200709161614.61098-8-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB214561F95E4B6DBB849B64428C760@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S49 08/15] ice: add link lenient and default
> override support
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Adds functions to check for link override firmware support and get the
> override settings for a port. The previously supported/default link mode was
> strict mode.
> 
> In strict mode link is configured based on get PHY capabilities PHY types with
> media.
> 
> Lenient mode is now the default link mode. In lenient mode the link is
> configured based on get PHY capabilities PHY types without media. This
> allows the user to configure link that the media does not report. Limit the
> minimum supported link mode to 25G for devices that support 100G, and 1G
> for devices that support less than 100G.
> 
> Default override is only supported in lenient mode. If default override is
> supported and enabled, then default override values are used for
> configuring speed and FEC. Default override provide persistent link settings
> in the NVM.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Evan Swanson <evan.swanson@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   3 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   5 +-
>  drivers/net/ethernet/intel/ice/ice_common.c   | 170 +++++-
>  drivers/net/ethernet/intel/ice/ice_common.h   |   8 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 519 +++++++++++-------
>  drivers/net/ethernet/intel/ice/ice_main.c     |  99 +++-
>  drivers/net/ethernet/intel/ice/ice_nvm.c      |   2 +-
>  drivers/net/ethernet/intel/ice/ice_nvm.h      |   3 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |  35 ++
>  9 files changed, 628 insertions(+), 216 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


