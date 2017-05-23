From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 23 May 2017 09:51:19 -0700
Subject: [Intel-wired-lan] [PATCH v6 1/2] i40e: add XDP support for pass
	and drop actions
In-Reply-To: <20170523073317.11900-2-bjorn.topel@gmail.com>
References: <20170523073317.11900-1-bjorn.topel@gmail.com>
 <20170523073317.11900-2-bjorn.topel@gmail.com>
Message-ID: <CAKgT0UdAP=rE4YwxD0+uXbY2Z+DsNySeYubkxxM_1VN-rKQKXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 23, 2017 at 12:33 AM, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
>
> This commit adds basic XDP support for i40e derived NICs. All XDP
> actions will end up in XDP_DROP.
>
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>

So I only really see one issue which I pointed out earlier. Basically
the i40e_change_mtu call can't really be dependent on vsi->rx_buf_len
since rx_buf_len is changed as a result of changing the MTU.

> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |   7 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  75 ++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 130 +++++++++++++++++++++-------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |   1 +
>  4 files changed, 182 insertions(+), 31 deletions(-)
>

[...]

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 8d1d3b859af7..c8b1db0ebb9e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -27,6 +27,7 @@
>  #include <linux/etherdevice.h>
>  #include <linux/of_net.h>
>  #include <linux/pci.h>
> +#include <linux/bpf.h>
>
>  /* Local includes */
>  #include "i40e.h"
> @@ -2408,6 +2409,13 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
>         struct i40e_vsi *vsi = np->vsi;
>         struct i40e_pf *pf = vsi->back;
>
> +       if (i40e_enabled_xdp_vsi(vsi)) {
> +               int frame_size = new_mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
> +
> +               if (frame_size > vsi->rx_buf_len)
> +                       return -EINVAL;
> +       }
> +

So this code suffers from the same issue that John's ixgbe code did.
You might be better off implementing something like we did with
i40e_vsi_configure_rx. Basically the upper limit can be either 3K or
2K if the page size greater than 4K or the LEGACY_RX flag is set. You
might look at adding a check here for that instead of just comparing
it to vsi->rx_buf_len since rx_buf_len can change depending on the MTU
size.

- Alex
