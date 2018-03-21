From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 21 Mar 2018 08:03:53 -0700
Subject: [Intel-wired-lan] [RFC v3 net-next 14/18] net/sched: Add HW
 offloading capability to TBS
In-Reply-To: <alpine.DEB.2.21.1803211448310.3754@nanos.tec.linutronix.de>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-15-jesus.sanchez-palencia@intel.com>
 <alpine.DEB.2.21.1803211448310.3754@nanos.tec.linutronix.de>
Message-ID: <20180321150353.5k3kg5h4x5vh5iif@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Mar 21, 2018 at 03:22:11PM +0100, Thomas Gleixner wrote:
> Which clockid will be handed in from the application? The network adapter
> time has no fixed clockid. The only way you can get to it is via a fd based
> posix clock and that does not work at all because the qdisc setup might
> have a different FD than the application which queues packets.

Duh.  That explains it.  Please ignore my "why not?" Q in the other thread...

Thanks,
Richard
