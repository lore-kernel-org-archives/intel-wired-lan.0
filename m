From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Mon, 5 Apr 2021 22:49:17 +0000
Subject: [Intel-wired-lan] [PATCH S57 09/14] ice: Use default
 configuration mode for PHY configuration
In-Reply-To: <20210325223517.17722-9-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
 <20210325223517.17722-9-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB510578D3766F094762AA4E88FA779@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, March 25, 2021 3:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S57 09/14] ice: Use default configuration
> mode for PHY configuration
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Recent firmware supports a new "get PHY capabilities" mode
> ICE_AQC_REPORT_DFLT_CFG which makes it unnecessary for the driver to
> track and apply NVM based default link overrides.
> 
> If FW AQ API version supports it, use Report Default Configuration.
> Add check function for Report Default Configuration support and update
> accordingly.
> 
> Also change adv_phy_type_[lo|hi] to advert_phy_type[lo|hi] for clarity.
> 
> Co-developed-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 12 ++--
>  drivers/net/ethernet/intel/ice/ice_common.c   | 33 ++++++++++-
>  drivers/net/ethernet/intel/ice/ice_common.h   |  1 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 59 +++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_main.c     | 35 +++++++----
>  drivers/net/ethernet/intel/ice/ice_type.h     |  5 ++
>  6 files changed, 103 insertions(+), 42 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


