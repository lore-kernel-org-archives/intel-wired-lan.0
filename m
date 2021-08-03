From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 3 Aug 2021 08:59:05 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 09/12] ice: enable/disable
 switchdev when managing VFs
In-Reply-To: <20210625024501.6126-10-michal.swiatkowski@linux.intel.com>
References: <20210625024501.6126-1-michal.swiatkowski@linux.intel.com>
 <20210625024501.6126-10-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB45541A553269F4F14ED88D7C9CF09@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v3 09/12] ice: enable/disable
>switchdev when managing VFs
>
>From: Grzegorz Nitka <grzegorz.nitka@intel.com>
>
>Only way to enable switchdev is to create VFs when the eswitch mode is set to
>switchdev. Check if correct mode is set and enable switchdev in function
>which creating VFs.
>
>Disable switchdev when user change number of VFs to 0. Changing eswitch
>mode back to legacy when VFs are created in switchdev mode isn't allowed.
>
>As switchdev takes care of managing filter rules, adding new rules on VF is
>blocked.
>
>In case of resetting VF driver has to update pointer in ice_repr struct, because
>after reset VSI related things can change.
>
>Co-developed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_eswitch.c  | 38 +++++++++++++++++++
>drivers/net/ethernet/intel/ice/ice_eswitch.h  |  4 ++
> drivers/net/ethernet/intel/ice/ice_main.c     |  6 ++-
> .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 18 +++++++++
> 4 files changed, 64 insertions(+), 2 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
