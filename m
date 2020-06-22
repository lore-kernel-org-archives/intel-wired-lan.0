From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 22 Jun 2020 19:55:00 +0000
Subject: [Intel-wired-lan] [PATCH v3] i40e: Add support for a new
 feature: Total Port Shutdown
In-Reply-To: <20200617000555.15985-1-arkadiusz.kubalewski@intel.com>
References: <20200617000555.15985-1-arkadiusz.kubalewski@intel.com>
Message-ID: <BN6PR1101MB2145E225DA6CAA7EF0BCB5DA8C970@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Arkadiusz Kubalewski
> Sent: Tuesday, June 16, 2020 5:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH v3] i40e: Add support for a new feature:
> Total Port Shutdown
> 
> After OS requests to down a link on a physical network port, the traffic is no
> longer being processed but the physical link with a link partner is still
> established.
> 
> Currently there is a feature (Link down on close) which allows to physically
> bring the link down (after OS request).
> 
> With this patch new feature with similar capability is introduced:
> TOTAL_PORT_SHUTDOWN
> Allows to physically disable the link on the NIC's port.
> If enabled, (after link down request from the OS) no link, traffic or led activity
> is possible on that port.
> 
> If I40E_FLAG_TOTAL_PORT_SHUTDOWN is enabled, the
> I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED must be explicitly forced to
> true and cannot be disabled at that time.
> The functionalities are exclusive in terms of configuration, but they also have
> similar behavior (allowing to disable physical link of the port), with following
> differences:
> - LINK_DOWN_ON_CLOSE_ENABLED is configurable at host OS run-time
>   and is supported by whole family of 7xx Intel Ethernet Controllers
> - TOTAL_PORT_SHUTDOWN may be enabled only before OS loads (in BIOS)
>   only if motherboard's BIOS and NIC's FW has support of it
> - when LINK_DOWN_ON_CLOSE_ENABLED is used, the link is being brought
>   down by sending phy_type=0 to NIC's FW
> - when TOTAL_PORT_SHUTDOWN is used, phy_type is not altered, instead
>   the link is being brought down by clearing bit
>   (I40E_AQ_PHY_ENABLE_LINK) in abilities field of
>   i40e_aq_set_phy_config structure
> 
> Introduced changes:
> - new private flag I40E_FLAG_TOTAL_PORT_SHUTDOWN for handling the
>   feature
> - probe of NVM if the feature was enabled at driver's port
>   initialization
> - special handling on link-down procedure to let FW physically
>   shutdown the port if the feature was enabled
> 
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v3:
> - error messages changed
> - '_ENABLED' suffix in a new private flag name
> - new comment for documentation of a new private flag
> - rewrite commit message
> 
> --- Cut off before submitting to external review --- Testing Hints (required if
> no HSD):
> Link up/down, link-down-on-close
> 
> Change-Id: I5427227c31b5e2d30f1149ad8d27d475caa27241
> Title: i40e: Add support for a new feature: Total Port Shutdown
> Change-type: FeatureImplementation
> HSDES-Number: 2209979406
> HSDES-Tenant: server_platf_lan.bug
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  22 ++++
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |   9 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 124 +++++++++++++++---
>  3 files changed, 134 insertions(+), 21 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


