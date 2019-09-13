From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 13 Sep 2019 06:32:08 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 1/3] i40e: fix xdp handle
 calculations
In-Reply-To: <20190911172435.21042-1-ciara.loftus@intel.com>
References: <20190911172435.21042-1-ciara.loftus@intel.com>
Message-ID: <CAJ+HfNiL3AKHYOv42d5oca7CaYLso18dV=+=_oDpBQsKMk7-fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 11 Sep 2019 at 19:27, Ciara Loftus <ciara.loftus@intel.com> wrote:
>
> Commit 4c5d9a7fa149 ("i40e: fix xdp handle calculations") reintroduced
> the addition of the umem headroom to the xdp handle in the i40e_zca_free,
> i40e_alloc_buffer_slow_zc and i40e_alloc_buffer_zc functions. However,
> the headroom is already added to the handle in the function i40_run_xdp_zc.
> This commit removes the latter addition and fixes the case where the
> headroom is non-zero.
>
> Fixes: 4c5d9a7fa149 ("i40e: fix xdp handle calculations")
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 0373bc6c7e61..5f285ba1f1f9 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -192,7 +192,7 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
>  {
>         struct xdp_umem *umem = rx_ring->xsk_umem;
>         int err, result = I40E_XDP_PASS;
> -       u64 offset = umem->headroom;
> +       u64 offset;

Hi Ciara! Thanks for the patch; Small nit: Please sort local variable
declarations from longest to shortest line.


Cheers,
Bj?rn


>         struct i40e_ring *xdp_ring;
>         struct bpf_prog *xdp_prog;
>         u32 act;
> @@ -203,7 +203,7 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
>          */
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
