From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 11 Aug 2021 05:24:35 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 04/12] ice: allow process
 vf opcodes in different ways
In-Reply-To: <20210625024501.6126-5-michal.swiatkowski@linux.intel.com>
References: <20210625024501.6126-1-michal.swiatkowski@linux.intel.com>
 <20210625024501.6126-5-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB4554CD4703D59F012C57AE4D9CF89@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v3 04/12] ice: allow process vf
>opcodes in different ways
>
>In switchdev driver shouldn't add MAC, VLAN and promisc filters on iavf
>demand but should return success to not break normal iavf flow.
>
>Achieve that by creating table of functions pointer with default functions used
>to parse iavf command. While parse iavf command, call correct function from
>table instead of calling function direct.
>
>When port representors are being created change functions in table to new
>one that behaves correctly for switchdev puprose (ignoring new filters).
>
>Change back to default ops when representors are being removed.
>
>Co-developed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_repr.c     |  23 ++-
> .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 170 +++++++++++++++---
>.../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  32 ++++
> 3 files changed, 198 insertions(+), 27 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
