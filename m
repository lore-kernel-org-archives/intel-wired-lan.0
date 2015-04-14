From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:51:02 +0000
Subject: [Intel-wired-lan] [net-next 23/25] fm10k: reset head instead of
 calling update_max_size
In-Reply-To: <1428095233.2662.134.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-23-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428095233.2662.134.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D3F8@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Friday, April 3, 2015 2:07 PM
To: intel-wired-lan@lists.osuosl.org
Cc: Keller, Jacob E; Singh, Krishneil K
Subject: Re: [net-next 23/25] fm10k: reset head instead of calling update_max_size

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> When we forcefully shutdown the mailbox, we then go about resetting 
> max size to 0, and clearing all messages in the FIFO. Instead, we 
> should just reset the head pointer so that the FIFO becomes empty, 
> rather than changing the max size to 0. This helps prevent increment 
> in tx_dropped counter during mailbox negotiation, which is confusing 
> to viewers of Linux ethtool statistics output.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_mbx.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

I have applied to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


