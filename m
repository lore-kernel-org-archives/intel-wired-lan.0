From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 07 Apr 2015 16:54:22 -0700
Subject: [Intel-wired-lan] [net-next S3 05/13] i40e: move VF
 notification routines up
In-Reply-To: <1428450342-48517-5-git-send-email-catherine.sullivan@intel.com>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
 <1428450342-48517-5-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1428450862.28000.10.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

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
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150407/8f15212b/attachment-0001.asc>
