From: Young, James M <james.m.young@intel.com>
Date: Tue, 14 Apr 2015 15:32:39 +0000
Subject: [Intel-wired-lan] [net-next S3 05/13] i40e: move VF
 notification routines up
In-Reply-To: <1428450862.28000.10.camel@jtkirshe-mobl>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
 <1428450342-48517-5-git-send-email-catherine.sullivan@intel.com>
 <1428450862.28000.10.camel@jtkirshe-mobl>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9E5E99@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Tuesday, April 07, 2015 4:54 PM
To: Sullivan, Catherine; Young, James M
Cc: intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] [net-next S3 05/13] i40e: move VF notification routines up

On Tue, 2015-04-07 at 19:45 -0400, Catherine Sullivan wrote:
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Move the VF notification functions to the top of the file. This 
> eliminates an unnecessary declaration.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I036171f14180ee9f0ce4e0a21334d6a217d06c94
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 246
> ++++++++++-----------
>  1 file changed, 123 insertions(+), 123 deletions(-)

Thanks Catherine, I have added your patch to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Jim Young <james.m.young@intel.com>

