From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:36:43 +0000
Subject: [Intel-wired-lan] [net-next 01/25] fm10k: Corrected an error in
	Tx statistics
In-Reply-To: <1428094839.2662.112.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428094839.2662.112.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D246@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Friday, April 3, 2015 2:01 PM
To: intel-wired-lan@lists.osuosl.org
Cc: Singh, Krishneil K
Subject: Re: [net-next 01/25] fm10k: Corrected an error in Tx statistics

On Fri, 2015-04-03 at 13:26 -0700, Jeff Kirsher wrote:
> The function collecting Tx statistics was actually using values from 
> the RX ring. Thus, Tx and Rx statistics values reported by "ifconfig" 
> will return identical values. This change corrects this error and the 
> Tx statistics is now reading from the Tx ring.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I have applied to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
