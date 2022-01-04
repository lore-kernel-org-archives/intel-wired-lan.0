From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 4 Jan 2022 09:30:55 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] ice: replay advanced
 rules after reset
In-Reply-To: <20211026103840.11455-2-wojciech.drewek@intel.com>
References: <20211026103840.11455-1-wojciech.drewek@intel.com>
 <20211026103840.11455-2-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB4554E630F57284C934195D119C4A9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Wojciech Drewek
>Sent: Tuesday, October 26, 2021 4:09 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next 1/2] ice: replay advanced rules after
>reset
>
>From: Victor Raj <victor.raj@intel.com>
>
>ice_replay_vsi_adv_rule will replay advanced rules for a given VSI.
>Exit this function when list of rules for given recipe is empty.
>Do not add rule when given vsi_handle does not match vsi_handle from the
>rule info.
>
>Use ICE_MAX_NUM_RECIPES instead of ICE_SW_LKUP_LAST in order to find
>advanced rules as well.
>
>Signed-off-by: Victor Raj <victor.raj@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_common.c |  2 +-
>drivers/net/ethernet/intel/ice/ice_switch.c | 41 +++++++++++++++++++--
> 2 files changed, 39 insertions(+), 4 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
