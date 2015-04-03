From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 03 Apr 2015 14:07:54 -0700
Subject: [Intel-wired-lan] [net-next 25/25] fm10k: corrected VF
	multicast update
In-Reply-To: <1428092835-16834-25-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-25-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428095274.2662.136.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> VFs were being improperly added to the switch's multicast group. The
> error stems from the fact that incorrect arguments were passed to the
> "update_mc_addr" function. It would seem to be a copy paste error
> since
> the parameters are similar to the "update_uc_addr" function.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150403/109015bf/attachment.asc>
