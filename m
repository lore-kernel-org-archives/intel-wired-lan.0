From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:49:37 +0000
Subject: [Intel-wired-lan] [net-next 15/25] fm10k: use separate
	workqueue for fm10k driver
In-Reply-To: <1428095098.2662.126.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-15-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428095098.2662.126.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D36C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Friday, April 3, 2015 2:05 PM
To: intel-wired-lan@lists.osuosl.org
Cc: Keller, Jacob E; Singh, Krishneil K
Subject: Re: [net-next 15/25] fm10k: use separate workqueue for fm10k driver

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
> drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)

I have applied to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


