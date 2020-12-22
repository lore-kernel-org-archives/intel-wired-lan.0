From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 22 Dec 2020 14:16:46 -0800
Subject: [Intel-wired-lan] [PATCH v5 bpf-next 0/2] introduce
 xdp_init_buff/xdp_prepare_buff
In-Reply-To: <cover.1608670965.git.lorenzo@kernel.org>
References: <cover.1608670965.git.lorenzo@kernel.org>
Message-ID: <CAKgT0Ud66UtBxQ6a-DKbswB6tNSGojhoSi81YEWHtO03qx97XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Dec 22, 2020 at 1:09 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Introduce xdp_init_buff and xdp_prepare_buff utility routines to initialize
> xdp_buff data structure and remove duplicated code in all XDP capable
> drivers.
>
> Changes since v4:
> - fix xdp_init_buff/xdp_prepare_buff (natural order is xdp_init_buff() first
>   and then xdp_prepare_buff())
>
> Changes since v3:
> - use __always_inline instead of inline for xdp_init_buff/xdp_prepare_buff
> - add 'const bool meta_valid' to xdp_prepare_buff signature to avoid
>   overwriting data_meta with xdp_set_data_meta_invalid()
> - introduce removed comment in bnxt driver
>
> Changes since v2:
> - precompute xdp->data as hard_start + headroom and save it in a local
>   variable to reuse it for xdp->data_end and xdp->data_meta in
>   xdp_prepare_buff()
>
> Changes since v1:
> - introduce xdp_prepare_buff utility routine
>
> Lorenzo Bianconi (2):
>   net: xdp: introduce xdp_init_buff utility routine
>   net: xdp: introduce xdp_prepare_buff utility routine
>
> Acked-by: Shay Agroskin <shayagr@amazon.com>
> Acked-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Camelia Groza <camelia.groza@nxp.com>

The changes to the Intel drivers look fine to me, although it might be
nice to have someone from Intel provide a review/ack. I've added
intel-wired-lan to the thread so that someone from Intel can hopefully
review and also ack this.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
