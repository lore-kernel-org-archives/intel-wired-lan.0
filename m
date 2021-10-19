From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 19 Oct 2021 04:47:25 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Manage act flags for
 switchdev offloads
In-Reply-To: <20210923124348.2371-1-wojciech.drewek@intel.com>
References: <20210923124348.2371-1-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB455416F82C612CBEFD2748F99CBD9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Wojciech Drewek
>Sent: Thursday, September 23, 2021 6:14 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next] ice: Manage act flags for switchdev
>offloads
>
>Currently it is not possible to set/unset lb_en and lan_en flags for advanced
>rules during their creation. Both flags are enabled by default. In case of
>switchdev offloads for egress traffic we need lb_en to be disabled. Because of
>that, we work around it by updating the rule immediately after its creation.
>
>This change allows us to set/unset those flags right away and it gets rid of old
>workaround as well. Using ice_adv_rule_flags_info structure we can pass info
>about flags we want to be set for a given advanced rule. Flags are stored in
>flags_info.act.
>Values from act would be used only if act_valid was set to true, otherwise
>default values would be used.
>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
>---
> drivers/net/ethernet/intel/ice/ice_fltr.c   | 127 --------------------
> drivers/net/ethernet/intel/ice/ice_fltr.h   |   4 -
> drivers/net/ethernet/intel/ice/ice_switch.c |   9 +-
> drivers/net/ethernet/intel/ice/ice_switch.h |  11 ++
> drivers/net/ethernet/intel/ice/ice_tc_lib.c |   8 +-
> 5 files changed, 21 insertions(+), 138 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
