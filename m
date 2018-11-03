From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 3 Nov 2018 01:58:28 +0000
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: allow non-monotonic
 SYSTIM readings
In-Reply-To: <20181017161621.6081-1-mlichvar@redhat.com>
References: <20181017161621.6081-1-mlichvar@redhat.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96599E6F@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Miroslav Lichvar
> Sent: Wednesday, October 17, 2018 9:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Richard Cochran <richardcochran@gmail.com>
> Subject: [Intel-wired-lan] [RFC PATCH] e1000e: allow non-monotonic SYSTIM
> readings
> 
> It seems with some NICs supported by the e1000e driver a SYSTIM reading
> may occasionally be few microseconds before the previous reading and if
> enabled also pass e1000e_sanitize_systim() without reaching the maximum
> number of rereads, even if the function is modified to check three
> consecutive readings (i.e. it doesn't look like a double read error).
> This causes an underflow in the timecounter and the PHC time jumps hours
> ahead.
> 
> This was observed on 82574, I217 and I219. The fastest way to reproduce
> it is to run a program that continuously calls the PTP_SYS_OFFSET ioctl
> on the PHC.
> 
> Modify e1000e_phc_gettime() to use timecounter_cyc2time() instead of
> timecounter_read() in order to allow non-monotonic SYSTIM readings and
> prevent the PHC from jumping.
> 
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ptp.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
