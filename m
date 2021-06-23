From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 23 Jun 2021 19:54:03 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix logic of disabling
 queues
In-Reply-To: <20210429174947.10691-1-arkadiusz.kubalewski@intel.com>
References: <20210429174947.10691-1-arkadiusz.kubalewski@intel.com>
Message-ID: <SJ0PR11MB5662A063069637A338BEFCA4FA089@SJ0PR11MB5662.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Arkadiusz Kubalewski
> Sent: Thursday, April 29, 2021 10:50 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH net] i40e: Fix logic of disabling queues
> 
> Correct the message flow between driver and firmware when disabling
> queues.
> 
> Previously in case of PF reset (due to required reinit after reconfig), the error
> like: "VSI seid 397 Tx ring 60 disable timeout" could show up occasionally. The
> error was not a real issue of hardware or firmware, it was caused by wrong
> sequence of messages invoked by the driver.
> 
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 58 ++++++++++++---------
>  1 file changed, 34 insertions(+), 24 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


