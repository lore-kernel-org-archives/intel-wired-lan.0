From: Joe Perches <joe@perches.com>
Date: Sun, 27 Sep 2020 13:22:10 -0700
Subject: [Intel-wired-lan] [patch 00/35] net: in_interrupt() cleanup and
 fixes
In-Reply-To: <20200927194846.045411263@linutronix.de>
References: <20200927194846.045411263@linutronix.de>
Message-ID: <c7a5fd123e3c634ce0bbac9abb4ae32c8c67e0c6.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, 2020-09-27 at 21:48 +0200, Thomas Gleixner wrote:
> Folks,
> 
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

Are these patches intended to be applied to Linus'
tree before v5.9 is released?

This patchset will cause conflicts against -next.

For instance, in patch 34, RT_TRACE has already
been removed in -next.


