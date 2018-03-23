From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 23 Mar 2018 09:51:37 +0100 (CET)
Subject: [Intel-wired-lan] [RFC v3 net-next 14/18] net/sched: Add HW
 offloading capability to TBS
In-Reply-To: <8b6e4036-2357-3f7c-f72d-b6594da32348@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-15-jesus.sanchez-palencia@intel.com>
 <alpine.DEB.2.21.1803211448310.3754@nanos.tec.linutronix.de>
 <8b6e4036-2357-3f7c-f72d-b6594da32348@intel.com>
Message-ID: <alpine.DEB.2.21.1803230950560.4625@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 22 Mar 2018, Jesus Sanchez-Palencia wrote:
> On 03/21/2018 07:22 AM, Thomas Gleixner wrote:
> > Bah, and probably there you need CLOCK_TAI because that's what PTP is based
> > on, so clock_system needs to accomodate that as well. Dammit, there goes
> > the simple 2 bits implementation. CLOCK_TAI is 11, so we'd need 4 clock
> > bits plus the adapter bit.
> > 
> > Though we could spare a bit. The fixed CLOCK_* space goes from 0 to 15. I
> > don't see us adding new fixed clocks, so we really can reserve #15 for
> > selecting the adapter clock if sparing that extra bit is truly required.
> 
> 
> So what about just using the previous single 'clockid' argument, but then just
> adding to uapi time.h something like:
> 
> #define DYNAMIC_CLOCKID 15
> 
> And using it for that, instead. This way applications that will use the raw hw
> offload mode must use this value for their per-socket clockid, and the qdisc's
> clockid would be implicitly initialized to the same value.

That's what I suggested above.

Thanks,

	tglx
