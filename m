From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Oct 2018 21:44:49 +0000
Subject: [Intel-wired-lan] [PATCH 5/7] ice: Introduce
 ice_dev_onetime_setup
In-Reply-To: <20181018153709.32664-6-anirudh.venkataramanan@intel.com>
References: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
 <20181018153709.32664-6-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D30F742@FMSMSX152.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, October 18, 2018 8:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 5/7] ice: Introduce
> ice_dev_onetime_setup
> 
> ice_dev_onetime_setup contains a couple of driver workarounds for current
> firmware limitations. These workarounds are expected to go away once
> these limitations are fixed in the firmware.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c     | 19
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h     |  3 +++
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  2 ++
>  drivers/net/ethernet/intel/ice/ice_lib.c        |  1 +
>  4 files changed, 25 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


