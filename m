From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 07 Apr 2015 16:54:40 -0700
Subject: [Intel-wired-lan] [net-next S3 06/13] i40e: For VF reset (VFR
 and VFLR) add some more delay
In-Reply-To: <1428450342-48517-6-git-send-email-catherine.sullivan@intel.com>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
 <1428450342-48517-6-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1428450880.28000.11.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-04-07 at 19:45 -0400, Catherine Sullivan wrote:
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> With a HW issue that was recently discovered, after a VFLR HW might be
> indicating to us a reset completion little too early. So wait another
> 10
> msec for cache to be cleaned up.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I6a24dcf5dd7ffcd6500246e717411ef58532d1e9
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 +++
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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150407/954d7fcb/attachment.asc>
