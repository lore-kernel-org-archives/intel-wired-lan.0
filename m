From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jul 2020 01:26:55 +0000
Subject: [Intel-wired-lan] [PATCH S49 06/15] ice: move auto FEC checks
 into ice_cfg_phy_fec()
In-Reply-To: <20200709161614.61098-6-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
 <20200709161614.61098-6-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145D2ABC68F595E0059DC9A8C760@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S49 06/15] ice: move auto FEC checks into
> ice_cfg_phy_fec()
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> The call to ice_cfg_phy_fec() requires the caller to perform certain actions
> before calling it. Instead of imposing these preconditions move the
> operations into the function and perform them ourselves.
> 
> Also, fix some style issues in nearby touched code.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c  | 43 ++++++++++++++++----
> drivers/net/ethernet/intel/ice/ice_common.h  |  5 ++-
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 31 ++------------
>  3 files changed, 40 insertions(+), 39 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


