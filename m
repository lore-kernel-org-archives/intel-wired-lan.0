From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:48:14 +0000
Subject: [Intel-wired-lan] [net-next 12/25] fm10k: only increment
 tx_timeout_count in Tx hang path
In-Reply-To: <1428095046.2662.123.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-12-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428095046.2662.123.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D331@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Friday, April 3, 2015 2:04 PM
To: intel-wired-lan@lists.osuosl.org
Cc: Keller, Jacob E; Singh, Krishneil K
Subject: Re: [net-next 12/25] fm10k: only increment tx_timeout_count in Tx hang path

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> We were incrementing the tx_timeout_count for both the Tx hang and 
> then for all reset flows.  Instead, we should only increment 
> tx_timeout_count in the Tx hang path, so that our Tx hang counter does 
> not increment when it was not caused by a Tx hang.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 1 -
>  1 file changed, 1 deletion(-)

I have applied to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


