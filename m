From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 6 Aug 2021 09:50:10 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 03/12] ice: introduce VF
 port representor
In-Reply-To: <20210625024501.6126-4-michal.swiatkowski@linux.intel.com>
References: <20210625024501.6126-1-michal.swiatkowski@linux.intel.com>
 <20210625024501.6126-4-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB4554064E5EC789BC943080A59CF39@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v3 03/12] ice: introduce VF port
>representor
>
>Port representor is used to manage VF from host side. To allow it each created
>representor registers netdevice with random hw address. Also devlink port is
>created for all representors.
>
>Port representor name is created based on switch id or managed by devlink
>core if devlink port was registered with success.
>
>Open and stop ndo ops are implemented to allow managing the VF link state.
>Link state is tracked in VF struct.
>
>Struct ice_netdev_priv is extended by pointer to representor field. This is
>needed to get correct representor from netdev struct mostly used in ndo calls.
>
>Implement helper functions to check if given netdev is netdev of port
>representor (ice_is_port_repr_netdev) and to get representor from netdev
>(ice_netdev_to_repr).
>
>As driver mostly will create or destroy port representors on all VFs instead of
>on single one, write functions to add and remove representor for each VF.
>
>Representor struct contains pointer to source VSI, which is VSI configured on
>VF, backpointer to VF, backpointer to netdev, q_vector pointer and
>metadata_dst which will be used in data path.
>
>Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/Makefile       |   3 +-
> drivers/net/ethernet/intel/ice/ice.h          |   2 +
> drivers/net/ethernet/intel/ice/ice_repr.c     | 254 ++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_repr.h     |  22 ++
> .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   2 +-
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |   4 +
> 6 files changed, 285 insertions(+), 2 deletions(-)  create mode 100644
>drivers/net/ethernet/intel/ice/ice_repr.c
> create mode 100644 drivers/net/ethernet/intel/ice/ice_repr.h
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
