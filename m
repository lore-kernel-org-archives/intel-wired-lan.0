From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 03 Apr 2015 14:03:48 -0700
Subject: [Intel-wired-lan] [net-next 11/25] fm10k: remove extraneous
 "Reset interface" message
In-Reply-To: <1428092835-16834-11-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-11-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428095028.2662.122.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> Since we already print this message when a reset is requested via the
> RESET_REQUESTED flag, we do not need to print it before setting the
> flag.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c | 1 -
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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150403/c8ece0b8/attachment.asc>
