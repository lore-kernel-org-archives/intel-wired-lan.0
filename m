From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 14 Apr 2015 06:02:31 -0700
Subject: [Intel-wired-lan] [PATCH net 2/2] igb: Fix NULL assignment to
 incorrect variable in igb_reset_q_vector
In-Reply-To: <1428916512-25559-2-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1428916512-25559-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <1428916512-25559-2-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Message-ID: <1429016551.2638.10.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-04-13 at 18:15 +0900, Toshiaki Makita wrote:
> adapter->tx_ring is set to NULL where rx_ring should be.
> 
> Fixes: 5536d2102a2d ("igb: Combine q_vector and ring allocation into a
> single function")
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Toshiaki, I have applied your patch to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150414/0d351407/attachment.asc>
