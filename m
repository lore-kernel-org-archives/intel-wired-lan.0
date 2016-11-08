From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 8 Nov 2016 21:56:54 +0000
Subject: [Intel-wired-lan] [PATCH net-next 0/3] PHC frequency fine tuning
In-Reply-To: <cover.1478526333.git.richardcochran@gmail.com>
References: <cover.1478526333.git.richardcochran@gmail.com>
Message-ID: <1478642213.7545.36.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-11-08 at 22:49 +0100, Richard Cochran wrote:
> This series expands the PTP Hardware Clock subsystem by adding a
> method that passes the frequency tuning word to the the drivers
> without dropping the low order bits.??Keeping those bits is useful
> for
> drivers whose frequency resolution is higher than 1 ppb.
> 

Makes sense.

> The appended script (below) runs a simple demonstration of the
> improvement.??This test needs two Intel i210 PCIe cards installed in
> the same PC, with their SDP0 pins connected by copper
> wire.??Measuring
> the estimated offset (from the ptp4l servo) and the true offset (from
> the PPS) over one hour yields the following statistics.
> 
> > 
> > ???????|???Est. Before |????Est. After |???True Before |????True
> > After |
> > --------+---------------+---------------+---------------+--------
> > -------|
> > min????| -5.200000e+01 | -1.600000e+01 | -3.100000e+01 |
> > -1.000000e+00 |
> > max????| +5.700000e+01 | +2.500000e+01 | +8.500000e+01 |
> > +4.000000e+01 |
> > pk-pk: | +1.090000e+02 | +4.100000e+01 | +1.160000e+02 |
> > +4.100000e+01 |
> > mean???| +6.472222e-02 | +1.277778e-02 | +2.422083e+01 |
> > +1.826083e+01 |
> > stddev | +1.158006e+01 | +4.581982e+00 | +1.207708e+01 |
> > +4.981435e+00 |
> 
> Here the numbers in units of nanoseconds, and the ~20 nanosecond PPS
> offset is due to input/output delays on the i210's external interface
> logic.
> 
> With the series applied, both the peak to peak error and the standard
> deviation improve by a factor of more than two.??These two graphs
> show
> the improvement nicely.
> 
> ? http://linuxptp.sourceforge.net/fine-tuning/fine-est.png
> 
> ? http://linuxptp.sourceforge.net/fine-tuning/fine-tru.png
> 

Wow, nice! I'll take a look at the actual patches in a few minutes, but
this is a really nice improvement!

Thanks,
Jake

> 
> Thanks,
> Richard
> 
> Richard Cochran (3):
> ? ptp: Introduce a high resolution frequency adjustment method.
> ? ptp: igb: Use the high resolution frequency method.
> ? ptp: dp83640: Use the high resolution frequency method.
> 
> ?drivers/net/ethernet/intel/igb/igb_ptp.c | 16 ++++++++--------
> ?drivers/net/phy/dp83640.c????????????????| 14 +++++++-------
> ?drivers/ptp/ptp_clock.c??????????????????|??5 ++++-
> ?include/linux/ptp_clock_kernel.h?????????|??8 ++++++++
> ?4 files changed, 27 insertions(+), 16 deletions(-)
> 
