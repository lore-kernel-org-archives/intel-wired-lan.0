From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Mar 2019 23:47:22 +0000
Subject: [Intel-wired-lan] [PATCH S15 02/14] ice: enable VF admin queue
 interrupts
In-Reply-To: <20190219230414.25627-3-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
 <20190219230414.25627-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367588@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 19, 2019 3:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S15 02/14] ice: enable VF admin queue
> interrupts
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The VPINT_MBX_CTL register array must be programmed to enable VF
> admin queue interrupts. Without this, VFs never get interrupts on vector 0,
> and some VF drivers will fail to init.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h  | 2 ++
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 4 ++++
>  2 files changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


