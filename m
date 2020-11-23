From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 23 Nov 2020 14:49:34 +0100
Subject: [Intel-wired-lan] [PATCH net v1] i40e: allow controlling PTP
 external clock features
In-Reply-To: <20201123134656.14911-1-mateusz.palczewski@intel.com>
References: <20201123134656.14911-1-mateusz.palczewski@intel.com>
Message-ID: <20201123134934.GA6202@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 23, 2020 at 01:46:56PM +0000, Mateusz Palczewski wrote:
> From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> 
> Provide information what functions are supported by PTP pins and allow
> controlling them.
> Implemented in i40e_ptp_verify() and i40e_pps_configure().
> Previously it was not possible to control PTP external clock features.

Why you target that to 'net' tree? it's not a bug fix if you ask me, but a
feature implementation.

> 
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 26f583f..6182d42 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -241,7 +241,15 @@ static void i40_ptp_reset_timing_events(struct i40e_pf *pf)
>  static int i40e_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
>  			   enum ptp_pin_function func, unsigned int chan)

I don't see i40e_ptp_verify in the upstream code. Am I missing something?

It also looks to me that you only make use of 1 out of 4 functions args.
This will produce compiler warnings.

>  {
> -	/* TODO: implement pin checking */
> +	switch (func) {
> +	case PTP_PF_NONE:
> +	case PTP_PF_EXTTS:
> +	case PTP_PF_PEROUT:
> +		break;
> +	case PTP_PF_PHYSYNC:
> +		return -EOPNOTSUPP;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -486,7 +494,11 @@ static int i40e_pps_configure(struct ptp_clock_info *ptp,
>  			      struct ptp_clock_request *rq,
>  			      int on)
>  {

Again, 'rq' is unused. Also it looks like it could return void.

> -	/* TODO: implement PPS events */
> +	struct i40e_pf *pf = container_of(ptp, struct i40e_pf, ptp_caps);
> +
> +	if (!!on)
> +		i40e_ptp_set_1pps_signal_hw(pf);
> +
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
> Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
>  
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
