From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 24 Feb 2016 11:52:08 +0100 (CET)
Subject: [Intel-wired-lan] [PATCH v8 3/8] time: Remove duplicated code
 in ktime_get_raw_and_real()
In-Reply-To: <1456139726-3327-4-git-send-email-christopher.s.hall@intel.com>
References: <1456139726-3327-1-git-send-email-christopher.s.hall@intel.com>
 <1456139726-3327-4-git-send-email-christopher.s.hall@intel.com>
Message-ID: <alpine.DEB.2.11.1602241151180.3670@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 22 Feb 2016, Christopher S. Hall wrote:

> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -888,6 +888,8 @@ void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
>  	s64 nsec_real;
>  	cycle_t now;
>  
> +	WARN_ON(timekeeping_suspended);

WARN_ON_ONCE please

Other than that: Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
