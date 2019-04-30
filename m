From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Apr 2019 23:18:18 +0000
Subject: [Intel-wired-lan] [PATCH S19 01/15] ice: Implement LLDP
 persistence
In-Reply-To: <20190416172439.27908-2-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
 <20190416172439.27908-2-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39B03D@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:24 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S19 01/15] ice: Implement LLDP persistence
> 
> Implement LLDP persistence across reboots, start and stop of LLDP agent.
> Add additional parameter to ice_aq_start_lldp and ice_aq_stop_lldp.
> 
> Also change the ethtool private flag from "disable-fw-lldp" to "enable-fw-
> lldp". This change will flip the boolean logic of the functionality of the flag (on
> = enable, off = disable). The change in name and functionality is to
> differentiate between the pre-persistence and post-persistence states.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> squashed
> multiple commits]
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  2 +-
>  drivers/net/ethernet/intel/ice/ice_dcb.c     | 16 +++++++++--
>  drivers/net/ethernet/intel/ice/ice_dcb.h     |  8 ++++--
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 30 ++++----------------
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 +++----
>  5 files changed, 29 insertions(+), 37 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


