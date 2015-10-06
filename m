From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Oct 2015 21:11:45 +0000
Subject: [Intel-wired-lan] [next PATCH S18 7/8] i40e: Disable VEB
	bridge	mode with SR-IOV failure
In-Reply-To: <1443724661-92168-8-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
 <1443724661-92168-8-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B380C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, October 01, 2015 11:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Abodunrin, Akeem G
> Subject: [Intel-wired-lan] [next PATCH S18 7/8] i40e: Disable VEB bridge
> mode with SR-IOV failure
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> If a call to enable SR-IOV in the kernel failed, we need to disable
> I40E_FLAG_VEB_MODE_ENABLED, so that bridge mode could fall back to
> VEPA, which is a default.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Change-ID: I12b6f776769506db85b29bea94b9c88d0b5ee65e
> 
> ---
> Testing-hints: 5645709
> Configure driver with SR-IOV in a nested virtualization environment
> (PCI-Passthrough) and confirmed that SR-IOV enablement failed. Bridge
> mode should remain VEPA instead of VEB with the notion that SR-IOV has
> been successfully configured.
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, "Switch no longer goes to VEB mode but stays in VEPA mode. 
No kernel crash. "
