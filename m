From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 13 Sep 2019 06:33:01 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 2/3] ixgbe: fix xdp handle
 calculations
In-Reply-To: <20190911172435.21042-2-ciara.loftus@intel.com>
References: <20190911172435.21042-1-ciara.loftus@intel.com>
 <20190911172435.21042-2-ciara.loftus@intel.com>
Message-ID: <CAJ+HfNhuhyjRXoTXLhR3CbzhvYZZNZXYcbPxYAokL7HuDT6nAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 11 Sep 2019 at 19:27, Ciara Loftus <ciara.loftus@intel.com> wrote:
>
> Commit 7cbbf9f1fa23 ("ixgbe: fix xdp handle calculations") reintroduced
> the addition of the umem headroom to the xdp handle in the ixgbe_zca_free,
> ixgbe_alloc_buffer_slow_zc and ixgbe_alloc_buffer_zc functions. However,
> the headroom is already added to the handle in the function
> ixgbe_run_xdp_zc. This commit removes the latter addition and fixes the
> case where the headroom is non-zero.
>
> Fixes: 7cbbf9f1fa23 ("ixgbe: fix xdp handle calculations")
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index ad802a8909e0..5ed8b5a257cf 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -145,7 +145,7 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
>  {
>         struct xdp_umem *umem = rx_ring->xsk_umem;
>         int err, result = IXGBE_XDP_PASS;
> -       u64 offset = umem->headroom;
> +       u64 offset;

...and same comment as from the i40e patch: Reverse xmas tree, please.


Cheers,
Bj?rn

>         struct bpf_prog *xdp_prog;
>         struct xdp_frame *xdpf;
>         u32 act;
> @@ -153,7 +153,7 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
>         rcu_read_lock();
>         xdp_prog = READ_ONCE(rx_ring->xdp_prog);
>         act = bpf_prog_run_xdp(xdp_prog, xdp);
> -       offset += xdp->data - xdp->data_hard_start;
> +       offset = xdp->data - xdp->data_hard_start;
>
>         xdp->handle = xsk_umem_adjust_offset(umem, xdp->handle, offset);
>
> --
> 2.17.1
>
