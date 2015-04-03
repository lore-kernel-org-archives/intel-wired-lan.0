From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 03 Apr 2015 14:05:12 -0700
Subject: [Intel-wired-lan] [net-next 16/25] fm10k: don't handle mailbox
 events in iov_event path
In-Reply-To: <1428092835-16834-16-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-16-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428095112.2662.127.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> Since we already schedule the service task, we can just wait for this
> task to handle the mailbox events from the VF. This reduces some
> complex
> code flow, and makes it so we have a single path for handling the VF
> messages. There is a possibility that we have a slight delay in
> handling
> VF messages, but it should be minimal.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_iov.c | 30
> ++--------------------------
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c |  3 +++
>  2 files changed, 5 insertions(+), 28 deletions(-)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150403/656a09a2/attachment.asc>
