From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 6 Aug 2021 10:55:24 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 11/12] ice: switchdev slow
 path
In-Reply-To: <20210625024501.6126-12-michal.swiatkowski@linux.intel.com>
References: <20210625024501.6126-1-michal.swiatkowski@linux.intel.com>
 <20210625024501.6126-12-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB455438B88C21F2340A3A7EDB9CF39@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v3 11/12] ice: switchdev slow path
>
>From: Grzegorz Nitka <grzegorz.nitka@intel.com>
>
>Slow path means allowing packet to go from uplink to representor and from
>representor to correct VF on Rx site and from VF to representor and to uplink
>on Tx site.
>
>To acomplish this driver, has to set correct Tx descriptor. When packet is sent
>from representor to VF, destination should be set to VF VSI. When packet is
>sent from uplink port destination should be uplink to bypass switch
>infrastructure and send packet outside.
>
>On Rx site driver should check source VSI field from Rx descriptor and based
>on that forward packed to correct netdev. To allow this there is a target
>netdevs table in control plane VSI struct.
>
>Co-developed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_eswitch.c  | 79 +++++++++++++++++++
>drivers/net/ethernet/intel/ice/ice_eswitch.h  | 26 ++++++
> .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 43 ++++++++++
> drivers/net/ethernet/intel/ice/ice_repr.c     |  1 +
> drivers/net/ethernet/intel/ice/ice_txrx.c     |  3 +
> drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  4 +-
> 6 files changed, 155 insertions(+), 1 deletion(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
