From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 29 Jul 2016 17:10:08 +0000
Subject: [Intel-wired-lan] [next PATCH S40-V2 09/12] i40e: fix lookup
 table	when RSS disabled/enabled
In-Reply-To: <1469646161-30024-10-git-send-email-bimmy.pujari@intel.com>
References: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
 <1469646161-30024-10-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EB953@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, July 27, 2016 12:03 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Brady, Alan <alan.brady@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S40-V2 09/12] i40e: fix lookup table
> when RSS disabled/enabled
> 
> From: "Alan Brady" <alan.brady@intel.com>
> 
> This patch fixes the bug which causes RSS to continue to work after being
> disabled.  After disabling RSS, traffic would continue to be assigned to
> different queues instead of falling back to a single queue. Without this patch,
> attempting to disable RSS would not work as expected. This patch fixes the
> bug by clearing the lookup table used by RSS such that all traffic is assigned to
> a single queue.  This patch also addresses the issue of reinstating  the lookup
> table should RSS then be re-enabled.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Change-ID: Ib20c7c6a7e9f1f772bb787370f8a8c664796b141
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 28
> ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
RSS no longer functions when disabled, packets all go to queue 0.
