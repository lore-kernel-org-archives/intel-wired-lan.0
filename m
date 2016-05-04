From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 May 2016 16:44:21 +0000
Subject: [Intel-wired-lan] [next PATCH S36 11/12] i40e: don't add
 broadcast	filter for VFs
In-Reply-To: <1462313600-3123-12-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
 <1462313600-3123-12-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D59FA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, May 03, 2016 3:13 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S36 11/12] i40e: don't add broadcast
> filter for VFs
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Now that all VSIs are configured to receive broadcasts as default, we don't
> need to add a filter. This eliminates an annoying but harmless error message
> each time VFs are created or reset.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I4cd6339684df45b0d2722133eeb84c14fa93ea19
> ---
> Testing Hints : Enable VFs. Note annoying error is gone.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 8 --------
>  1 file changed, 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Error message does not appear on VF create/reset
