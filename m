From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 31 Mar 2021 21:39:46 +0000
Subject: [Intel-wired-lan] [PATCH S57 08/14] ice: Replace some memsets
 and memcpys with assignment
In-Reply-To: <20210325223517.17722-8-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
 <20210325223517.17722-8-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105AEDCB5E9C7BBCAC0F048FA7C9@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S57 08/14] ice: Replace some memsets and
> memcpys with assignment
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> In ice_set_link_ksettings, use assignment instead of memset/memcpy
> where possible
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


