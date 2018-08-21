From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:12:19 +0000
Subject: [Intel-wired-lan] [PATCH v3 06/15] ice: Refactor switch rule
 management structures and functions
In-Reply-To: <20180809132958.23036-7-anirudh.venkataramanan@intel.com>
References: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
 <20180809132958.23036-7-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545927@ORSMSX109.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 06/15] ice: Refactor switch rule
> management structures and functions
> 
> This patch is an adaptation of the work originally done by Grishma Kotecha
> <grishma.kotecha@intel.com> that in summary refactors the switch filtering
> logic in the driver. More specifically,
>  - Update the recipe structure to also store list of rules
>  - Update the existing code for recipes like mac, vlan, ethtype etc to
>    use list head that is attached to switch recipe structure
>  - Add a common function to search for a rule entry and add a new rule
>    entry. Update the code to use this new function.
>  - Refactor the rem_handle_vsi_list function to simplify the logic
> 
> CC: Shannon Nelson <shannon.nelson@oracle.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |  36 +-
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 968 ++++++++----------
>  drivers/net/ethernet/intel/ice/ice_switch.h   |  35 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |  13 +-
>  5 files changed, 501 insertions(+), 553 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


