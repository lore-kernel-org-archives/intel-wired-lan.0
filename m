From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:47:47 +0000
Subject: [Intel-wired-lan] [net-next 10/25] fm10k: separate PF only
 stats so that VF does not display them
In-Reply-To: <1428095011.2662.121.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-10-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428095011.2662.121.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D312@ORSMSX103.amr.corp.intel.com>
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
Subject: Re: [net-next 10/25] fm10k: separate PF only stats so that VF does not display them

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> This patch resolves an issue with ethtool stats displaying useless 
> values on the VF, because some stats simply have no meaning to the VF.
> Resolve this by splitting these out into PF_STATS and only showing 
> them if we aren't the VF.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 51
> +++++++++++++++++-------
>  1 file changed, 37 insertions(+), 14 deletions(-)

I have applied to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

