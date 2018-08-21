From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:41:04 +0000
Subject: [Intel-wired-lan] [PATCH v3 11/15] ice: Implement
 ice_bridge_getlink and ice_bridge_setlink
In-Reply-To: <20180809132958.23036-12-anirudh.venkataramanan@intel.com>
References: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
 <20180809132958.23036-12-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545AFF@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 11/15] ice: Implement
> ice_bridge_getlink and ice_bridge_setlink
> 
> From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> 
> ice_bridge_getlink returns the current bridge mode using
> ndo_dflt_bridge_getlink and the mode parameter available in first_switch-
> >bridge_mode.
> 
> ice_bridge_setlink is invoked when the bridge mode needs to changed. The
> value to be changed to is available as a netlink message which is parsed in this
> function. If the mode has to be changed, switch_flags is set appropriately
> (set ALLOW_LB for VEB mode and clear it for VEPA mode) and
> ice_aq_update_vsi is called. Also change the unicast switch filter rules.
> 
> Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c   | 140 +++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_switch.c |  41 ++++++
>  drivers/net/ethernet/intel/ice/ice_switch.h |   1 +
>  3 files changed, 181 insertions(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


