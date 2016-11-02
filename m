From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 2 Nov 2016 14:44:32 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e: free IRQ when the link is up
	or down
In-Reply-To: <1478120896-5907-1-git-send-email-tbaicar@codeaurora.org>
References: <1478120896-5907-1-git-send-email-tbaicar@codeaurora.org>
Message-ID: <CAKgT0UfQbKwyjP9e1MnR90S7re2ybxnTyBL5QajF-7kGNraS1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Nov 2, 2016 at 2:08 PM, Tyler Baicar <tbaicar@codeaurora.org> wrote:
> Move IRQ free code so that it will happen regardless of the
> link state. Currently the e1000e driver only releases its IRQ
> if the link is up. This is not sufficient because it is
> possible for a link to go down without releasing the IRQ. A
> secondary bus reset can cause this case to happen.
>
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 7017281..36cfcb0 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -4679,12 +4679,13 @@ int e1000e_close(struct net_device *netdev)
>
>         if (!test_bit(__E1000_DOWN, &adapter->state)) {
>                 e1000e_down(adapter, true);
> -               e1000_free_irq(adapter);
>
>                 /* Link status message must follow this format */
>                 pr_info("%s NIC Link is Down\n", adapter->netdev->name);
>         }
>
> +       e1000_free_irq(adapter);
> +
>         napi_disable(&adapter->napi);
>
>         e1000e_free_tx_resources(adapter->tx_ring);


The __E1000_DOWN bit has nothing to do with link state.  It is
basically there to make sure that we don't call e1000e_down multiple
times on the same interface.

With that being said the change itself is probably okay since from
what I can tell e1000e_open doesn't do a check on the __E1000_DOWN bit
before requesting the interrupt.  However, you may want to incorporate
pieces of this change (http://patchwork.ozlabs.org/patch/690139/) that
went in for ixgbevf.  Basically you need to keep the suspend code from
racing with the close call.  The easiest way to do that is to wrap the
bits that are also in e1000e_close in the rtnl_lock like we did for
ixgbevf, and then you would need to check for netif_device_present
before calling e1000_free_irq() just so you didn't call it twice.

- Alex
