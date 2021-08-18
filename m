From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 18 Aug 2021 03:39:21 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 07/12] ice: set and
 release switchdev environment
In-Reply-To: <20210625024501.6126-8-michal.swiatkowski@linux.intel.com>
References: <20210625024501.6126-1-michal.swiatkowski@linux.intel.com>
 <20210625024501.6126-8-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB4554E8E9088ED79AB76B13579CFF9@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v3 07/12] ice: set and release
>switchdev environment
>
>From: Grzegorz Nitka <grzegorz.nitka@intel.com>
>
>Switchdev environment has to be set up when user create VFs and eswitch
>mode is switchdev. Release is done when user delete all VFs.
>
>Data path in this implementation is based on control plane VSI.
>This VSI is used to pass traffic from port representors to coresponfing VFs and
>vice versa. Default TX rule has to be added to forward packet to control plane
>VSI. This will redirect packets from VFs which don't match other rules to
>control plane VSI.
>
>On RX site default rule is added on uplink VSI to receive all traffic that doesn't
>match other rules. When setting switchdev environment all other rules from
>VFs should be removed. Packet to VFs will be forwarded by control plane VSI.
>
>As VF without any mac rules can't send any packet because of antispoof
>mechanism, VSI antispoof should be turned off on each VFs.
>
>To send packet from representor to correct VSI, destintion VSI field in TX
>descriptor will have to be filled. Allow that by setting destination override bit
>in control plane VSI security config.
>
>Packet from VFs will be received on control plane VSI. Driver should decide to
>which netdev forward the packet. Decision is made based on src_vsi field from
>descriptor. There is a target netdev list in control plane VSI struct which
>choose netdev based on src_vsi number.
>
>Co-developed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice.h         |  23 ++
> drivers/net/ethernet/intel/ice/ice_eswitch.c | 394 +++++++++++++++++++
>drivers/net/ethernet/intel/ice/ice_eswitch.h |  16 +-
> drivers/net/ethernet/intel/ice/ice_main.c    |  19 +-
> drivers/net/ethernet/intel/ice/ice_repr.c    |  12 +
> drivers/net/ethernet/intel/ice/ice_repr.h    |   2 +
> 6 files changed, 453 insertions(+), 13 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
