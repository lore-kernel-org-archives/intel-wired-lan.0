From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 26 Mar 2015 21:15:39 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 2/2] ixgbe: Add the
 appropriate ethtool ops to query RSS indirection table and key
In-Reply-To: <1427409886-20261-3-git-send-email-vladz@cloudius-systems.com>
References: <1427409886-20261-1-git-send-email-vladz@cloudius-systems.com>
 <1427409886-20261-3-git-send-email-vladz@cloudius-systems.com>
Message-ID: <1427429739.2497.43.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-03-27 at 00:44 +0200, Vlad Zolotarov wrote:
> Added get_rxfh_indir_size, get_rxfh_key_size and get_rxfh ethtool_ops
> callbacks
> implementations.
> 
> This enables the ethtool's "-x" and "--show-rxfh[-indir]" options.
> 
> Signed-off-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 42
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  2 +-
>  3 files changed, 44 insertions(+), 1 deletion(-)

I have added this to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150326/a467ceb2/attachment-0001.asc>
