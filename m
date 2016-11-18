From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 18 Nov 2016 17:18:07 +0000
Subject: [Intel-wired-lan] [next PATCH S54 15/15] i40evf: remove
	unused	device ID
In-Reply-To: <1478896779-13697-16-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
 <1478896779-13697-16-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38137@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, November 11, 2016 12:40 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S54 15/15] i40evf: remove unused
> device ID
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> This device ID was intended for use when running Linux VF drivers under
> Hyper-V, but we have determined that it is not necessary. Since it is unused,
> and will never be used, remove it.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I74998ab4237db043cd400547bb54a0a5e2a37ea5
> ---
> Testing Hints : No code change. Modinfo should not show 37D9 as a device
> supported by i40evf. This is DCR 2216.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


