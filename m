From: Brian Walsh <brian@walsh.ws>
Date: Tue, 19 Apr 2016 02:52:57 -0400
Subject: [Intel-wired-lan] [PATCH v3] e1000e: don't modify SYSTIM
 registers during SIOCSHWTSTAMP ioctl
In-Reply-To: <20160415224127.4172-1-jacob.e.keller@intel.com>
References: <20160415224127.4172-1-jacob.e.keller@intel.com>
Message-ID: <20160419065257.GA4143@hobbes.lan20.walshnetwork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Apr 15, 2016 at 03:41:27PM -0700, Jacob Keller wrote:
> The e1000e_config_hwtstamp function was incorrectly resetting the SYSTIM
> registers every time the ioctl was being run. If you happened to be
> running ptp4l and lost the PTP connect (removing cable, or blocking the
> UDP traffic for example), then ptp4l will eventually perform a restart
> which involves re-requesting timestamp settings. In e1000e this has the
> unfortunate and incorrect result of resetting SYSTIME to the kernel
> time. Since kernel time is usually in UTC, and PTP time is in TAI, this
> results in the leap second being re-applied.
> 
> Fix this by extracting the SYSTIME reset out into its own function,
> e1000e_ptp_reset, which we call during reset to restore the hardware
> registers. This function will (a) restart the timecounter based on the
> new system time, (b) restore the previous PPB setting, and (c) restore
> the previous hwtstamp settings.
> 
> In order to perform (b), I had to modify the adjfreq ptp function
> pointer to store the old delta each time it is called. This also has the
> side effect of restoring the correct base timinca register correctly.
> The driver does not need to explicitly zero the ptp_delta variable since
> the entire adapter structure comes zero-initialized.
> 
> Reported-by: Brian Walsh <brian@walsh.ws>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> 
> 3rd time's a charm? This time I verified it should compile and run now,
> without crashes, and without compilation errors.
> 
> Notes:
>     This patch conflicts with Brian's "e1000e fix ptp time reset on newtork
>     interruption", and that patch MUST be removed from the queue before applying
>     this one.
>     
>     - Changes since v1
>     * move e1000e_init_ptp prior to reset so that PTP clock is created first
>     * handle NULL ptp_clock_info gracefully.
>     
>     - Changes since v2
>     * fix stupid compilation error
>     * fix stupid null pointer check (who WROTE THIS CODE?!?!??!! ;)
> 
>  drivers/net/ethernet/intel/e1000e/e1000.h  |  1 +
>  drivers/net/ethernet/intel/e1000e/netdev.c | 65 ++++++++++++++++++++++--------
>  drivers/net/ethernet/intel/e1000e/ptp.c    |  2 +
>  3 files changed, 52 insertions(+), 16 deletions(-)
> 

Fixes the leapsecond time jump I was trying to fix.

Tested-by: Brian Walsh <brian@walsh.ws>
