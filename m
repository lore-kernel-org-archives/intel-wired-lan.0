From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 23 Jun 2021 20:09:42 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Add additional info to
 PHY type error
In-Reply-To: <1622480149-29979-1-git-send-email-michal.maloszewski@intel.com>
References: <1622480149-29979-1-git-send-email-michal.maloszewski@intel.com>
Message-ID: <SJ0PR11MB5662898763692D9F4F2D04AFFA089@SJ0PR11MB5662.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Maloszewski
> Sent: Monday, May 31, 2021 9:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Maloszewski, Michal <michal.maloszewski@intel.com>; Cieplicki, LukaszX
> <lukaszx.cieplicki@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] i40e: Add additional info to PHY
> type error
> 
> From: Lukasz Cieplicki <lukaszx.cieplicki@intel.com>
> 
> In case of PHY type error occurs, the message was too generic.
> Add additional info to PHY type error indicating that it can be wrong cable
> connected.
> 
> Fixes: 124ed15bf126 ("i40e: Add dual speed module support")
> Signed-off-by: Lukasz Cieplicki <lukaszx.cieplicki@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


