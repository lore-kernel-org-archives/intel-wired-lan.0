From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 28 Sep 2020 01:00:52 +0200
Subject: [Intel-wired-lan] [patch 13/35] net: mdiobus: Remove
 WARN_ON_ONCE(in_interrupt())
In-Reply-To: <20200927194921.137019811@linutronix.de>
References: <20200927194846.045411263@linutronix.de>
 <20200927194921.137019811@linutronix.de>
Message-ID: <20200927230052.GG3889809@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Sep 27, 2020 at 09:48:59PM +0200, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> in_interrupt() is ill defined and does not provide what the name
> suggests. The usage especially in driver code is deprecated and a tree wide
> effort to clean up and consolidate the (ab)usage of in_interrupt() and
> related checks is happening.
> 
> In this case the check covers only parts of the contexts in which these
> functions cannot be called. It fails to detect preemption or interrupt
> disabled invocations.
> 
> As the functions which contain these warnings invoke mutex_lock() which
> contains a broad variety of checks (always enabled or debug option
> dependent) and therefore covers all invalid conditions already, there is no
> point in having inconsistent warnings in those drivers. The conditional
> return is not really valuable in practice either.
> 
> Just remove them.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
