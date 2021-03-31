From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 31 Mar 2021 21:50:11 +0000
Subject: [Intel-wired-lan] [PATCH S57 12/14] ice: Use local variable
 instead of pointer derefs
In-Reply-To: <20210325223517.17722-12-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
 <20210325223517.17722-12-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB510562C296CF5ECD61618B7FFA7C9@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S57 12/14] ice: Use local variable instead of
> pointer derefs
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Replace multiple instances of vsi->back and pi->phy with equivalent local
> variables
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 32 ++++++++++-------------
>  1 file changed, 14 insertions(+), 18 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


