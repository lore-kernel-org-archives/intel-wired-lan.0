From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jan 2016 18:15:46 +0000
Subject: [Intel-wired-lan] [next PATCH S24 08/12] i40e: Limit DCB FW
 version	checks to X710/XL710 devices
In-Reply-To: <1450823114-29514-9-git-send-email-deepthi.kavalur@intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
 <1450823114-29514-9-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98012A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Tuesday, December 22, 2015 2:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Bowers, Gregory J <gregory.j.bowers@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S24 08/12] i40e: Limit DCB FW version
> checks to X710/XL710 devices
> 
> From: Greg Bowers <gregory.j.bowers@intel.com>
> 
> X710/XL710 devices require FW version checks to properly handle DCB
> configurations from the FW.  Newer devices do not, so limit these checks to
> X710/XL710.
> 
> Signed-off-by: Greg Bowers <gregory.j.bowers@intel.com>
> Acked-by: Shannon Nelson <shannon.nelson@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
> Testing-Hints:
> Test that X710/XL710 and X722 devices support CEE and IEEE DCBX.
> 
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
FCoE/DCB - Patch code changes correctly applied, does not break base driver
