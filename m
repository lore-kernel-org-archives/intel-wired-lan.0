From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 7 Apr 2021 23:14:02 +0000
Subject: [Intel-wired-lan] [PATCH S57 07/14] ice: Fix error return codes
 in ice_set_link_ksettings
In-Reply-To: <20210325223517.17722-7-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
 <20210325223517.17722-7-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51051794C3F9282D593E1518FA759@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S57 07/14] ice: Fix error return codes in
> ice_set_link_ksettings
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Return more appropriate error codes so that the right error message is
> communicated to the user by ethtool.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


