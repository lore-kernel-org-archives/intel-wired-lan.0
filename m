From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 10 Mar 2021 21:14:56 +0000
Subject: [Intel-wired-lan] [PATCH net 03/13] ice: Continue probe on
 link/PHY errors
In-Reply-To: <20210226211932.46683-3-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
 <20210226211932.46683-3-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51055510D3325C89C16DB262FA919@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, February 26, 2021 1:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net 03/13] ice: Continue probe on link/PHY
> errors
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> An incorrect NVM update procedure can result in the driver failing probe.
> In this case, the recommended resolution method is to update the NVM
> using the right procedure. However, if the driver fails probe, the user will not
> be able to update the NVM. So do not fail probe on link/PHY errors.
> 
> Fixes: 1a3571b5938c ("ice: restore PHY settings on media insertion")
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


