From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 20 Apr 2016 17:56:32 +0000
Subject: [Intel-wired-lan] [PATCH v3] e1000e: don't modify SYSTIM
 registers during SIOCSHWTSTAMP ioctl
In-Reply-To: <20160415224127.4172-1-jacob.e.keller@intel.com>
References: <20160415224127.4172-1-jacob.e.keller@intel.com>
Message-ID: <1461174992.1546.22.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-04-15 at 15:41 -0700, Jacob Keller wrote:
> The e1000e_config_hwtstamp function was incorrectly resetting the
> SYSTIM
> registers every time the ioctl was being run. If you happened to be
> running ptp4l and lost the PTP connect (removing cable, or blocking
> the
> UDP traffic for example), then ptp4l will eventually perform a
> restart
> which involves re-requesting timestamp settings. In e1000e this has
> the
> unfortunate and incorrect result of resetting SYSTIME to the kernel
> time. Since kernel time is usually in UTC, and PTP time is in TAI,
> this
> results in the leap second being re-applied.
> 
> Fix this by extracting the SYSTIME reset out into its own function,
> e1000e_ptp_reset, which we call during reset to restore the hardware
> registers. This function will (a) restart the timecounter based on
> the
> new system time, (b) restore the previous PPB setting, and (c)
> restore
> the previous hwtstamp settings.
> 
> In order to perform (b), I had to modify the adjfreq ptp function
> pointer to store the old delta each time it is called. This also has
> the
> side effect of restoring the correct base timinca register correctly.
> The driver does not need to explicitly zero the ptp_delta variable
> since
> the entire adapter structure comes zero-initialized.
> 
> Reported-by: Brian Walsh <brian@walsh.ws>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> 


Unfortunately, Todd Fujinaka found an issue with this patch on e1000e
devices which do not support timestamping. I forgot to add a check to
the HW_TIMESTAMP flag. I cleaned up a few other minor things as well in
v4. Sorry (again) for the thrash, we'll get this worked out.

Jeff, can you drop this patch from the queue a v4 is incoming.

Regards,
Jake
