From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:44:59 +0000
Subject: [Intel-wired-lan] [net-next 05/25] fm10k: Add netconsole support
In-Reply-To: <1428094923.2662.116.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-5-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428094923.2662.116.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D2A4@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Friday, April 3, 2015 2:02 PM
To: intel-wired-lan@lists.osuosl.org
Cc: Kwan, Ngai-mint; Singh, Krishneil K
Subject: Re: [net-next 05/25] fm10k: Add netconsole support

On Fri, 2015-04-03 at 13:26 -0700, Jeff Kirsher wrote:
> This change adds a function called "fm10k_netpoll" that's used to 
> define "ndo_poll_controller" in "fm10k_netdev_ops". This is required 
> to enable support for "netconsole" in fm10k.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k.h        |  1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 21
> +++++++++++++++++++++
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c    |  2 +-
>  3 files changed, 23 insertions(+), 1 deletion(-)

I have applied to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
