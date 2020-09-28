From: Edward Cree <ecree@solarflare.com>
Date: Mon, 28 Sep 2020 20:03:26 +0100
Subject: [Intel-wired-lan] [patch 15/35] net: sfc: Replace
 in_interrupt() usage.
In-Reply-To: <20200927194921.344476620@linutronix.de>
References: <20200927194846.045411263@linutronix.de>
 <20200927194921.344476620@linutronix.de>
Message-ID: <168a1f9e-cba4-69a8-9b29-5c121295e960@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 27/09/2020 20:49, Thomas Gleixner wrote:
> Note, that the fixes tag is empty as it is unclear which of the commits to
> blame.
Seems like it should be
Fixes: f00bf2305cab("sfc: don't update stats on VF when called in atomic context")
?since that adds the in_interrupt() check and the code concerned
?doesn't seemto have changed a great deal since.

Anyway, this fix looks correct, and you can have my
Acked-by: Edward Cree <ecree@solarflare.com>
?but I thinkit might be cleaner to avoid having to have this unused
?can_sleep argument on all the NICs that don't need it, by instead
?adding an update_stats_atomic() member to struct efx_nic_type, which
?could be set to the same as update_stats() for everything except
?EF10 VFs which would just do the call to efx_update_sw_stats().
I'll send an rfc patch embodying the above shortly...

-ed
