From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 13 Oct 2015 07:26:13 +0200
Subject: [Intel-wired-lan] [PATCH v4 1/4] Produce system time from
	correlated clocksource
In-Reply-To: <1444675522-4198-2-git-send-email-christopher.s.hall@intel.com>
References: <1444675522-4198-1-git-send-email-christopher.s.hall@intel.com>
 <1444675522-4198-2-git-send-email-christopher.s.hall@intel.com>
Message-ID: <20151013052613.GB2437@netboy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 12, 2015 at 11:45:19AM -0700, Christopher S. Hall wrote:
> +int get_correlated_timestamp(struct correlated_ts *crt,
> +			     struct correlated_cs *crs)
> +{
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	unsigned long seq;
> +	cycles_t cycles, cycles_now, cycles_last;
> +	ktime_t base;
> +	s64 nsecs;
> +	int ret;
> +
> +	do {
> +		seq = read_seqcount_begin(&tk_core.seq);
> +		/*
> +		 * Verify that the correlated clocksoure is related to
> +		 * the currently installed timekeeper clocksoure
> +		 */
> +		if (tk->tkr_mono.clock != crs->related_cs)
> +			return -ENODEV;
> +
> +		/*
> +		 * Get a timestamp from the device if get_ts is non-NULL
> +		 */
> +		if( crt->get_ts ) {

CodingStyle.

> +			ret = crt->get_ts(crt);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		/*
> +		 * Convert the timestamp to timekeeper clock cycles
> +		 */
> +		cycles = crs->convert(crs, crt->system_ts);
> +
> +		/*
> +		 * If we have get_ts is valid, we know the cycles value
> +		 * value is up to date and we can just do the conversion
> +		 */
> +		if( crt->get_ts )

Ditto.

> +			goto do_convert;
> +

Thanks,
Richard
