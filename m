From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 07 Apr 2015 16:54:57 -0700
Subject: [Intel-wired-lan] [net-next S3 07/13] i40e: print FCoE
 capability reported by the device function
In-Reply-To: <1428450342-48517-7-git-send-email-catherine.sullivan@intel.com>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
 <1428450342-48517-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1428450897.28000.12.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-04-07 at 19:45 -0400, Catherine Sullivan wrote:
> From: Vasu Dev <vasu.dev@intel.com>
> 
> This is to allow quick check for FCoE capability is enabled or not
> in device function before any SW overrides.
> 
> Signed-off-by: Vasu Dev <vasu.dev@intel.com>
> Change-ID: I5f78ba798d566f143161273156916c6f4074496e
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 3 +++
>  1 file changed, 3 insertions(+)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150407/1990dea2/attachment.asc>
