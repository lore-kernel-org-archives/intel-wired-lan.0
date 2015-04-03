From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 03 Apr 2015 14:01:05 -0700
Subject: [Intel-wired-lan] [net-next 02/25] fm10k: Remove redundant
	rx_errors in ethtool
In-Reply-To: <1428092835-16834-2-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-2-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428094865.2662.113.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-03 at 13:26 -0700, Jeff Kirsher wrote:
> Output of ethtool was reporting 2 rx_errors entries. This change
> removes one of the redundant entries.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k.h         | 3 +--
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 3 +--
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c     | 5 ++---
>  3 files changed, 4 insertions(+), 7 deletions(-)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150403/63436402/attachment.asc>
