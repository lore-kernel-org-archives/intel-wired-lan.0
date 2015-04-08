From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 07 Apr 2015 17:02:19 -0700
Subject: [Intel-wired-lan] [net-next S3 12/13] i40e: Use new 40G speeds
In-Reply-To: <1428450342-48517-12-git-send-email-catherine.sullivan@intel.com>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
 <1428450342-48517-12-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1428451339.1860.6.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-04-07 at 19:45 -0400, Catherine Sullivan wrote:
> From: Greg Rose <gregory.v.rose@intel.com>
> 
> The kernel has added SPEED_40000 for ethtool.
> Go ahead and use the new #define.
> 
> Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
> Change-ID: Ic7e16e5c9e91085afe539f11ee1b7668adc4d0ef
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150407/43ff9ea2/attachment.asc>
