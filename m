From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 9 Sep 2021 04:00:58 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next 3/7] ice: Add DSCP support
In-Reply-To: <BYAPR11MB3367187CE2A153676BE1544CFCD39@BYAPR11MB3367.namprd11.prod.outlook.com>
References: <20210806205356.18517-1-anthony.l.nguyen@intel.com>
 <BYAPR11MB3367187CE2A153676BE1544CFCD39@BYAPR11MB3367.namprd11.prod.outlook.com>
Message-ID: <BYAPR11MB3367F71732104C5496AFFD66FCD59@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Tony Nguyen
> Sent: Saturday, August 7, 2021 2:24 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 net-next 3/7] ice: Add DSCP
> support
>
> From: Dave Ertman <david.m.ertman@intel.com>
>
> Implement the code to handle submission of APP TLV's containing DSCP
> to TC mapping.
>
> The first such mapping received on an interface will cause that PF to
> switch to
> L3 DSCP QoS mode, apply the default config for that mode, and apply
> the received mapping.
>
> Only one such mapping will be allowed per DSCP value, and when the
> last DSCP mapping is deleted, the PF will switch back into L2 VLAN QoS
> mode, applying the appropriate default QoS settings.
>
> L3 DSCP QoS mode will only be allowed in SW DCBx mode, in other words,
> when the FW LLDP engine is disabled.  Commands that break this mutual
> exclusivity will be blocked.
>
> Co-developed-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2:
> - Add implementation for ndo_select_queue to remap the priority to
> match the DSCP2UP data
> - Adjust ice_get_pfc_mode() to return 0 instead of -EOPNOTSUPP when
> CONFIG_DCB is not defined
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  18 ++
>  drivers/net/ethernet/intel/ice/ice_dcb.c      | 225 ++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_dcb.h      |  19 ++
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   7 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |  12 +
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c   | 188 ++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |   1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  34 +++
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |   3 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |  10 +-
>  11 files changed, 468 insertions(+), 56 deletions(-)
>

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker> at Intel)
