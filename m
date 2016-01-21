From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 20 Jan 2016 23:25:28 -0800
Subject: [Intel-wired-lan] [next, S23,
 06/13 v2] i40e/i40evf: tunnels can be generic
In-Reply-To: <1453329824-9465-1-git-send-email-jesse.brandeburg@intel.com>
References: <1453329824-9465-1-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <CAKgT0Ueubf1ex4C2=avpPHgPVUAnRY4F6JZJyecvXqufHA2Etg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 20, 2016 at 2:43 PM, Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
> Since the i40e driver now supports VxLAN, GRE, and soon
> to be Geneve tunnels, the driver can just note that an skb
> contains a tunneled packet generically, instead of calling
> out VXLAN specifically.  The tunnel set up we do for hardware
> is almost always the same for all tunnel types.
>
> This specifically enables ATR/Flow Director on GRE packets
> which increases performance/scaling.  Without this patch
> GRE RX packets end up on a random RSS assigned queue.
>
> v2: Fix code error found by Alex, by repairing if/else clause
>     for tunnel.
>
> Reported-by: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ie8e205603654910d2f718592cbef8132ae0719e4
>
> ---
> Testing Hints:
> Test tunnelled traffic, specifically also test VxLAN and other tunnel
> types to make sure that ATR counters are still counting when doing
> IPv4/TCP traffic over the tunnel.
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 13 +++++++------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  2 +-
>  4 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 720516b..757bfb6 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2005,7 +2005,10 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
>         if (!(tx_flags & (I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6)))
>                 return;
>
> -       if (!(tx_flags & I40E_TX_FLAGS_UDP_TUNNEL)) {
> +       if ((tx_flags & I40E_TX_FLAGS_TUNNEL)) {

You only need one set of parenthesis here instead of two since you
have flipped the logic.  Otherwise the rest of the patch looks fine.

- Alex
