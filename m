From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 12 Mar 2021 00:40:51 +0000
Subject: [Intel-wired-lan] [PATCH S56 01/13] ice: Change
 ice_vsi_setup_q_map() to not depend on RSS
In-Reply-To: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51052C4802C77B106E357141FA6F9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Tuesday, March 2, 2021 10:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S56 01/13] ice: Change
> ice_vsi_setup_q_map() to not depend on RSS
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently, ice_vsi_setup_q_map() depends on the VSI's rss_size. However,
> the Rx Queue Mapping section of the VSI context has no dependency on
> RSS.
> Instead, limit the maximum number of Rx queues per TC based on the Rx
> Queue mapping section of the VSI context, which currently allows for up to
> 256 Rx queues per TC.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h     |  1 +
>  drivers/net/ethernet/intel/ice/ice_lib.c | 50 ++++++++----------------
>  2 files changed, 17 insertions(+), 34 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


