From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 11 Aug 2021 05:25:59 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 08/12] ice: introduce new
 type of VSI for switchdev
In-Reply-To: <20210625024501.6126-9-michal.swiatkowski@linux.intel.com>
References: <20210625024501.6126-1-michal.swiatkowski@linux.intel.com>
 <20210625024501.6126-9-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB45542C9526EE932496D77E249CF89@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Michal Swiatkowski
>Sent: Friday, June 25, 2021 8:15 AM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next v3 08/12] ice: introduce new type of
>VSI for switchdev
>
>From: Grzegorz Nitka <grzegorz.nitka@intel.com>
>
>New type of VSI has to be defined for switchdev control plane VSI. Number of
>allocated Tx and Rx queue has to be equeal to amount of VFs, because each
>port representor should have one Tx and Rx queue.
>
>Also to not increase number of used irqs too much, control plane VSI uses
>only one q_vector and handle all queues in one irq.
>To allow handling all queues in one irq , new function to clean msix for
>eswitch was introduced. This function will shedule napi for each representor
>instead of sheduling it only for one like in normal clean irq function.
>
>Only one additional msix has to be requested. Always try to request it in
>ice_ena_msix_range function.
>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice.h         |  1 +
> drivers/net/ethernet/intel/ice/ice_base.c    | 37 ++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_eswitch.c |  2 +-
> drivers/net/ethernet/intel/ice/ice_lib.c     | 48 +++++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_main.c    |  7 +++
> drivers/net/ethernet/intel/ice/ice_type.h    |  1 +
> 6 files changed, 93 insertions(+), 3 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
