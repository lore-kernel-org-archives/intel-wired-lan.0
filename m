From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 21:36:35 +0000
Subject: [Intel-wired-lan] [PATCH S10 04/15] ice: Add ethtool
 set_phys_id handler
In-Reply-To: <20181219180334.1104-5-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
 <20181219180334.1104-5-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343A08@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S10 04/15] ice: Add ethtool set_phys_id
> handler
> 
> Add led blinking handler to ethtool. Since led blinking is controlled by FW/HW
> only ETHTOOL_ID_ACTIVE and ETHTOOL_ID_INACTIVE are really needed.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 12 +++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.c     | 28
> +++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h     |  4 ++++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c    | 24
> +++++++++++++++++++++
>  4 files changed, 68 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


