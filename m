From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Apr 2016 19:45:22 +0000
Subject: [Intel-wired-lan] [v3 next PATCH S32 03/13] i40e: Move HW flush
In-Reply-To: <1459508173-22777-4-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1459508173-22777-4-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACBA4@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Friday, April 01, 2016 3:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v3 next PATCH S32 03/13] i40e: Move HW flush
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch moves the HW flush routine to the end of the reset flow, after the
> completion of writing to the device VFLR registers- the benefit is to avoid
> problems in the passthrough routines.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Change-ID: Ieb56866f21895e6c1fc514b7328c3df79807a57c
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Reset functions normally
