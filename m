From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 31 Mar 2021 21:01:24 +0000
Subject: [Intel-wired-lan] [PATCH S57 05/14] ice: Remove unnecessary
 checker loop
In-Reply-To: <20210325223517.17722-5-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
 <20210325223517.17722-5-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105CB15A837D91737FD8F00FA7C9@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S57 05/14] ice: Remove unnecessary
> checker loop
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> The loop checking for PF VSI doesn't make any sense. The VSI type backing
> the netdev passed to ice_set_link_ksettings will always be of type
> ICE_PF_VSI. Remove it.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


