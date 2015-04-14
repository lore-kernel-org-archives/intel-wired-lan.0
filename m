From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:46:18 +0000
Subject: [Intel-wired-lan] [net-next 08/25] fm10k: only show actual
 queues, not the maximum in hardware
In-Reply-To: <1428094976.2662.119.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-8-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428094976.2662.119.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D2E1@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Friday, April 3, 2015 2:03 PM
To: intel-wired-lan@lists.osuosl.org
Cc: Keller, Jacob E; Singh, Krishneil K
Subject: Re: [net-next 08/25] fm10k: only show actual queues, not the maximum in hardware

On Fri, 2015-04-03 at 13:26 -0700, Jeff Kirsher wrote:
> Currently, we show statistics for all 128 queues, even though we don't 
> necessarily have that many queues available especially in the VF case.
> Instead, use the hw->mac.max_queues value, which tells us how many 
> queues we actually have, rather than the space for the rings we 
> allocated. In this way, we prevent dumping statistics that are useless 
> on the VF.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I have applied to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


