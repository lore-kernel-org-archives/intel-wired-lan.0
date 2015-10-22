From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Thu, 22 Oct 2015 21:41:23 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix RS bit update in Tx path
 and	disable force WB workaround
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B1D87@ORSMSX104.amr.corp.intel.com>
References: <1443230773-174806-1-git-send-email-anjali.singhai@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B1D87@ORSMSX104.amr.corp.intel.com>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6264FF91D43@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bowers, AndrewX
> Sent: Monday, September 28, 2015 11:04 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH] i40e: Fix RS bit update in Tx path and
> disable force WB workaround
[..]
> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
> Code changes present in tree
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

This patch is the other patch needed to fix tx-hang issue seen in net queue.  

Andrew, can you apply this patch with the tx-timeout patch to the net queue you are testing on to confirm the fix?

Thanks,

carolyn
