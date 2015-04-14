From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:51:13 +0000
Subject: [Intel-wired-lan] [net-next 24/25] fm10k: mbx_update_max_size
 does not drop all oversized messages
In-Reply-To: <1428095255.2662.135.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-24-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428095255.2662.135.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D402@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Friday, April 3, 2015 2:08 PM
To: intel-wired-lan@lists.osuosl.org
Cc: Keller, Jacob E; Singh, Krishneil K
Subject: Re: [net-next 24/25] fm10k: mbx_update_max_size does not drop all oversized messages

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> When we call update_max_size it does not drop all oversized messages.
> This is due to the difficulty in performing this operation, since it 
> is a FIFO which makes updating anything other than head or tail very 
> difficult. To fix this, modify validate_msg_size to ensure that we 
> error out later when trying to transmit the message that could be 
> oversized.
> This will generally be a rare condition, as it requires the FIFO to 
> include a message larger than the max_size negotiated during mailbox 
> connect. Note that max_size is always smaller than rx.size so it 
> should be safe to use here.
> 
> Also, update the update_max_size function header comment to clearly 
> indicate that it does not drop all oversized messages, but only those 
> at the head of the FIFO.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_mbx.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

I have applied to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


