From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 03 Apr 2015 14:04:06 -0700
Subject: [Intel-wired-lan] [net-next 12/25] fm10k: only increment
 tx_timeout_count in Tx hang path
In-Reply-To: <1428092835-16834-12-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-12-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428095046.2662.123.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> We were incrementing the tx_timeout_count for both the Tx hang
> and then for all reset flows.  Instead, we should only increment
> tx_timeout_count in the Tx hang path, so that our Tx hang counter
> does not increment when it was not caused by a Tx hang.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 1 -
>  1 file changed, 1 deletion(-)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150403/b5a2ffe4/attachment.asc>
