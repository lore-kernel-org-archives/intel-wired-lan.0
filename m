From: Switzer, David <david.switzer@intel.com>
Date: Thu, 22 Apr 2021 22:08:15 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 05/11] igb: handle vlan
 types with checker enabled
In-Reply-To: <20210326003834.3886241-6-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
 <20210326003834.3886241-6-jesse.brandeburg@intel.com>
Message-ID: <MW3PR11MB4748E8C37C137EE217633DF4EB469@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jesse
>Brandeburg
>Sent: Thursday, March 25, 2021 5:38 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next v2 05/11] igb: handle vlan types with
>checker enabled
>
>The sparse build (C=2) finds some issues with how the driver dealt with the (very
>difficult) hardware that in some generations uses little-endian, and in others uses
>big endian, for the VLAN field. The code as written picks __le16 as a type and for
>some hardware revisions we override it to __be16 as done in this patch. This
>impacted the VF driver as well so fix it there too.
>
>Also change the vlan_tci assignment to override the sparse warning without
>changing functionality.
>
>Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>---
>Warning Detail:
>.../igb/igb_main.c:2644:48: warning: incorrect type in assignment (different base
>types)
>.../igb/igb_main.c:2644:48:    expected restricted __be16 [usertype] vlan_tci
>.../igb/igb_main.c:2644:48:    got unsigned short [usertype] vlan_priority:3
>.../igb/igb_main.c:8608:31: warning: cast to restricted __be16
>.../igb/igb_main.c:8608:31: warning: cast from restricted __le16
>.../igb/igb_main.c:8608:31: warning: cast to restricted __be16
>.../igb/igb_main.c:8608:31: warning: cast from restricted __le16
>.../igb/igb_main.c:8608:31: warning: cast to restricted __be16
>.../igb/igb_main.c:8608:31: warning: cast from restricted __le16
>.../igb/igb_main.c:8608:31: warning: cast to restricted __be16
>.../igb/igb_main.c:8608:31: warning: cast from restricted __le16
>.../igbvf/netdev.c:93:31: warning: cast to restricted __be16
>.../igbvf/netdev.c:93:31: warning: cast to restricted __be16
>.../igbvf/netdev.c:93:31: warning: cast to restricted __be16
>.../igbvf/netdev.c:93:31: warning: cast to restricted __be16
>.../igbvf/netdev.c:95:31: warning: cast to restricted __le16
>---
> drivers/net/ethernet/intel/igb/igb_main.c | 5 +++--
>drivers/net/ethernet/intel/igbvf/netdev.c | 4 ++--
> 2 files changed, 5 insertions(+), 4 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>
