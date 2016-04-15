From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 15 Apr 2016 21:37:25 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: don't modify SYSTIM registers
 during SIOCSHWTSTAMP ioctl
In-Reply-To: <20160415201602.GA28093@hobbes.lan20.walshnetwork.net>
References: <1460676564-30452-1-git-send-email-jacob.e.keller@intel.com>
 <20160415201602.GA28093@hobbes.lan20.walshnetwork.net>
Message-ID: <1460756245.13811.6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-04-15 at 16:16 -0400, Brian Walsh wrote:
> On Thu, Apr 14, 2016 at 04:29:24PM -0700, Jacob Keller wrote:
> > 
> > The e1000e_config_hwtstamp function was incorrectly resetting the
> > SYSTIM
> > registers every time the ioctl was being run. If you happened to be
> > running ptp4l and lost the PTP connect (removing cable, or blocking
> > the
> > UDP traffic for example), then ptp4l will eventually perform a
> > restart
> > which involves re-requesting timestamp settings. In e1000e this has
> > the
> > unfortunate and incorrect result of resetting SYSTIME to the kernel
> > time. Since kernel time is usually in UTC, and PTP time is in TAI,
> > this
> > results in the leap second being re-applied.
> > 
> > Fix this by extracting the SYSTIME reset out into its own function,
> > e1000e_ptp_reset, which we call during reset to restore the
> > hardware
> > registers. This function will (a) restart the timecounter based on
> > the
> > new system time, (b) restore the previous PPB setting, and (c)
> > restore
> > the previous hwtstamp settings.
> > 
> > In order to perform (b), I had to modify the adjfreq ptp function
> > pointer to store the old delta each time it is called. This also
> > has the
> > side effect of restoring the correct base timinca register
> > correctly.
> > The driver does not need to explicitly zero the ptp_delta variable
> > since
> > the entire adapter structure comes zero-initialized.
> > 
> > Reported-by: Brian Walsh <brian@walsh.ws>
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> My last attempt was on an older 4.1 kernel. I am seeing the same
> failure
> on the latest 4.6 rc3.

I've sent a v2 that should address that, I didn't realize e1000e_reset
was called prior to e1000e_ptp_init.

Thanks,
Jake
