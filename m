From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 18 Jul 2018 13:49:40 -0700
Subject: [Intel-wired-lan] [PATCH] e1000: ethtool: check on
 netif_running() before calling e1000_up()
In-Reply-To: <20180718191851.31984-1-chenbo@pdx.edu>
References: <20180718191851.31984-1-chenbo@pdx.edu>
Message-ID: <CAKgT0UceBCgtae2NMpu236fYvJOU+0uzQDk5c6rgRXqB+7CcMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jul 18, 2018 at 12:18 PM, Bo Chen <chenbo@pdx.edu> wrote:
> When the device is not up, the call to 'e1000_up()' from the error handling path
> of 'e1000_set_ringparam()' causes a kernel oops with a null-pointer
> dereference. The null-pointer dereference is triggered in function
> 'e1000_alloc_rx_buffers()' at line 'buffer_info = &rx_ring->buffer_info[i]'.
>
> This bug was reported by COD, a tool for testing kernel module binaries I am
> building. This bug was also detected by KFI from Dr. Kai Cong.
>
> This patch fixes the bug by checking on 'netif_running()' before calling
> 'e1000_up()' in 'e1000_set_ringparam()'.
>
> Signed-off-by: Bo Chen <chenbo@pdx.edu>

The change below looks good to me.

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>

> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> index bdb3f8e65ed4..c1e4e94f100f 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> @@ -644,7 +644,8 @@ static int e1000_set_ringparam(struct net_device *netdev,
>  err_alloc_rx:
>         kfree(txdr);
>  err_alloc_tx:
> -       e1000_up(adapter);
> +       if (netif_running(adapter->netdev))
> +               e1000_up(adapter);
>  err_setup:
>         clear_bit(__E1000_RESETTING, &adapter->flags);
>         return err;
> --
> 2.17.0
>
