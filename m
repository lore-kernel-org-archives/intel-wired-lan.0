From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 03 Apr 2015 14:04:58 -0700
Subject: [Intel-wired-lan] [net-next 15/25] fm10k: use separate
	workqueue for fm10k driver
In-Reply-To: <1428092835-16834-15-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-15-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428095098.2662.126.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> Since we run the watchdog periodically, which might take a while and
> potentially monopolize the system default workqueue, create our own
> separate work queue. This also helps reduce and stabilize latency
> between scheduling the work in our interrupt and actually performing
> the work. Still use a timer for the regular scheduled interval but
> queue the work onto its own work queue.
> 
> It seemed overkill to create a single workqueue per interface, so we
> just spawn a single work queue for all interfaces upon driver load.
> For
> this reason, use a multi-threaded workqueue with one thread per
> processor, rather than single threaded queue.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k.h      |  3 +++
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c | 12 ++++++++++++
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150403/caa940cc/attachment.asc>
