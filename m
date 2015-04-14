From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:45:52 +0000
Subject: [Intel-wired-lan] [net-next 07/25] fm10k: allow creation of
	VLAN on default vid
In-Reply-To: <1428094957.2662.118.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-7-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428094957.2662.118.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D2CF@ORSMSX103.amr.corp.intel.com>
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
Subject: Re: [net-next 07/25] fm10k: allow creation of VLAN on default vid

On Fri, 2015-04-03 at 13:26 -0700, Jeff Kirsher wrote:
> Previously, the user was not allowed to create a VLAN interface on top 
> of the switch default vid.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 4 ----
>  1 file changed, 4 deletions(-)

I have applied to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


