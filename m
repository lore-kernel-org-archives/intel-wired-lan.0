From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 22 Sep 2021 21:38:46 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3] ice: Manage act flags for
 switchdev offloads
In-Reply-To: <20210922084332.159306-1-wojciech.drewek@intel.com>
References: <20210922084332.159306-1-wojciech.drewek@intel.com>
Message-ID: <ca10f3feb675a8cbf59dee32bc3f1de3fe4e5a49.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-09-22 at 10:43 +0200, Wojciech Drewek wrote:
> Currently it is not possible to set/unset lb_en and lan_en flags
> for advanced rules during their creation. Both flags are enabled
> by default. In case of switchdev offloads for egress traffic we
> need lb_en to be disabled. Because of that, we work around it by
> updating the rule immediately after its creation.
> 
> This change allows us to set/unset those flags right away and it
> gets rid of old workaround as well. Using ice_adv_rule_flags_info
> structure we can pass info about flags we want to be set for
> a given advanced rule. Flags are stored in flags_info.act.
> Values from act would be used only if act_valid was set to true,
> otherwise default values would be used.
> 
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---

Can you include changelogs so that reviewing between versions is
easier?

Thanks,
Tony

>  drivers/net/ethernet/intel/ice/ice_fltr.c   | 127 ------------------
> --
>  drivers/net/ethernet/intel/ice/ice_fltr.h   |   4 -
>  drivers/net/ethernet/intel/ice/ice_switch.c |   9 +-
>  drivers/net/ethernet/intel/ice/ice_switch.h |  11 ++
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c |   8 +-
>  5 files changed, 21 insertions(+), 138 deletions(-)

