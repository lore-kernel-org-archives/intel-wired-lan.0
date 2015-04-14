From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:45:15 +0000
Subject: [Intel-wired-lan] [net-next 06/25] fm10k: fix unused warnings
In-Reply-To: <1428094941.2662.117.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-6-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428094941.2662.117.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D2B9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



Thank You
Krishneil Singh

-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Friday, April 3, 2015 2:02 PM
To: intel-wired-lan@lists.osuosl.org
Cc: Keller, Jacob E; Singh, Krishneil K
Subject: Re: [net-next 06/25] fm10k: fix unused warnings

On Fri, 2015-04-03 at 13:26 -0700, Jeff Kirsher wrote:
> The were several functions which had parameters which were never or 
> sometimes used in functions.  To resolve possible compiler warnings, 
> use __always_unused or __maybe_unused kernel macros to resolve.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c   |  6 +++---
>  drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c |  8 +++++---  
> drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 12 ++++++------
>  drivers/net/ethernet/intel/fm10k/fm10k_iov.c     |  6 +++---
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c    | 18
> ++++++------------
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c     | 17
> +++++++++--------
>  drivers/net/ethernet/intel/fm10k/fm10k_ptp.c     |  5 +++--
>  7 files changed, 35 insertions(+), 37 deletions(-)

I have applied to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


