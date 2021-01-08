From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Jan 2021 10:25:42 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1 1/2] net: core: count
 drops from GRO
In-Reply-To: <20210106215539.2103688-2-jesse.brandeburg@intel.com>
References: <20210106215539.2103688-1-jesse.brandeburg@intel.com>
 <20210106215539.2103688-2-jesse.brandeburg@intel.com>
Message-ID: <CANn89iLcRrmXW_MGjuMMnNxWS+kaEnY=Y79hCPuiwiDd_G9=EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 6, 2021 at 10:56 PM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> When drivers call the various receive upcalls to receive an skb
> to the stack, sometimes that stack can drop the packet. The good
> news is that the return code is given to all the drivers of
> NET_RX_DROP or GRO_DROP. The bad news is that no drivers except
> the one "ice" driver that I changed, check the stat and increment
> the dropped count. This is currently leading to packets that
> arrive at the edge interface and are fully handled by the driver
> and then mysteriously disappear.
>
> Rather than fix all drivers to increment the drop stat when
> handling the return code, emulate the already existing statistic
> update for NET_RX_DROP events for the two GRO_DROP locations, and
> increment the dev->rx_dropped associated with the skb.
>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/core/dev.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 8fa739259041..ef34043a9550 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6071,6 +6071,7 @@ static gro_result_t napi_skb_finish(struct napi_struct *napi,
>                 break;
>
>         case GRO_DROP:
> +               atomic_long_inc(&skb->dev->rx_dropped);
>                 kfree_skb(skb);
>                 break;
>
> @@ -6159,6 +6160,7 @@ static gro_result_t napi_frags_finish(struct napi_struct *napi,
>                 break;
>
>         case GRO_DROP:
> +               atomic_long_inc(&skb->dev->rx_dropped);
>                 napi_reuse_skb(napi, skb);
>                 break;
>


This is not needed. I think we should clean up ice instead.

Drivers are supposed to have allocated the skb (using
napi_get_frags()) before calling napi_gro_frags()

Only napi_gro_frags() would return GRO_DROP, but we supposedly could
crash at that point, since a driver is clearly buggy.

We probably can remove GRO_DROP completely, assuming lazy drivers are fixed.

diff --git a/net/core/dev.c b/net/core/dev.c
index 8fa739259041aaa03585b5a7b8ebce862f4b7d1d..c9460c9597f1de51957fdcfc7a64ca45bce5af7c
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6223,9 +6223,6 @@ gro_result_t napi_gro_frags(struct napi_struct *napi)
        gro_result_t ret;
        struct sk_buff *skb = napi_frags_skb(napi);

-       if (!skb)
-               return GRO_DROP;
-
        trace_napi_gro_frags_entry(skb);

        ret = napi_frags_finish(napi, skb, dev_gro_receive(napi, skb));
