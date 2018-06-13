From: John Fastabend <john.fastabend@gmail.com>
Date: Wed, 13 Jun 2018 09:26:12 -0700
Subject: [Intel-wired-lan] [PATCH net/jkirsher] bpf, xdp,
 i40e: fix i40e_build_skb skb reserve and truesize
In-Reply-To: <20180613090436.4266-1-daniel@iogearbox.net>
References: <20180613090436.4266-1-daniel@iogearbox.net>
Message-ID: <d56adbb7-12df-c197-1976-3eb161af8484@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 06/13/2018 02:04 AM, Daniel Borkmann wrote:
> Using skb_reserve(skb, I40E_SKB_PAD + (xdp->data - xdp->data_hard_start))
> is clearly wrong since I40E_SKB_PAD already points to the offset where
> the original xdp->data was sitting since xdp->data_hard_start is defined
> as xdp->data - i40e_rx_offset(rx_ring) where latter offsets to I40E_SKB_PAD
> when build skb is used.
> 
> However, also before cc5b114dcf98 ("bpf, i40e: add meta data support")
> this seems broken since bpf_xdp_adjust_head() helper could have been used
> to alter headroom and enlarge / shrink the frame and with that the assumption
> that the xdp->data remains unchanged does not hold and would push a bogus
> packet to upper stack.
> 
> ixgbe got this right in 924708081629 ("ixgbe: add XDP support for pass and
> drop actions"). In any case, fix it by removing the I40E_SKB_PAD from both
> skb_reserve() and truesize calculation.
> 
> Fixes: cc5b114dcf98 ("bpf, i40e: add meta data support")
> Fixes: 0c8493d90b6b ("i40e: add XDP support for pass and drop actions")
> Reported-by: Keith Busch <keith.busch@linux.intel.com>
> Reported-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Bj?rn T?pel <bjorn.topel@intel.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

Thanks! I missed this during review.

Acked-by: John Fastabend <john.fastabend@gmail.com>
