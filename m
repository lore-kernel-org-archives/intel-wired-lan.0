From: David Miller <davem@davemloft.net>
Date: Fri, 27 Sep 2019 20:25:59 +0200 (CEST)
Subject: [Intel-wired-lan] [net-next v2 1/2] ptp: correctly disable
 flags on old ioctls
In-Reply-To: <20190926022820.7900-2-jacob.e.keller@intel.com>
References: <20190926022820.7900-1-jacob.e.keller@intel.com>
 <20190926022820.7900-2-jacob.e.keller@intel.com>
Message-ID: <20190927.202559.2108440086367535055.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 25 Sep 2019 19:28:19 -0700

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
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Applied to 'net'.
