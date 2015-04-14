From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 14 Apr 2015 05:58:12 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Specify rx hash type wrt rx
	desc RSS type
In-Reply-To: <1428994571-16976-1-git-send-email-fan.du@intel.com>
References: <1428994571-16976-1-git-send-email-fan.du@intel.com>
Message-ID: <1429016292.2638.6.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-04-14 at 14:56 +0800, Fan Du wrote:
> RSS could be leveraged by taking account L4 src/dst ports
> as ingredients, thus ingress skb rx hash type should honor
> such the real configuration.
> 
> Signed-off-by: Fan Du <fan.du@intel.com>
> ---
> Sorry for resending, I forgot to subscribe
> intel-wired-lan at lists.osuosl.org
> as previous mail is being held by list moderator.
> 
> note:
> 1. I checked ixgbe_pci_tbl for 82598, 82599 x540 series,
>    RSS type in adavanced descriptor is all supported.
>    x550 is in trial version, so not checked.
> 
> 2. ixgbevf looks like didn't even set rx hash type
>    I'm not sure why this is left behind. IMHO it should be there.
> 
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   23
> +++++++++++++++++++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    1 +
>  2 files changed, 22 insertions(+), 2 deletions(-)

I have applied your patch to my queue
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150414/7d37f7aa/attachment.asc>
