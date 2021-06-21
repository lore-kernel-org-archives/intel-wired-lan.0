From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Mon, 21 Jun 2021 22:05:29 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/2] ice: remove unnecessary
 VSI assignment
In-Reply-To: <20210614214607.41749-2-anthony.l.nguyen@intel.com>
References: <20210614214607.41749-1-anthony.l.nguyen@intel.com>
 <20210614214607.41749-2-anthony.l.nguyen@intel.com>
Message-ID: <SJ0PR11MB5662A7E1C187B2773ECE341DFA0A9@SJ0PR11MB5662.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, June 14, 2021 2:46 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 2/2] ice: remove unnecessary VSI
> assignment
> 
> ice_get_vf_vsi() is being called twice for the same VSI. Remove the
> unnecessary call/assignment.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


