From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 16 Feb 2016 08:52:10 +0100
Subject: [Intel-wired-lan] [PATCH v7 3/8] time: Remove duplicated code
 in ktime_get_raw_and_real()
In-Reply-To: <1455308729-6280-4-git-send-email-christopher.s.hall@intel.com>
References: <1455308729-6280-1-git-send-email-christopher.s.hall@intel.com>
 <1455308729-6280-4-git-send-email-christopher.s.hall@intel.com>
Message-ID: <20160216075210.GA2461@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Feb 12, 2016 at 12:25:24PM -0800, Christopher S. Hall wrote:
> The code in ktime_get_snapshot() is a superset of the code in
> ktime_get_raw_and_real() code. Further, ktime_get_raw_and_real() is
> called only by the PPS code, pps_get_ts(). Consolidate the
> pps_get_ts() code into a single function calling ktime_get_snapshot()
> and eliminate ktime_get_raw_and_real(). A side effect of this is that
> the raw and real results of pps_get_ts() correspond to exactly the
> same clock cycle. Previously these values represented separate reads
> of the system clock.

Nice improvement.

> @@ -888,6 +888,8 @@ void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
>  	s64 nsec_real;
>  	cycle_t now;
>  
> +	WARN_ON(timekeeping_suspended);
...
> -	WARN_ON_ONCE(timekeeping_suspended);

Is this change intentional?

Thanks,
Richard
