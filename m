From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jul 2020 01:26:01 +0000
Subject: [Intel-wired-lan] [PATCH S49 07/15] ice: restore PHY settings
 on media insertion
In-Reply-To: <20200709161614.61098-7-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
 <20200709161614.61098-7-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145DF114FEB7B0B1B30A9138C760@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S49 07/15] ice: restore PHY settings on
> media insertion
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> After the transition from no media to media FW will clear the set-phy-cfg
> data set by the user. Save initial PHY settings and any settings later requested
> by the user and use that data to restore PHY settings on media insertion.
> Since PHY configuration is now being stored, replace calls that were calling
> FW to get the configuration with the saved copy.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   3 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_common.c   | 145 ++++++++-
>  drivers/net/ethernet/intel/ice/ice_common.h   |  14 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 120 +++----
>  drivers/net/ethernet/intel/ice/ice_main.c     | 308 ++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_type.h     |  21 ++
>  7 files changed, 517 insertions(+), 95 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


