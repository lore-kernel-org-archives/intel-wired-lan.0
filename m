From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 07 Apr 2015 16:59:12 -0700
Subject: [Intel-wired-lan] [net-next S3 11/13] i40e: get rid of unused
 locals
In-Reply-To: <1428450342-48517-11-git-send-email-catherine.sullivan@intel.com>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
 <1428450342-48517-11-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1428451152.1860.3.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-04-07 at 19:45 -0400, Catherine Sullivan wrote:
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> These changes just remove unused variables and any code that uses them
> as the results of storing into these variables doesn't have any
> side effects that I can see or provide any benefit.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I8a5ec7132ff1443d23aae729cef94beaaaf19e3a
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c | 6 ++----
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150407/8606470d/attachment.asc>
