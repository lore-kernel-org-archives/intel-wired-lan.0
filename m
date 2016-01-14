From: John Stultz <john.stultz@linaro.org>
Date: Thu, 14 Jan 2016 14:00:18 -0800
Subject: [Intel-wired-lan] [PATCH v6 4/9] Always Running Timer (ART)
	correlated clocksource
In-Reply-To: <1452687149-11281-5-git-send-email-christopher.s.hall@intel.com>
References: <1452687149-11281-1-git-send-email-christopher.s.hall@intel.com>
 <1452687149-11281-5-git-send-email-christopher.s.hall@intel.com>
Message-ID: <CALAqxLXaRwbmPLcWgxuDxY6MaQw_65nDzP_ELZ=5GeHm8cgEBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 13, 2016 at 4:12 AM, Christopher S. Hall
<christopher.s.hall@intel.com> wrote:
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index c7c4d9c..26dcf63 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -949,10 +949,36 @@ static struct notifier_block time_cpufreq_notifier_block = {
>         .notifier_call  = time_cpufreq_notifier
>  };
>
> +#define ART_CPUID_LEAF (0x15)
> +/* The denominator will never be less that 2 */
> +#define ART_MIN_DENOMINATOR (2)
> +
> +static u32 art_to_tsc_numerator;
> +static u32 art_to_tsc_denominator;

This is declared in a #ifdef CONFIG_CPU_FREQ


> @@ -1071,6 +1097,24 @@ int unsynchronized_tsc(void)
>         return 0;
>  }
>
> +/*
> + * Convert ART to TSC given numerator/denominator found in detect_art()
> + */
> +static u64 convert_art_to_tsc(struct correlated_cs *cs, u64 cycles)
> +{
> +       u64 tmp, res;
> +
> +       res = (cycles / art_to_tsc_denominator) * art_to_tsc_numerator;
> +       tmp = (cycles % art_to_tsc_denominator) * art_to_tsc_numerator;
> +       res += tmp / art_to_tsc_denominator;

Then used outside of that block.

So this won't build if CPU_FREQ is disabled.

But don't bother to fix that, as I've already done so and I've got a
bunch of tweaks I'm making to the code (I figured I'd done enough
nit-picking reviews, and probably should just roll my sleeves up and
take a swing at how I'd prefer the code look - including Richard's
suggestions as well).

I'll send you my revisions here shortly and hopefully you can let me
know if anything goes too far and hopefully do some testing with it.

thanks
-john
