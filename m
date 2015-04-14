From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 14 Apr 2015 06:01:42 -0700
Subject: [Intel-wired-lan] [PATCH net 1/2] igb: Fix oops on changing
	number of rings
In-Reply-To: <1428916512-25559-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1428916512-25559-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Message-ID: <1429016502.2638.9.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-04-13 at 18:15 +0900, Toshiaki Makita wrote:
> When changing the number of rings by ethtool -L, q_vectors are reused,
> which causes oops because of uninitialized pointers.
> 
> - When an rx is reused as a tx, q_vector->rx.ring is not set to NULL,
> which
>   misleads igb_poll() to determine that it has an rx ring although it
>   actually points to the tx ring.
> - When a tx is reused as an rx, q_vector->rx.ring->skb
>   (q_vector->ring[0].skb) has a value that was used as tx_stats
> before.
> 
> Fix these problems by zeroing it out on reuseing it.
> 
> Fixes: 02ef6e1d0b00 ("igb: Fix queue allocation method to accommodate
> changing during runtime")
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
>  1 file changed, 2 insertions(+)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150414/fcb21064/attachment.asc>
