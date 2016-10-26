From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Oct 2016 21:17:53 +0000
Subject: [Intel-wired-lan] [next PATCH S51-V2 1/8] i40e: Be much
	more	verbose about what we can and cannot offload
In-Reply-To: <1477436933-13679-2-git-send-email-bimmy.pujari@intel.com>
References: <1477436933-13679-1-git-send-email-bimmy.pujari@intel.com>
 <1477436933-13679-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA2925F@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S51-V2 1/8] i40e: Be much more
> verbose about what we can and cannot offload
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This change makes it so that we are much more robust about defining what
> we can and cannot offload.  Previously we were just checking for the L4
> tunnel header length, however there are other fields we should be verifying
> as there are multiple scenarios in which we cannot perform hardware
> offloads.
> 
> In addition the device only supports GSO as long as the MSS is 64 or greater.
> We were not checking this so an MSS less than that was resulting in Tx hangs.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I5e2fd5f3075c73601b4b36327b771c64fcb6c31b
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
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 52
> ++++++++++++++++++++++++-----
>  1 file changed, 44 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
No TX Hangs with MTU 102


