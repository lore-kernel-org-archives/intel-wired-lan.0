From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Thu, 22 Oct 2015 21:36:21 +0000
Subject: [Intel-wired-lan] [next PATCH S 2/2 v3] i40e/i40evf: refactor
 tx	timeout logic
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B1D28@ORSMSX104.amr.corp.intel.com>
References: <1443132795-139834-1-git-send-email-catherine.sullivan@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B1D28@ORSMSX104.amr.corp.intel.com>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6264FF91CEB@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bowers, AndrewX
> Sent: Monday, September 28, 2015 10:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [next PATCH S 2/2 v3] i40e/i40evf: refactor tx
> timeout logic
> 
[..]
> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
> Code changes present in tree, still see occasional tx_timeout with hung
> queue, however adaptor does not reset and link does not go down.
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Jeff, please have this also pulled into Dave's net tree, this and the other patch (Fix RS bit update..) need to go into net to fix the tx-timeout problem.  The problem exists today in Dave's net tree, if its identical to your net tree, as that's where Andrew is seeing the tx hang.  

Andrew, can you test applying  this patch and the other patch (Fix RS bit update..) which I'll also add this note to to confirm the solution per Kiran.

Thanks,

Carolyn
