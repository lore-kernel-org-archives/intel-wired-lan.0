From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 12 May 2021 15:44:33 +0000
Subject: [Intel-wired-lan] [PATCH net 2/4] ice: report supported and
 advertised autoneg using PHY capabilities
In-Reply-To: <20210505211800.11908-2-anthony.l.nguyen@intel.com>
References: <20210505211800.11908-1-anthony.l.nguyen@intel.com>
 <20210505211800.11908-2-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105174D52E75FD93AD29B8BFA529@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, May 5, 2021 2:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net 2/4] ice: report supported and
> advertised autoneg using PHY capabilities
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Ethtool incorrectly reported supported and advertised auto-negotiation
> settings for a backplane PHY image which did not support auto-negotiation.
> This can occur when using media or PHY type for reporting ethtool supported
> and advertised auto-negotiation settings.
> 
> Remove setting supported and advertised auto-negotiation settings based
> on PHY type in ice_phy_type_to_ethtool(), and MAC type in
> ice_get_link_ksettings().
> 
> Ethtool supported and advertised auto-negotiation settings should be based
> on the PHY image using the AQ command get PHY capabilities with media.
> Add setting supported and advertised auto-negotiation settings based get
> PHY capabilities with media in ice_get_link_ksettings().
> 
> Fixes: 48cb27f2fd18 ("ice: Implement handlers for ethtool PHY/link
> operations")
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 51 +++-----------------
>  1 file changed, 6 insertions(+), 45 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


