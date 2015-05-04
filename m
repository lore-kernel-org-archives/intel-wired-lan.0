From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 4 May 2015 17:24:27 +0000
Subject: [Intel-wired-lan] [PATCH 0/8] clarify behavior of get_ts_info
 and hwtstamp ioctl
In-Reply-To: <1430569680.2669.152.camel@jtkirshe-mobl>
References: <1429738873.30529.20.camel@intel.com>
 <1430569680.2669.152.camel@jtkirshe-mobl>
Message-ID: <1430760267.2218.0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2015-05-02 at 05:28 -0700, Jeff Kirsher wrote:
> On Wed, 2015-04-22 at 21:41 +0000, Keller, Jacob E wrote:
> > This patch series attempts to clarify some expected behavior for
> > drivers
> > when implementing SIOCSHWSTAMP and Ethtool's get_ts_info ioctl.
> > 
> > The SIOCSHWTSTAMP ioctl has several available filters for Rx
> > timestamps
> > ranging from as specific as
> > HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ_MESSAGE
> > up to as general as HWTSTAMP_FILTER_ALL. It is expressly allowed for a
> > driver to timestamp more than the requested packets, as long as at
> > least
> > the requested packets are timestamped. Many drivers do this by
> > upscaling
> > from the more specific filters into the most generic supported
> > filters.
> > In this case, some drivers also only report in the Ethtool ioctl those
> > filters which are generic. Since the generic filters are more valuable
> > to users of the Rx timestamps, and it is obvious that
> > HWTSTAMP_FILTER_PTP_V2_EVENT will timestamp SYNC and DELAY_REQ
> > messages,
> > this patch series clarifies that this behavior is ok. In addition, I
> > provided patches to implement this behavior in get_ts_info for all
> > drivers which currently upscale their hwtstamp ioctl return value.
> > 
> > I did not modify SIOCSHWTSTAMP semantics, and only modified ethtool
> > output. In addition, I left alone drivers which do not actually
> > upscale
> > their filters. In this way only the filters which are *not* upscaled
> > are
> > reported in ethtool output.
> > 
> > The intention of this change is to report only the most useful filters
> > to ethtool op output. It should not impact userspace as user
> > applications most often check for the most general filters first and
> > only try the very specific filters as a fallback. I tried to Cc the
> > driver owners where I knew them.
> > 
> > There is also one patch which removes an extraneous comment I
> > discovered while working on this. It was obviously kept around from an
> > original copy-and-modify implementation, and bears no relation to the
> > current driver code in the freescale driver.
> > 
> > Jacob Keller (8):
> >   clarify implementation of ethtool's get_ts_info op
> >   [TRIVIAL] freescale: remove incorrect copied comment
> >   bnx2x: only report most generic filters in get_ts_info
> >   i40e: only report generic filters in get_ts_info
> >   igb: only report generic filters in get_ts_info
> >   ixgbe: only report generic filters in get_ts_info
> >   siena: only report generic filters in get_ts_info
> >   dp83640: only report generic filters in ts_info
> > 
> >  Documentation/networking/timestamping.txt           |  7 +++++++
> >  drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c | 11 +----------
> >  drivers/net/ethernet/freescale/fec_ptp.c            |  6 ------
> >  drivers/net/ethernet/intel/i40e/i40e_ethtool.c      | 13
> > ++-----------
> >  drivers/net/ethernet/intel/igb/igb_ethtool.c        |  4 ----
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c    |  8 --------
> >  drivers/net/ethernet/sfc/siena.c                    |  6 +-----
> >  drivers/net/phy/dp83640.c                           | 10 +---------
> >  include/uapi/linux/ethtool.h                        |  5 +++++
> >  9 files changed, 17 insertions(+), 53 deletions(-)
> 
> I have applied your series to my queue, not sure what validation can be
> done on the non-Intel driver changes.

Yea, I wasn't sure. I just wanted to make sure we at least checked the
Intel through the normal channels. At least we can verify the other
parts compile and such.

Regards,
Jake

