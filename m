From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 10 Mar 2021 23:06:34 +0000
Subject: [Intel-wired-lan] [PATCH net 11/13] ice: Use port number
 instead of PF ID for WoL
In-Reply-To: <20210226211932.46683-11-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
 <20210226211932.46683-11-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105E7E9DEDB3C9641731B10FA919@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, February 26, 2021 1:20 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net 11/13] ice: Use port number instead of
> PF ID for WoL
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> As per the spec, the WoL control word read from the NVM should be
> interpreted as port numbers, and not PF numbers. So when checking if WoL
> supported, use the port number instead of the PF ID.
> 
> Also, ice_is_wol_supported doesn't really need a pointer to the pf struct, but
> just needs a pointer to the hw instance.
> 
> Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         | 2 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_main.c    | 9 ++++-----
>  3 files changed, 7 insertions(+), 8 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


