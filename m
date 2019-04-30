From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Apr 2019 22:53:04 +0000
Subject: [Intel-wired-lan] [PATCH S21 06/14] ice: Add switch rules to
 handle LLDP packets
In-Reply-To: <20190416173503.29847-7-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
 <20190416173503.29847-7-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39AF99@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S21 06/14] ice: Add switch rules to handle
> LLDP packets
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Add call to configure dropping egress LLDP packets in ice_vsi_setup and
> remove the rule in ice_vsi_release.
> 
> Add calls to add/remove rule to route LLDP packets to default VSI when FW
> LLDP engine is disabled/enabled and remove rule if applied during
> ice_vsi_release.
> 
> In the function ice_add_eth_mac(), there is a line that hardcodes the filter
> info flag to TX. This is incorrect as this flag will be set by the calling function
> that built the list of filters to add. So remove the hardcoded value.
> 
> This patch also contains a fix to stop treating the DCBx state of "Not Started"
> as an error state that kicks DCB in SW mode. This will address having non-
> cabled interfaces automatically go into SW mode with the FW engine
> running.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  4 +-
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 11 +++
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 70 +++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_lib.h     |  2 +
>  drivers/net/ethernet/intel/ice/ice_switch.c  |  5 +-
>  5 files changed, 86 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


