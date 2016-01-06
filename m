From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 6 Jan 2016 21:09:33 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fill at least min credits to a
 TC	credit refills
In-Reply-To: <20151123183051.17677.32713.stgit@lin-nd1-054.jf.intel.com>
References: <20151123183051.17677.32713.stgit@lin-nd1-054.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180D132A7@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Vasu Dev
> Sent: Monday, November 23, 2015 10:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fill at least min credits to a TC credit
> refills
> 
> Currently credit_refill and credit_max could be zero for a TC and that is causing
> Tx hang for CEE mode configuration, so to fix that have at min credit assigned to
> a TC and that is as what IEEE mode already does.
> 
> Signed-off-by: Vasu Dev <vasu.dev@intel.com>
> Change-ID: If652c133093a21e530f4e9eab09097976f57fb12
> ---

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
The scope of my testing was limited to trying to find any issues that this patch might cause with standard (non-DCB) networking traffic.

