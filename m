From: David Miller <davem@davemloft.net>
Date: Tue, 24 Apr 2018 09:50:48 -0400 (EDT)
Subject: [Intel-wired-lan] [RFC v3 net-next 13/18] net/sched: Introduce
 the TBS Qdisc
In-Reply-To: <alpine.DEB.2.21.1804241012020.5261@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1803211407520.3754@nanos.tec.linutronix.de>
 <768e8da5-502e-d36f-0f32-9324eaca4a1d@intel.com>
 <alpine.DEB.2.21.1804241012020.5261@nanos.tec.linutronix.de>
Message-ID: <20180424.095048.818224012961344954.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 24 Apr 2018 10:50:04 +0200 (CEST)

> So adding 8 bytes to spare duplicated code will not change the kmem_cache
> object size and I really doubt that anyone will notice.

It's about where the cache lines end up when each and every byte is added
to the structure, not just the slab object size.
