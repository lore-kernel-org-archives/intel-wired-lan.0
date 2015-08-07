From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 06 Aug 2015 23:07:23 -0700
Subject: [Intel-wired-lan] [PATCH next 3/4] ixgbe: Enable TSO for
	stacked vlan
In-Reply-To: <1438851452-13143-3-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1438851452-13143-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <1438851452-13143-3-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Message-ID: <1438927643.2990.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-08-06 at 17:57 +0900, Toshiaki Makita wrote:
> Setting ndo_features_check to passthru_features_check allows the
> driver
> to skip the check for multiple tagged TSO packets and enables stacked
> vlan TSO.
> Tested with 82599ES.
> 
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 1 +
>  1 file changed, 1 insertion(+)

NACK!

This does not apply cleanly AND the ixgbe code already has
a .ndo_features_check which is assigned to our ixgbe_features_check().

PLEASE pull my tree to ensure you are using the latest code when
generating patches.

Dropping this patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150806/7448b70d/attachment.asc>
