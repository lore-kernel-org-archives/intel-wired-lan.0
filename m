From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 6 Aug 2021 10:08:27 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 06/12] ice: allow changing
 lan_en and lb_en on dflt rules
In-Reply-To: <20210625024501.6126-7-michal.swiatkowski@linux.intel.com>
References: <20210625024501.6126-1-michal.swiatkowski@linux.intel.com>
 <20210625024501.6126-7-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB45546785FBB2DA5FA8D783209CF39@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v3 06/12] ice: allow changing lan_en
>and lb_en on dflt rules
>
>There is no way to change default lan_en and lb_en flags while adding new
>rule. Add function that allows changing these flags on ICE_SW_LKUP_DFLT
>recipe and any rule id.
>
>lan_en allows packet to go outside if rule is matched. Clearing this bit will
>block packet from sending it outside.
>
>lb_en allows packet to be forwarded to other VSI. Clearing this bit will block
>packet from forwarding it to other VSI.
>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_fltr.c   | 80 +++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_fltr.h   |  7 ++
> drivers/net/ethernet/intel/ice/ice_switch.c |  2 +-
>drivers/net/ethernet/intel/ice/ice_switch.h |  6 ++
> 4 files changed, 94 insertions(+), 1 deletion(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
