From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 24 Feb 2016 11:54:32 +0100 (CET)
Subject: [Intel-wired-lan] [PATCH v8 4/8] time: Add driver cross
 timestamp interface for higher precision time synchronization
In-Reply-To: <1456139726-3327-5-git-send-email-christopher.s.hall@intel.com>
References: <1456139726-3327-1-git-send-email-christopher.s.hall@intel.com>
 <1456139726-3327-5-git-send-email-christopher.s.hall@intel.com>
Message-ID: <alpine.DEB.2.11.1602241153260.3670@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 22 Feb 2016, Christopher S. Hall wrote:
> +int get_device_system_crosststamp(int (*get_time_fn)
> +				  (ktime_t *device_time,
> +				   struct system_counterval_t *sys_counterval,
> +				   void *ctx),
> +				  void *ctx,
> +				  struct system_device_crosststamp *xtstamp)
> +{
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	unsigned long seq;
> +	struct system_counterval_t system_counterval;
> +	ktime_t base_raw;
> +	ktime_t base_real;
> +	s64 nsec_raw;
> +	s64 nsec_real;

Single lines for same and desceding length ordered, which makes it simpler to
parse, please.

Other than that: Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
