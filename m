From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 14 Mar 2018 08:13:17 -0700
Subject: [Intel-wired-lan] [PATCH 12/15] ice: Add stats and ethtool
 support
In-Reply-To: <20180313141414.00007d11@intel.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-13-anirudh.venkataramanan@intel.com>
 <20180309151428.4d73358c@cakuba.netronome.com>
 <1520967916.696.21.camel@intel.com>
 <a6f3bd20-705e-2022-23c8-1e3b5a8c93a6@gmail.com>
 <20180313141414.00007d11@intel.com>
Message-ID: <20180314081317.1bbfe856@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 13 Mar 2018 14:14:14 -0700
Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:

> Maybe it's just that I've been doing this too long, but I regularly
> (and many other customers/users do as well) depend on the ethtool stats
> being atomically updated w.r.t. each other.  This means that if I'm
> getting the over rx_packets, as well as the per-queue rx_packets, and I
> read them all at once from the driver with ethtool, then I can check
> that things are working as expected.

Any application depending on this behavior is really fragile.
It is unportable to other devices (which I guess is to Intel's benefit)
and relying on guarantees not provided by current Linux network devices.
