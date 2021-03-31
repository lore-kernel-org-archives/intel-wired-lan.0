From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 31 Mar 2021 20:59:59 +0000
Subject: [Intel-wired-lan] [PATCH S57 04/14] ice: Ignore EMODE return
 for opcode 0x0605
In-Reply-To: <20210325223517.17722-4-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
 <20210325223517.17722-4-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51053EE45AD9B09EF4288565FA7C9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, March 25, 2021 3:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S57 04/14] ice: Ignore EMODE return for
> opcode 0x0605
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> When link is owned by manageability, the driver is not allowed to fiddle with
> link. FW returns ICE_AQ_RC_EMODE if the driver attempts to do so.
> This patch adds a new function ice_set_link which abstracts the call to
> ice_aq_set_link_restart_an and provides a clean way to turn on/off link.
> 
> While making this change, I also spotted that an int variable was being used
> to hold both an ice_status return code and the Linux errno return code. This
> pattern more often than not results in the driver inadvertently returning
> ice_status back to kernel which is a major boo-boo. Clean it up.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 17 ++------
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 37 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.h     |  2 +
>  drivers/net/ethernet/intel/ice/ice_main.c    | 41 ++++++++------------
>  4 files changed, 59 insertions(+), 38 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


