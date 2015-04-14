From: Young, James M <james.m.young@intel.com>
Date: Tue, 14 Apr 2015 15:33:13 +0000
Subject: [Intel-wired-lan] [net-next S3 08/13] i40e: enable user dump of
 internal hardware state
In-Reply-To: <1428451097.1860.0.camel@jtkirshe-mobl>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
 <1428450342-48517-8-git-send-email-catherine.sullivan@intel.com>
 <1428451097.1860.0.camel@jtkirshe-mobl>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9E5EA8@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Tuesday, April 07, 2015 4:58 PM
To: Sullivan, Catherine; Young, James M
Cc: intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] [net-next S3 08/13] i40e: enable user dump of internal hardware state

On Tue, 2015-04-07 at 19:45 -0400, Catherine Sullivan wrote:
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> This is a feature to enable better debugging of user reported issues 
> by allowing a bash script to acquire information about the internal 
> hardware state. The data output to the kernel log is collected by the 
> script and can then be sent to Intel. This is a critical debugging 
> feature for helping us interpret and reproduce complex customer 
> setups.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ie8b3ab09086d6870a709015f51ada05af10b41bb
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c    | 57
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c   | 45
> +++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h |  5 +++
>  3 files changed, 107 insertions(+)

Thanks Catherine, I have added your patch to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Jim Young <james.m.young@intel.com>

