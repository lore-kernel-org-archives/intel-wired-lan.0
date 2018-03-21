From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 21 Mar 2018 07:59:30 -0700
Subject: [Intel-wired-lan] [RFC v3 net-next 08/18] net: SO_TXTIME: Add
 clockid and drop_if_late params
In-Reply-To: <alpine.DEB.2.21.1803211244320.3754@nanos.tec.linutronix.de>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-9-jesus.sanchez-palencia@intel.com>
 <1520391209.109662.33.camel@gmail.com>
 <20180307052410.m2yqmokrivjlwcjz@localhost>
 <alpine.DEB.2.21.1803211244320.3754@nanos.tec.linutronix.de>
Message-ID: <20180321145930.4hlmihghljpv2wrq@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Mar 21, 2018 at 01:58:51PM +0100, Thomas Gleixner wrote:
> Errm. No. There is no way to support fd based clocks or one of the CPU
> time/process time based clocks for this.

Why not?
 
If the we have HW offloading, then the transmit time had better be
expressed in terms of the MAC's internal clock.  Otherwise we would
need to translate between a kernel clock and the MAC clock, but that
is expensive (eg over PCIe) and silly (because in a typical use case
the MAC will already be synchronized to the network time).

Thanks,
Richard
