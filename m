From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 20 Oct 2018 01:13:36 +0000
Subject: [Intel-wired-lan] [PATCH] igb: shorten maximum PHC timecounter
 update interval
In-Reply-To: <20181012111339.1361-1-mlichvar@redhat.com>
References: <20181012111339.1361-1-mlichvar@redhat.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9657EA0E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Miroslav Lichvar
> Sent: Friday, October 12, 2018 4:14 AM
> To: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>; Richard Cochran
> <richardcochran@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] igb: shorten maximum PHC timecounter
> update interval
> 
> The timecounter needs to be updated at least once per ~550 seconds in
> order to avoid a 40-bit SYSTIM timestamp to be misinterpreted as an old
> timestamp.
> 
> Since commit 500462a9d ("timers: Switch to a non-cascading wheel"),
> scheduling of delayed work seems to be less accurate and a requested
> delay of 540 seconds may actually be longer than 550 seconds. Shorten
> the delay to 480 seconds to be sure the timecounter is updated in time.
> 
> This fixes an issue with HW timestamps on 82580/I350/I354 being off by
> ~1100 seconds for few seconds every ~9 minutes.
> 
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
