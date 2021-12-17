From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 17 Dec 2021 13:10:23 -0800
Subject: [Intel-wired-lan] [PATCH] igc: updated TX timestamp support for
 non-MSI-X platforms
In-Reply-To: <20211217205209.723782-1-james.mclaughlin@qsc.com>
References: <20211217205209.723782-1-james.mclaughlin@qsc.com>
Message-ID: <87mtkzym2o.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi James,

James McLaughlin <james.mclaughlin@qsc.com> writes:

> Time synchronization was not properly enabled on non-MSI-X platforms.
>
> Signed-off-by: James McLaughlin <james.mclaughlin@qsc.com>
> Reviewed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

A couple of things that I should have pointed out earlier.

The subject line would be better if it was: "PATCH net" (to indicate
that the patch should be considered for the "net" tree, not "net-next").

Also, it could be made clearer that it's a fix, so the full subject line
could be like this:

      "[PATCH net] igc: Fix TX timestamp support for non-MSI platforms"

Adding a "fixes" tag to the commit message would help, something like this:

       Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")

> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 8e448288ee26..d28a80a00953 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -5467,6 +5467,9 @@ static irqreturn_t igc_intr_msi(int irq, void *data)
>  			mod_timer(&adapter->watchdog_timer, jiffies + 1);
>  	}
>  
> +	if (icr & IGC_ICR_TS)
> +		igc_tsync_interrupt(adapter);
> +
>  	napi_schedule(&q_vector->napi);
>  
>  	return IRQ_HANDLED;
> @@ -5510,6 +5513,9 @@ static irqreturn_t igc_intr(int irq, void *data)
>  			mod_timer(&adapter->watchdog_timer, jiffies + 1);
>  	}
>  
> +	if (icr & IGC_ICR_TS)
> +		igc_tsync_interrupt(adapter);
> +
>  	napi_schedule(&q_vector->napi);
>  
>  	return IRQ_HANDLED;
> -- 
> 2.25.1
>

Cheers,
-- 
Vinicius
