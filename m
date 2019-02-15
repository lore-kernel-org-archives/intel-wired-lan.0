From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 Feb 2019 00:02:39 +0000
Subject: [Intel-wired-lan] [PATCH S11 11/16] ice: clear VF ARQLEN
 register on reset
In-Reply-To: <20190208205043.11975-12-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-12-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3662A4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S11 11/16] ice: clear VF ARQLEN register on
> reset
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> On older devices like X710 and X722, the VF's ARQLEN register is cleared on
> reset, so the VF driver uses that register to detect an unannouced reset.
> Unfortunately, on devices controlled by ice, this register is NOT cleared on
> reset. This causes the VF to miss resets, and even on properly-announced
> resets, the VF driver complains that it didn't see the reset.
> 
> To fix this, we'll do it in software. When we handle a VF reset (whether
> triggered by software or VFLR), clear this register after the HW reset is
> complete.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h  | 1 +
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 5 +++++
>  2 files changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


