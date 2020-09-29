From: David Miller <davem@davemloft.net>
Date: Tue, 29 Sep 2020 14:22:00 -0700 (PDT)
Subject: [Intel-wired-lan] [patch V2 00/36] net: in_interrupt() cleanup
 and fixes
In-Reply-To: <20200929202509.673358734@linutronix.de>
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929.142200.67101764735438804.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:09 +0200

> in the discussion about preempt count consistency accross kernel configurations:
> 
>   https://lore.kernel.org/r/20200914204209.256266093 at linutronix.de/
> 
> Linus clearly requested that code in drivers and libraries which changes
> behaviour based on execution context should either be split up so that
> e.g. task context invocations and BH invocations have different interfaces
> or if that's not possible the context information has to be provided by the
> caller which knows in which context it is executing.
> 
> This includes conditional locking, allocation mode (GFP_*) decisions and
> avoidance of code paths which might sleep.
> 
> In the long run, usage of 'preemptible, in_*irq etc.' should be banned from
> driver code completely.
> 
> This is the second version of the first batch of related changes. V1 can be
> found here:
> 
>      https://lore.kernel.org/r/20200927194846.045411263 at linutronix.de
 ...

Series applied to net-next, thanks.
