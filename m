From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 17 Jun 2015 05:23:42 -0700
Subject: [Intel-wired-lan] [PATCH v6 1/3] if_link: Add control trust VF
In-Reply-To: <7F861DC0615E0C47A872E6F3C5FCDDBD05EE188B@BPXM14GP.gisp.nec.co.jp>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05EE188B@BPXM14GP.gisp.nec.co.jp>
Message-ID: <1434543822.3530.63.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-06-17 at 11:41 +0000, Hiroshi Shimamoto wrote:
> From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> 
> Add netlink directives and ndo entry to trust VF user.
> 
> This controls the special permission of VF user.
> The administrator will dedicatedly trust VF user to use some features
> which impacts security and/or performance.
> 
> The administrator never turn it on unless VF user is fully trusted.
> 
> Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> Reviewed-by: Hayato Momma <h-momma@ce.jp.nec.com>
> CC: Choi, Sy Jong <sy.jong.choi@intel.com>
> ---
> include/linux/if_link.h      |  1 +
>  include/linux/netdevice.h    |  3 +++
>  include/uapi/linux/if_link.h |  6 ++++++
>  net/core/rtnetlink.c         | 19 +++++++++++++++++--
>  4 files changed, 27 insertions(+), 2 deletions(-)

Thanks Hiroshi, if there are no comments for change, I will get this
series applied to my next-queue for testing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150617/e5abb4fb/attachment.asc>
