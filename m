From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:50:36 +0000
Subject: [Intel-wired-lan] [net-next 21/25] fm10k: update xcast mode
 before synchronizing multicast addresses
In-Reply-To: <1428095193.2662.132.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-21-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428095193.2662.132.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D3CE@ORSMSX103.amr.corp.intel.com>
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
Subject: Re: [net-next 21/25] fm10k: update xcast mode before synchronizing multicast addresses

On Fri, 2015-04-03 at 13:27 -0700, Jeff Kirsher wrote:
> When the PF receives a request to update a multicast address for the 
> VF, it checks the enabled multicast mode first. Fix a bug where the VF 
> tried to set a multicast address before requesting the required xcast 
> mode.
> This ensures the multicast addresses are honored as long as the xcast 
> mode was allowed.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 22
> +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

I have applied to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


