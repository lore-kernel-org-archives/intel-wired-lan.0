From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Apr 2019 22:57:23 +0000
Subject: [Intel-wired-lan] [PATCH S21 12/14] ice: Use a different
 ICE_DBG bit for firmware log messages
In-Reply-To: <20190416173503.29847-13-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
 <20190416173503.29847-13-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39AFFC@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S21 12/14] ice: Use a different ICE_DBG bit
> for firmware log messages
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Replace the use of the ICE_DBG_AQ_MSG bit when dumping firmware
> logging messages with a separate distinct type ICE_DBG_FW_LOG. This is
> useful so that developers may enable ICE_DBG_FW_LOG and get firmware
> logging messages, without also dumping AdminQ messages at the same
> time.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 6 +++---
>  drivers/net/ethernet/intel/ice/ice_type.h   | 1 +
>  2 files changed, 4 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


