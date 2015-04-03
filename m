From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 03 Apr 2015 14:02:21 -0700
Subject: [Intel-wired-lan] [net-next 06/25] fm10k: fix unused warnings
In-Reply-To: <1428092835-16834-6-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-6-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428094941.2662.117.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-03 at 13:26 -0700, Jeff Kirsher wrote:
> The were several functions which had parameters which were never or
> sometimes used in functions.  To resolve possible compiler warnings,
> use __always_unused or __maybe_unused kernel macros to resolve.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c   |  6 +++---
>  drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c |  8 +++++---
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 12 ++++++------
>  drivers/net/ethernet/intel/fm10k/fm10k_iov.c     |  6 +++---
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c    | 18
> ++++++------------
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c     | 17
> +++++++++--------
>  drivers/net/ethernet/intel/fm10k/fm10k_ptp.c     |  5 +++--
>  7 files changed, 35 insertions(+), 37 deletions(-)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150403/b3ca7632/attachment.asc>
