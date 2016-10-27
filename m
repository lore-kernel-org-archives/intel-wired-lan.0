From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 27 Oct 2016 16:13:54 +0000
Subject: [Intel-wired-lan] [next PATCH S51-V2 2/8] i40evf: Be much
	more	verbose about what we can and cannot offload
In-Reply-To: <1477436933-13679-3-git-send-email-bimmy.pujari@intel.com>
References: <1477436933-13679-1-git-send-email-bimmy.pujari@intel.com>
 <1477436933-13679-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA293FC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, October 25, 2016 4:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S51-V2 2/8] i40evf: Be much more
> verbose about what we can and cannot offload
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This change makes it so that we are much more robust about defining what
> we can and cannot offload.  Previously we were performing no checks.  This
> should bring us up to parity with the i40e PF driver.
> 
> In addition the device only supports GSO as long as the MSS is 64 or greater.
> We were not checking this so an MSS less than that was resulting in Tx hangs.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: If533553ec92fc6ba694eab6ac81fdaf3004f3592
> ---
> Testing Hints:
>         This is half of the fix needed to address MSS less than 64.  This
>         is the fix for upstream and kernels after 3.18.4, but we will need
>         to come up with a separate fix for out-of-tree that can be stripped
>         on kernels prior to 3.18.4.
> 
>         An easy test for this patch is to just set the MTU for an interface
>         to a value 102.  Without this patch we should see Tx hangs with
>         netperf and with we should be able to pass traffic without
>         triggering Tx hangs.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 59
> +++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


