From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:49:23 +0000
Subject: [Intel-wired-lan] [net-next 14/25] fm10k: Set PF queues to
 unlimited bandwidth during virtualization
In-Reply-To: <1428095080.2662.125.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-14-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428095080.2662.125.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D362@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Friday, April 3, 2015 2:05 PM
To: intel-wired-lan@lists.osuosl.org
Cc: Russell, Todd A; Singh, Krishneil K
Subject: Re: [net-next 14/25] fm10k: Set PF queues to unlimited bandwidth during virtualization

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> When returning virtualization queues from the VF back to the PF, do 
> not retain the VF rate limiter.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Todd Russell <todd.a.russell@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I have applied to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


