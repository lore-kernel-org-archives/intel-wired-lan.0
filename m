From: Young, James M <james.m.young@intel.com>
Date: Tue, 14 Apr 2015 15:35:52 +0000
Subject: [Intel-wired-lan] [net-next S3 04/13] i40e: notify VFs of link
 state
In-Reply-To: <1428450835.28000.9.camel@jtkirshe-mobl>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
 <1428450342-48517-4-git-send-email-catherine.sullivan@intel.com>
 <1428450835.28000.9.camel@jtkirshe-mobl>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9E5F06@ORSMSX102.amr.corp.intel.com>
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
Subject: Re: [Intel-wired-lan] [net-next S3 04/13] i40e: notify VFs of link state

On Tue, 2015-04-07 at 19:45 -0400, Catherine Sullivan wrote:
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Gratuitously notify VFs of link state when they activate their queues.
> In general, this is the last thing that a VF driver will do as it 
> opens its interface, so this is a good time to notify the VF.
> 
> Currently, VF devices assume link is up unless told otherwise, which 
> means that VFs instantiated on a PF with no link will report the wrong 
> state. This change corrects that issue.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Iea53622904ecc681ac3f8938d81c30033ef9a0a6
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 50
> ++++++++++++++--------
>  1 file changed, 31 insertions(+), 19 deletions(-)

Thanks Catherine, I have added your patch to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue

Tested-by: Jim Young <james.m.young@intel.com>

