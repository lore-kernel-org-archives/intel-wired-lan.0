From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 24 Feb 2016 12:00:31 +0100 (CET)
Subject: [Intel-wired-lan] [PATCH v8 6/8] x86: tsc: Always Running Timer
 (ART) correlated clocksource
In-Reply-To: <1456139726-3327-7-git-send-email-christopher.s.hall@intel.com>
References: <1456139726-3327-1-git-send-email-christopher.s.hall@intel.com>
 <1456139726-3327-7-git-send-email-christopher.s.hall@intel.com>
Message-ID: <alpine.DEB.2.11.1602241200020.3670@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 22 Feb 2016, Christopher S. Hall wrote:

> On modern Intel systems TSC is derived from the new Always Running Timer
> (ART). ART can be captured simultaneous to the capture of
> audio and network device clocks, allowing a correlation between timebases
> to be constructed. Upon capture, the driver converts the captured ART
> value to the appropriate system clock using the correlated clocksource
> mechanism.
> 
> On systems that support ART a new CPUID leaf (0x15) returns parameters
> ?m? and ?n? such that:
> 
> TSC_value = (ART_value * m) / n + k [n >= 2]
> 
> [k is an offset that can adjusted by a privileged agent. The
> IA32_TSC_ADJUST MSR is an example of an interface to adjust k.
> See 17.14.4 of the Intel SDM for more details]
> 
> Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
> [jstultz: Tweaked to fix build issue, also reworked math for
> 64bit division on 32bit systems]
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
