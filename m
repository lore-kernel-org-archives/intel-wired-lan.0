From: Young, James M <james.m.young@intel.com>
Date: Tue, 14 Apr 2015 15:36:28 +0000
Subject: [Intel-wired-lan] [net-next S3 10/13] i40e: handle possible
 memory allocation failure
In-Reply-To: <1428451134.1860.2.camel@jtkirshe-mobl>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
 <1428450342-48517-10-git-send-email-catherine.sullivan@intel.com>
 <1428451134.1860.2.camel@jtkirshe-mobl>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9E5F1C@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Tuesday, April 07, 2015 4:59 PM
To: Sullivan, Catherine; Young, James M
Cc: intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] [net-next S3 10/13] i40e: handle possible memory allocation failure

On Tue, 2015-04-07 at 19:45 -0400, Catherine Sullivan wrote:
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The init_interrupt_scheme function had a possible failure path to 
> allocate memory that was found by smatch.
> 
> This adds the correct handling to the function to abort probe if the 
> memory allocation fails.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I2bf1d826a244209619da4c452d0d58b3eb5e26a3
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Thanks Catherine, I have added your patch to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Jim Young <james.m.young@intel.com>

