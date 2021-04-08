From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 8 Apr 2021 21:41:20 +0000
Subject: [Intel-wired-lan] [PATCH S58 08/13] ice: remove unused struct
 member
In-Reply-To: <20210331211708.55205-8-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
 <20210331211708.55205-8-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51056FE63B606BE52A507CE8FA749@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, March 31, 2021 2:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S58 08/13] ice: remove unused struct
> member
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The only time you can ever have a rq_last_status is if a firmware event was
> somehow reporting a status on the receive queue, which are generally
> firmware initiated events or mailbox messages from a VF.  Mostly this struct
> member was unused.
> 
> Fix this problem by still printing the value of the field in a debug print, but
> don't store the value forever in a struct, potentially creating opportunities for
> callers to use the wrong struct member.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 6 +++---
> drivers/net/ethernet/intel/ice/ice_controlq.h | 1 -
>  2 files changed, 3 insertions(+), 4 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


