From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 03 Apr 2015 14:03:12 -0700
Subject: [Intel-wired-lan] [net-next 09/25] fm10k: use
	hw->mac.max_queues for stats
In-Reply-To: <1428092835-16834-9-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-9-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428094992.2662.120.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-03 at 13:26 -0700, Jeff Kirsher wrote:
> Even though it shouldn't strictly matter, don't count queue stats
> higher
> than the max_queues value stored for this mac. This ensures that we
> don't attempt to check queues which don't belong to use in VFs. This
> shouldn't be a visible change, as the VFs should see zero for queues
> which don't belong to them.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 18
> +++++++++++-------
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c     |  2 +-
>  2 files changed, 12 insertions(+), 8 deletions(-)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150403/c874000b/attachment.asc>
