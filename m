From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 21:37:38 +0000
Subject: [Intel-wired-lan] [PATCH S10 06/15] ice: Set physical link
 up/down when an interface is set up/down
In-Reply-To: <20181219180334.1104-7-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
 <20181219180334.1104-7-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343A29@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, December 19, 2018 10:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S10 06/15] ice: Set physical link up/down
> when an interface is set up/down
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> When a netdev is set up/down we need to set the phsyical link state
> accordingly. This patch adds that functionality by calling
> ice_force_phys_link_state(vsi, link_up) in both the ice_stop() and
> ice_open() paths.
> 
> In order to force link, ice_force_phys_link_state(vsi, link_up) will first
> determine the current phy capabilities. If link has not changed there is
> nothing to do. If link has changed, previous PHY capabilities are saved and the
> "Enable Automatic Link Update" and "Link Establishment State Machine
> (LESM)" enable bits are set. Then the new PHY config is saved. The "Enable
> Automatic Link Update" will force the FW to execute Setup link and restart
> auto-negotiation. This *should* then result in a "Link Status Event (LSE)"
> which will cause the driver to get the current link status.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  4 +-
>  drivers/net/ethernet/intel/ice/ice_main.c       | 97
> ++++++++++++++++++++++++-
>  2 files changed, 96 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


