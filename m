From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 24 Oct 2017 09:19:58 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: add array bounds check
In-Reply-To: <1508772111-4527-1-git-send-email-paul.greenwalt@intel.com>
References: <1508772111-4527-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <CAKgT0UczobrvbRFoRDxa+B-PW733uJ=kJfd0YoK83=cC9RAXEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 23, 2017 at 8:21 AM, Paul Greenwalt
<paul.greenwalt@intel.com> wrote:
> Add bounds check for index fcoe_i of rx_ring array.
>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> index a23c2b5..5772fe2 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> @@ -698,6 +698,8 @@ void ixgbe_configure_fcoe(struct ixgbe_adapter *adapter)
>                 }
>
>                 fcoe_i = fcoe->offset + (i % fcoe->indices);
> +               if (fcoe_i >= MAX_RX_QUEUES)
> +                       fcoe_i = MAX_RX_QUEUES - 1;

Instead of using MAX_RX_QUEUES why use fcoe->limit? If I am not
mistake the upper limit is either 8 or 32 for the FCoE redirection
table anyway so odds are you can't even use 64 queues if you wanted
to. From what I can tell the only advantage of the approach you are
using now is that you don't potentially zero out the value when it
gets hit with the mask below.

>                 fcoe_i &= IXGBE_FCRETA_ENTRY_MASK;
>                 fcoe_q = adapter->rx_ring[fcoe_i]->reg_idx;
>                 fcoe_q |= fcoe_q_h;
> --
> 2.7.4
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
