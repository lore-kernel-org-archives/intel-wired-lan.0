From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 19:36:02 +0000
Subject: [Intel-wired-lan] [PATCH S12 13/14] ice: Enable MAC anti-spoof
 by default
In-Reply-To: <20190208205101.12078-14-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
 <20190208205101.12078-14-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367076@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S12 13/14] ice: Enable MAC anti-spoof by
> default
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch enables MAC anti-spoof by default, with creation of VF VSIs or
> when the VF VSIs are being re-initialized.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


