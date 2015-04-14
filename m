From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 14 Apr 2015 19:42:18 +0000
Subject: [Intel-wired-lan] [net-next 04/25] fm10k: Have the VF get the
 default VLAN during init
In-Reply-To: <1428094906.2662.115.camel@jtkirshe-mobl>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428092835-16834-4-git-send-email-jeffrey.t.kirsher@intel.com>
 <1428094906.2662.115.camel@jtkirshe-mobl>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2623D28C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Friday, April 3, 2015 2:02 PM
To: intel-wired-lan@lists.osuosl.org
Cc: Vick, Matthew; Singh, Krishneil K
Subject: Re: [net-next 04/25] fm10k: Have the VF get the default VLAN during init

On Fri, 2015-04-03 at 13:26 -0700, Jeff Kirsher wrote:
> Currently, the VFs do not read the default VLAN during initialization, 
> so they will not be able to indicate untagged frames properly.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Matthew Vick <matthew.vick@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_vf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

I have applied to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
