From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 07 Dec 2016 09:30:04 -0800
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: fcoe: return value of
 skb_linearize should be handled
In-Reply-To: <1481096614-25295-1-git-send-email-zhouzhouyi@gmail.com>
References: <1481096614-25295-1-git-send-email-zhouzhouyi@gmail.com>
Message-ID: <1481131804.2404.10.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-12-07 at 15:43 +0800, Zhouyi Zhou wrote:
> Signed-off-by: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
> Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>?
> Reviewed-by: Eric Dumazet <eric.dumazet@gmail.com>
> ---
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 6 +++++-
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 +--
> ?2 files changed, 6 insertions(+), 3 deletions(-)

Did Cong, Yuval and Eric give their Reviewed-by offline?  I see they made
comments and suggests, but never saw them actually give you their Reviewed-
by.  You cannot automatically add their Reviewed-by, Signed-off-by, etc
just because someone provides feedback on your patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161207/4b640d01/attachment.asc>
