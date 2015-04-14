From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:51:22 +0000
Subject: [Intel-wired-lan] [net-next 25/25] fm10k: corrected VF
	multicast update
In-Reply-To: <1428095274.2662.136.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-25-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428095274.2662.136.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D411@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Friday, April 3, 2015 2:08 PM
To: intel-wired-lan@lists.osuosl.org
Cc: Kwan, Ngai-mint; Singh, Krishneil K
Subject: Re: [net-next 25/25] fm10k: corrected VF multicast update

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> VFs were being improperly added to the switch's multicast group. The 
> error stems from the fact that incorrect arguments were passed to the 
> "update_mc_addr" function. It would seem to be a copy paste error 
> since the parameters are similar to the "update_uc_addr" function.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

I have applied to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


