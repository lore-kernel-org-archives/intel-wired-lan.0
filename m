From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 4 Jan 2022 09:30:25 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/2] ice: improve switchdev's
 slow-path
In-Reply-To: <20211026103840.11455-3-wojciech.drewek@intel.com>
References: <20211026103840.11455-1-wojciech.drewek@intel.com>
 <20211026103840.11455-3-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB45540805065D347E09E38E709C4A9@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next 2/2] ice: improve switchdev's slow-
>path
>
>In current switchdev implementation, every VF PR is assigned to individual ring
>on switchdev ctrl VSI. For slow-path traffic, there is a mapping VF->ring done
>in software based on src_vsi value (by calling ice_eswitch_get_target_netdev
>function).
>
>With this change, HW solution is introduced which is more efficient. For each
>VF, src MAC (VF's MAC) filter will be created, which forwards packets to the
>coresponding switchdev ctrl VSI queue based on src MAC address.
>
>This filter has to be removed and then replayed in case of resetting one VF.
>Keep information about this rule in repr->mac_rule, thanks to that we know
>which rule has to be removed and replayed for a given VF.
>
>In case of CORE/GLOBAL all rules are removed automatically. We have to take
>care of readding them. This is done by ice_replay_vsi_adv_rule.
>
>When driver leaves switchdev mode, remove all advanced rules from
>switchdev ctrl VSI. This is done by ice_rem_adv_rule_for_vsi.
>
>Flag repr->rule_added is needed because in some cases reset might be
>triggered before VF sends request to add MAC.
>
>Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_eswitch.c  | 170 ++++++++++--------
>drivers/net/ethernet/intel/ice/ice_eswitch.h  |  24 +--
> drivers/net/ethernet/intel/ice/ice_fltr.c     |  80 ---------
> drivers/net/ethernet/intel/ice/ice_fltr.h     |   3 -
> drivers/net/ethernet/intel/ice/ice_main.c     |  24 +++
> drivers/net/ethernet/intel/ice/ice_repr.c     |  17 ++
> drivers/net/ethernet/intel/ice/ice_repr.h     |   5 +
> drivers/net/ethernet/intel/ice/ice_switch.c   |  54 ++++++
> drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   3 +-
> .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  11 ++
> 10 files changed, 221 insertions(+), 170 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
