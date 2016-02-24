From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 24 Feb 2016 11:56:49 +0100 (CET)
Subject: [Intel-wired-lan] [PATCH v8 5/8] time: Add history to cross
 timestamp interface supporting slower devices
In-Reply-To: <1456139726-3327-6-git-send-email-christopher.s.hall@intel.com>
References: <1456139726-3327-1-git-send-email-christopher.s.hall@intel.com>
 <1456139726-3327-6-git-send-email-christopher.s.hall@intel.com>
Message-ID: <alpine.DEB.2.11.1602241155340.3670@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 22 Feb 2016, Christopher S. Hall wrote:
> +{
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	bool interp_forward;
> +	u64 corr_raw, corr_real;
> +	int ret;

Once more:

	struct timekeeper *tk = &tk_core.timekeeper;
	u64 corr_raw, corr_real;
	bool interp_forward;
	int ret;

Is way simpler to parse fast.

>  {
>  	struct timekeeper *tk = &tk_core.timekeeper;
> @@ -929,6 +1046,12 @@ int get_device_system_crosststamp(int (*get_time_fn)
>  	ktime_t base_real;
>  	s64 nsec_raw;
>  	s64 nsec_real;
> +	cycles_t cycles;
> +	cycle_t now;
> +	cycle_t interval_start;
> +	unsigned int clock_was_set_seq;
> +	u8 cs_was_changed_seq;
> +	bool do_interp;

Single lines for same types .....

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
