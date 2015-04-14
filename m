From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:49:49 +0000
Subject: [Intel-wired-lan] [net-next 16/25] fm10k: don't handle mailbox
 events in iov_event path
In-Reply-To: <1428095112.2662.127.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-16-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428095112.2662.127.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D383@ORSMSX103.amr.corp.intel.com>
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
Subject: Re: [net-next 16/25] fm10k: don't handle mailbox events in iov_event path

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> Since we already schedule the service task, we can just wait for this 
> task to handle the mailbox events from the VF. This reduces some 
> complex code flow, and makes it so we have a single path for handling 
> the VF messages. There is a possibility that we have a slight delay in 
> handling VF messages, but it should be minimal.
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

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


