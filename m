From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 31 Mar 2021 21:52:18 +0000
Subject: [Intel-wired-lan] [PATCH S57 13/14] ice: Remove rx_gro_dropped
 stat
In-Reply-To: <20210325223517.17722-13-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
 <20210325223517.17722-13-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51053963B95C6FED4FC72BE1FA7C9@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S57 13/14] ice: Remove rx_gro_dropped
> stat
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Tracking of the rx_gro_dropped statistic was removed in commit
> f73fc40327c0 ("ice: drop dead code in ice_receive_skb()").
> Remove the associated variables and its reporting to ethtool stats.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         | 1 -
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 -
>  drivers/net/ethernet/intel/ice/ice_main.c    | 4 +---
>  drivers/net/ethernet/intel/ice/ice_txrx.h    | 1 -
>  4 files changed, 1 insertion(+), 6 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


