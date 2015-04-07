From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 07 Apr 2015 16:53:16 -0700
Subject: [Intel-wired-lan] [net-next S3 02/13] i40e: Add support to
 program FDir SB rules for VF from PF through ethtool
In-Reply-To: <1428450342-48517-2-git-send-email-catherine.sullivan@intel.com>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
 <1428450342-48517-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1428450796.28000.7.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-04-07 at 19:45 -0400, Catherine Sullivan wrote:
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> With this patch we can now add Flow director Sideband rules for a VF
> from it's PF.
> Here is an example on how it can be done when VF id = 5 and queue = 2
> "ethtool -N ethx flow-type udp4 src-ip x.x.x.x dst-ip y.y.y.y src-port
> p1 dst-port p2 action 2 user-def 5"
> User-def specifies VF id and action specifies queue.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: Ib37d6dff3823a4d85caffde638473891c38c2b89
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 26
> ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150407/4c0eb603/attachment.asc>
