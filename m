From: Young, James M <james.m.young@intel.com>
Date: Tue, 14 Apr 2015 15:31:56 +0000
Subject: [Intel-wired-lan] [net-next S3 03/13] i40evf: remove aq_pending
In-Reply-To: <1428450814.28000.8.camel@jtkirshe-mobl>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
 <1428450342-48517-3-git-send-email-catherine.sullivan@intel.com>
 <1428450814.28000.8.camel@jtkirshe-mobl>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9E5E77@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Tuesday, April 07, 2015 4:54 PM
To: Sullivan, Catherine; Young, James M
Cc: intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] [net-next S3 03/13] i40evf: remove aq_pending

On Tue, 2015-04-07 at 19:45 -0400, Catherine Sullivan wrote:
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The aq_pending field in the adapter structure is actually redundant 
> with the current_op field. Remove the aq_pending field and expunge all 
> traces of it from the official record. This simplifies the code 
> significantly, especially in the virtual channel completion routine.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ib2957c8c19882bd0cecc6fcd133912c24b46a1ff
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  1 -
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  7 +---
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 42
> ++++++----------------
>  3 files changed, 12 insertions(+), 38 deletions(-)

Thanks Catherine, I have added your patch to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Jim Young <james.m.young@intel.com>

