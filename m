From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 03 Apr 2015 14:07:13 -0700
Subject: [Intel-wired-lan] [net-next 23/25] fm10k: reset head instead of
 calling update_max_size
In-Reply-To: <1428092835-16834-23-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-23-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428095233.2662.134.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> When we forcefully shutdown the mailbox, we then go about resetting
> max
> size to 0, and clearing all messages in the FIFO. Instead, we should
> just reset the head pointer so that the FIFO becomes empty, rather
> than
> changing the max size to 0. This helps prevent increment in tx_dropped
> counter during mailbox negotiation, which is confusing to viewers of
> Linux ethtool statistics output.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_mbx.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150403/200e42ed/attachment.asc>
