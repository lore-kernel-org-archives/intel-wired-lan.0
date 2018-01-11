From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 11 Jan 2018 13:55:34 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: use only 3k Rx buffers for
 82599 with build_skb
In-Reply-To: <20180111210602.28743.57326.stgit@localhost6.localdomain6>
References: <20180111210602.28743.57326.stgit@localhost6.localdomain6>
Message-ID: <CAKgT0UctWKCzmcV3HBG-qeGKq=jUFrpXxMMhbVV9JkxAgskTSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jan 11, 2018 at 1:06 PM, Emil Tantilov
<emil.s.tantilov@intel.com> wrote:
> commit 2de6aa3a666e ("ixgbe: Add support for padding packet")
>
> Uses RXDCTL.RLPML to limit the maximum frame size on Rx when using build_skb.
> Unfortunately that register does not work on 82599, so we are forcing 3k
> buffers for that MAC.
>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 722cc31..be2dd56 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -4133,7 +4133,8 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter *adapter,
>                 rxdctl &= ~0x3FFFFF;
>                 rxdctl |=  0x080420;
>  #if (PAGE_SIZE < 8192)
> -       } else {
> +       /* RXDCTL.RLPML does not work on 82599 */
> +       } else if (hw->mac.type != ixgbe_mac_82599EB){
>                 rxdctl &= ~(IXGBE_RXDCTL_RLPMLMASK |
>                             IXGBE_RXDCTL_RLPML_EN);
>

This change doesn't make sense. We aren't enablling RLPML here we are
disabling it. Disabling it should work the same for 82599 just like it
would for any of the other parts in this family.

> @@ -4305,6 +4306,8 @@ static void ixgbe_set_rx_buffer_len(struct ixgbe_adapter *adapter)
>                         continue;
>
>                 set_bit(__IXGBE_RX_BUILD_SKB_ENABLED, &rx_ring->state);
> +               if (hw->mac.type == ixgbe_mac_82599EB)
> +                       set_bit(__IXGBE_RX_3K_BUFFER, &rx_ring->state);
>
>  #if (PAGE_SIZE < 8192)
>                 if (adapter->flags2 & IXGBE_FLAG2_RSC_ENABLED)

I think this bit is redundant. We aren't using the ring RLPML for
this. My understanding as I recall is that we are using the maximum
frame size allowed on the MAC to limit the frame size on 82599. That
is why if we switch to jumbo frames at the end of this call we are
switching to 3K mode already.
