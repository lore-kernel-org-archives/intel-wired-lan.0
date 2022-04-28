From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 28 Apr 2022 10:17:03 +0200
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix adding ADq filter to
 TC0
In-Reply-To: <20220428075735.926715-1-jedrzej.jagielski@intel.com>
References: <20220428075735.926715-1-jedrzej.jagielski@intel.com>
Message-ID: <e5f0f6a7-1c10-e445-be34-5ae9c3f5d4df@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jedzej, dear Grzegorz,


Thank you for your patch.

Am 28.04.22 um 09:57 schrieb Jedzej Jagielski:
> From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> 
> Procedure of configure tc flower filters erroneously allow to create

allow*s*

> filters on TC0 where unfiltered packets are also directed by default.
> Issue was caused by insufficient checks of hw_tc parameter specify

?   s/of/if/?
?   *is* caused

> a hardware traffic class to pass matching packets on to.

Please add a blank line between paragraphs.

> Fix checking hw_tc parameter which blocks creation of filters on TC0.
> Previously it was possible to create tc flower filters on TC0.

The last sentence is redundant when reading the whole commit message.

> 
> Fixes: 2f4b411a3d67 ("i40e: Enable cloud filters via tc-flower")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 1e074a6462d4..a0d5d696cdc1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -8537,6 +8537,11 @@ static int i40e_configure_clsflower(struct i40e_vsi *vsi,
>   		return -EOPNOTSUPP;
>   	}
>   
> +	if (!tc) {
> +		dev_err(&pf->pdev->dev, "Unable to add filter because of invalid destination");
> +		return -EINVAL;

How can an invalid destination be passed at all? Should that be WARN_ON 
to debug this?

> +	}
> +
>   	if (test_bit(__I40E_RESET_RECOVERY_PENDING, pf->state) ||
>   	    test_bit(__I40E_RESET_INTR_RECEIVED, pf->state))
>   		return -EBUSY;


Kind regards,

Paul
