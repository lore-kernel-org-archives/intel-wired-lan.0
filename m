From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:47:27 +0000
Subject: [Intel-wired-lan] [net-next 09/25] fm10k: use
	hw->mac.max_queues for stats
In-Reply-To: <1428094992.2662.120.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-9-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428094992.2662.120.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D2FC@ORSMSX103.amr.corp.intel.com>
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
Subject: Re: [net-next 09/25] fm10k: use hw->mac.max_queues for stats

On Fri, 2015-04-03 at 13:26 -0700, Jeff Kirsher wrote:
> Even though it shouldn't strictly matter, don't count queue stats 
> higher than the max_queues value stored for this mac. This ensures 
> that we don't attempt to check queues which don't belong to use in 
> VFs. This shouldn't be a visible change, as the VFs should see zero 
> for queues which don't belong to them.
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

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

