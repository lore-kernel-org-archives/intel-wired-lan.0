From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 03 Apr 2015 14:02:56 -0700
Subject: [Intel-wired-lan] [net-next 08/25] fm10k: only show actual
 queues, not the maximum in hardware
In-Reply-To: <1428092835-16834-8-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-8-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428094976.2662.119.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-03 at 13:26 -0700, Jeff Kirsher wrote:
> Currently, we show statistics for all 128 queues, even though we don't
> necessarily have that many queues available especially in the VF case.
> Instead, use the hw->mac.max_queues value, which tells us how many
> queues we actually have, rather than the space for the rings we
> allocated. In this way, we prevent dumping statistics that are useless
> on the VF.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I have applied to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150403/025936ae/attachment.asc>
