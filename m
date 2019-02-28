From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 19:34:56 +0000
Subject: [Intel-wired-lan] [PATCH S12 11/14] ice: Reset all VFs with
 VFLR during SR-IOV init flow
In-Reply-To: <20190208205101.12078-12-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
 <20190208205101.12078-12-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367053@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S12 11/14] ice: Reset all VFs with VFLR
> during SR-IOV init flow
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> During SR-IOV initialization, we allocate and setup VFs with reset, and since
> we were going to inform Firmware about our intention to do VFLR by
> disabling LAN TX Queue, then we really have to complete VF reset flow with
> VFLR using appropriate registers - Otherwise, reset status bit for VF in the
> Guest OS might returns DEADBEEF.
> This resolves issue to properly initialize VFs in the Guest OS via PCI
> passthrough.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


