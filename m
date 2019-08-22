From: William Tu <u9012063@gmail.com>
Date: Thu, 22 Aug 2019 09:23:46 -0700
Subject: [Intel-wired-lan] [PATCH net v2] ixgbe: fix double clean of tx
 descriptors with xdp
In-Reply-To: <20190822123037.28068-1-i.maximets@samsung.com>
References: <CGME20190822123045eucas1p125b6e106f0310bdb50e759ef41993a91@eucas1p1.samsung.com>
 <20190822123037.28068-1-i.maximets@samsung.com>
Message-ID: <CALDO+SaMFHB8u3YOsrCM=MNuT=14kmBnst_RNs3qNU0OjPmfGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Aug 22, 2019 at 5:30 AM Ilya Maximets <i.maximets@samsung.com> wrote:
>
> Tx code doesn't clear the descriptors' status after cleaning.
> So, if the budget is larger than number of used elems in a ring, some
> descriptors will be accounted twice and xsk_umem_complete_tx will move
> prod_tail far beyond the prod_head breaking the comletion queue ring.

s/comletion/completion/

>
> Fix that by limiting the number of descriptors to clean by the number
> of used descriptors in the tx ring.
>
> 'ixgbe_clean_xdp_tx_irq()' function refactored to look more like
> 'ixgbe_xsk_clean_tx_ring()' since we don't need most of the
> complications implemented in the regular 'ixgbe_clean_tx_irq()'
> and we're allowed to directly use 'next_to_clean' and 'next_to_use'
> indexes.
>
> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
> ---

Tested-by: William Tu <u9012063@gmail.com>

Instead of measuring tx performance at the tx machine, I measured the TX
performance at the other side (the traffic generating machine).  This time it
is more consistent and showing not much difference with (5.9Mpps) and
without this patch (6.1Mpps).

>
> Version 2:
>   * 'ixgbe_clean_xdp_tx_irq()' refactored to look more like
>     'ixgbe_xsk_clean_tx_ring()'.
>
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 34 ++++++++------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
>

<snip>
