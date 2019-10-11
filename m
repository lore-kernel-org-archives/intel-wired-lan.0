From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 11 Oct 2019 01:03:04 +0000
Subject: [Intel-wired-lan] [net-next v3 1/7] ptp: correctly disable
 flags on old ioctls
In-Reply-To: <20190926181109.4871-2-jacob.e.keller@intel.com>
References: <20190926181109.4871-1-jacob.e.keller@intel.com>
 <20190926181109.4871-2-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9714C84E@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Jacob Keller
> Sent: Thursday, September 26, 2019 11:11 AM
> To: netdev at vger.kernel.org
> Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Richard Cochran <richardcochran@gmail.com>; Felipe Balbi
> <felipe.balbi@linux.intel.com>; David S . Miller <davem@davemloft.net>; Hall,
> Christopher S <christopher.s.hall@intel.com>
> Subject: [net-next v3 1/7] ptp: correctly disable flags on old ioctls
> 
> Commit 415606588c61 ("PTP: introduce new versions of IOCTLs",
> 2019-09-13) introduced new versions of the PTP ioctls which actually
> validate that the flags are acceptable values.
> 
> As part of this, it cleared the flags value using a bitwise
> and+negation, in an attempt to prevent the old ioctl from accidentally
> enabling new features.
> 
> This is incorrect for a couple of reasons. First, it results in
> accidentally preventing previously working flags on the request ioctl.
> By clearing the "valid" flags, we now no longer allow setting the
> enable, rising edge, or falling edge flags.
> 
> Second, if we add new additional flags in the future, they must not be
> set by the old ioctl. (Since the flag wasn't checked before, we could
> potentially break userspace programs which sent garbage flag data.
> 
> The correct way to resolve this is to check for and clear all but the
> originally valid flags.
> 
> Create defines indicating which flags are correctly checked and
> interpreted by the original ioctls. Use these to clear any bits which
> will not be correctly interpreted by the original ioctls.
> 
> In the future, new flags must be added to the VALID_FLAGS macros, but
> *not* to the V1_VALID_FLAGS macros. In this way, new features may be
> exposed over the v2 ioctls, but without breaking previous userspace
> which happened to not clear the flags value properly. The old ioctl will
> continue to behave the same way, while the new ioctl gains the benefit
> of using the flags fields.
> 
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Christopher Hall <christopher.s.hall@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/ptp/ptp_chardev.c      |  4 ++--
>  include/uapi/linux/ptp_clock.h | 22 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

