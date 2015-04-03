From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 03 Apr 2015 14:01:46 -0700
Subject: [Intel-wired-lan] [net-next 04/25] fm10k: Have the VF get the
 default VLAN during init
In-Reply-To: <1428092835-16834-4-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-4-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428094906.2662.115.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-03 at 13:26 -0700, Jeff Kirsher wrote:
> Currently, the VFs do not read the default VLAN during initialization,
> so they will not be able to indicate untagged frames properly.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_vf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150403/4abb4eac/attachment.asc>
