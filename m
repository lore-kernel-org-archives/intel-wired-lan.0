From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 3 Nov 2018 01:06:20 +0000
Subject: [Intel-wired-lan] [PATCH v2 net] igb: shorten maximum PHC
 timecounter update interval
In-Reply-To: <20181026171300.12720-1-mlichvar@redhat.com>
References: <20181026171300.12720-1-mlichvar@redhat.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96599E48@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Miroslav Lichvar
> Sent: Friday, October 26, 2018 10:13 AM
> To: netdev at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org; Richard Cochran
> <richardcochran@gmail.com>; Thomas Gleixner <tglx@linutronix.de>
> Subject: [Intel-wired-lan] [PATCH v2 net] igb: shorten maximum PHC
> timecounter update interval
> 
> The timecounter needs to be updated at least once per ~550 seconds in
> order to avoid a 40-bit SYSTIM timestamp to be misinterpreted as an old
> timestamp.
> 
> Since commit 500462a9de65 ("timers: Switch to a non-cascading wheel"),
> scheduling of delayed work seems to be less accurate and a requested
> delay of 540 seconds may actually be longer than 550 seconds. Also, the
> PHC may be adjusted to run up to 6% faster than real time and the system
> clock up to 10% slower. Shorten the delay to 360 seconds to be sure the
> timecounter is updated in time.
> 
> This fixes an issue with HW timestamps on 82580/I350/I354 being off by
> ~1100 seconds for few seconds every ~9 minutes.
> 
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
