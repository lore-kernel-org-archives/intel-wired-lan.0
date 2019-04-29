From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 29 Apr 2019 18:17:13 +0000
Subject: [Intel-wired-lan] [PATCH S20 12/15] ice: Add ice_get_fw_log_cfg
 to init FW logging
In-Reply-To: <20190416173052.28928-13-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
 <20190416173052.28928-13-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39ACE8@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S20 12/15] ice: Add ice_get_fw_log_cfg to
> init FW logging
> 
> From: Dan Nowlin <dan.nowlin@intel.com>
> 
> In order to initialize the current status of the FW logging, this patch adds
> ice_get_fw_log_cfg. The function retrieves the current setting of the FW
> logging from HW and updates the ice_hw structure accordingly.
> 
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
>  drivers/net/ethernet/intel/ice/ice_common.c   | 48
> +++++++++++++++++++
>  2 files changed, 49 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


