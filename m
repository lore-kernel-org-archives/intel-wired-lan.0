From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 11 Aug 2021 05:25:11 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 10/12] ice: rebuild
 switchdev when resetting all VFs
In-Reply-To: <20210625024501.6126-11-michal.swiatkowski@linux.intel.com>
References: <20210625024501.6126-1-michal.swiatkowski@linux.intel.com>
 <20210625024501.6126-11-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB45545E3C5C4611FD468446F99CF89@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v3 10/12] ice: rebuild switchdev
>when resetting all VFs
>
>From: Grzegorz Nitka <grzegorz.nitka@intel.com>
>
>As resetting all VFs behaves mostly like creating new VFs also eswitch
>infrastructure has to be recreated. The easiest way to do that is to rebuild
>eswitch after resetting VFs.
>
>Implement helper functions to start and stop all representors queues. This is
>used to disable traffic on port representors.
>
>In rebuild path:
>- NAPI has to be disabled
>- eswitch environment has to be set up
>- new port representors have to be created, because the old one had pointer
>to not exsisting VFs
>- new control plane VSI ring should be remaped
>- NAPI hast to be enabled
>- rxdid has to be set to FLEX_NIC_2, because this descriptor id support
>source_vsi, which is needed on control plane VSI queues
>- port representors queues have to be started
>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_eswitch.c  | 83 +++++++++++++++++++
>drivers/net/ethernet/intel/ice/ice_eswitch.h  | 10 +++
> drivers/net/ethernet/intel/ice/ice_main.c     | 11 ++-
> drivers/net/ethernet/intel/ice/ice_repr.c     | 20 +++++
> drivers/net/ethernet/intel/ice/ice_repr.h     |  3 +
> .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  4 +
> 6 files changed, 130 insertions(+), 1 deletion(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
