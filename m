From: Jacob Pan <jacob.jun.pan@intel.com>
Date: Wed, 18 Nov 2015 15:53:53 -0800
Subject: [Intel-wired-lan] [PATCH v4 2/4] Always running timer
	correlated clocksource
In-Reply-To: <1444675522-4198-3-git-send-email-christopher.s.hall@intel.com>
References: <1444675522-4198-1-git-send-email-christopher.s.hall@intel.com>
 <1444675522-4198-3-git-send-email-christopher.s.hall@intel.com>
Message-ID: <20151118155353.4b37a06f@yairi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 12 Oct 2015 11:45:20 -0700
"Hall, Christopher S" <christopher.s.hall@intel.com> wrote:
took a while to read the code, i have a few comments/questions
>
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index c3f7602..c3f098c 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -820,7 +820,7 @@ int recalibrate_cpu_khz(void)
>  #ifndef CONFIG_SMP
This code is used by old p4/k7 clock modulation driver, why do we care?

>         unsigned long cpu_khz_old = cpu_khz;
> 
> -       if (cpu_has_tsc) {
> +       if (boot_cpu_has(X86_FEATURE_ART)) {
>                 tsc_khz = x86_platform.calibrate_tsc();
>                 cpu_khz = tsc_khz;
>                 cpu_data(0).loops_per_jiffy =


> 
> +/*
> + * Convert ART to TSC given numerator/denominator found in
> detect_art()
> + */
> +static u64 convert_art_to_tsc(struct correlated_cs *cs, u64 cycles)
> +{
> +       u64 tmp, res;
> +
> +       res = (cycles / art_to_tsc_denominator) *
> art_to_tsc_numerator;
> +       tmp = (cycles % art_to_tsc_denominator) *
> art_to_tsc_numerator;
> +       res += tmp / art_to_tsc_denominator;
> +
iirc there are some issues with 32bit, better use div64_u64()
