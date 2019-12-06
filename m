From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 6 Dec 2019 10:03:09 +0100
Subject: [Intel-wired-lan] [PATCH bpf 4/4] net/ixgbe: Fix concurrency
 issues between config flow and XSK
In-Reply-To: <20191205155028.28854-5-maximmi@mellanox.com>
References: <20191205155028.28854-1-maximmi@mellanox.com>
 <20191205155028.28854-5-maximmi@mellanox.com>
Message-ID: <CAJ+HfNhQ7iEoJ2QTAcqJ+z7QK850f4X+59Mj5U62LB9=RgWsmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 5 Dec 2019 at 16:52, Maxim Mikityanskiy <maximmi@mellanox.com> wrote:
>
> Use synchronize_rcu to wait until the XSK wakeup function finishes
> before destroying the resources it uses:
>
> 1. ixgbe_down already calls synchronize_rcu after setting __IXGBE_DOWN.
>
> 2. After switching the XDP program, call synchronize_rcu to let
> ixgbe_xsk_async_xmit exit before the XDP program is freed.
>
> 3. Changing the number of channels brings the interface down.
>
> 4. Disabling UMEM sets __IXGBE_TX_DISABLED before closing hardware
> resources and resetting xsk_umem. Check that bit in ixgbe_xsk_async_xmit
> to avoid using the XDP ring when it's already destroyed. synchronize_rcu
> is called from ixgbe_txrx_ring_disable.
>
> Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 +++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 8 ++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 25c097cd8100..60503318c7e5 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -10273,8 +10273,12 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
>                             adapter->xdp_prog);
>         }
>
> -       if (old_prog)
> +       if (old_prog) {
> +               /* Wait until ndo_xsk_async_xmit completes. */
> +               synchronize_rcu();
> +
>                 bpf_prog_put(old_prog);
> +       }
>
>         /* Kick start the NAPI context if there is an AF_XDP socket open
>          * on that queue id. This so that receiving will start.
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index d6feaacfbf89..b43be9f14105 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -709,10 +709,14 @@ int ixgbe_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
>         if (qid >= adapter->num_xdp_queues)
>                 return -ENXIO;
>
> -       if (!adapter->xdp_ring[qid]->xsk_umem)
> +       ring = adapter->xdp_ring[qid];
> +
> +       if (test_bit(__IXGBE_TX_DISABLED, &ring->state))
> +               return -ENETDOWN;
> +
> +       if (!ring->xsk_umem)

Pretty much same comment as in i40e. The synchronize_rcu() is not
needed, but the additional test is!

>                 return -ENXIO;
>
> -       ring = adapter->xdp_ring[qid];
>         if (!napi_if_scheduled_mark_missed(&ring->q_vector->napi)) {
>                 u64 eics = BIT_ULL(ring->q_vector->v_idx);
>
> --
> 2.20.1
>
