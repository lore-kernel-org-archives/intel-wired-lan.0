From: Coelho, Luciano <luciano.coelho@intel.com>
Date: Mon, 28 Sep 2020 06:13:14 +0000
Subject: [Intel-wired-lan] [patch 28/35] net: iwlwifi: Remove
 in_interrupt() from tracing macro.
In-Reply-To: <20200927194922.629869406@linutronix.de>
References: <20200927194846.045411263@linutronix.de>
 <20200927194922.629869406@linutronix.de>
Message-ID: <ab22cc7b0d1f98e1d620e77ce7abce1f95b6813e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, 2020-09-27 at 21:49 +0200, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> The usage of in_interrupt) in driver code is phased out.
> 
> The iwlwifi_dbg tracepoint records in_interrupt() seperately, but that's
> superfluous because the trace header already records all kind of state and
> context information like hardirq status, softirq status, preemption count
> etc.
> 
> Aside of that the recording of in_interrupt() as boolean does not allow to
> distinguish between the possible contexts (hard interrupt, soft interrupt,
> bottom half disabled) while the trace header gives precise information.
> 
> Remove the duplicate information from the tracepoint and fixup the caller.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Cc: Luca Coelho <luciano.coelho@intel.com>
> Cc: Intel Linux Wireless <linuxwifi@intel.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: linux-wireless at vger.kernel.org
> Cc: netdev at vger.kernel.org

Acked-by: Luca Coelho <luca@coelho.fi>

--
Luca.
