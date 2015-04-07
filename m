From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 07 Apr 2015 16:58:54 -0700
Subject: [Intel-wired-lan] [net-next S3 10/13] i40e: handle possible
 memory allocation failure
In-Reply-To: <1428450342-48517-10-git-send-email-catherine.sullivan@intel.com>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
 <1428450342-48517-10-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1428451134.1860.2.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-04-07 at 19:45 -0400, Catherine Sullivan wrote:
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The init_interrupt_scheme function had a possible failure
> path to allocate memory that was found by smatch.
> 
> This adds the correct handling to the function to abort
> probe if the memory allocation fails.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I2bf1d826a244209619da4c452d0d58b3eb5e26a3
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Thanks Catherine, I have added your patch to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150407/e0cbce5f/attachment.asc>
