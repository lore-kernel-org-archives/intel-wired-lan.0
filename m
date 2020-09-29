From: Kalle Valo <kvalo@codeaurora.org>
Date: Tue, 29 Sep 2020 11:01:23 +0300
Subject: [Intel-wired-lan] [patch 00/35] net: in_interrupt() cleanup and
 fixes
In-Reply-To: <20200927194846.045411263@linutronix.de> (Thomas Gleixner's
 message of "Sun, 27 Sep 2020 21:48:46 +0200")
References: <20200927194846.045411263@linutronix.de>
Message-ID: <87o8lpdnak.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thomas Gleixner <tglx@linutronix.de> writes:

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
>
> In the long run, usage of 'preemptible, in_*irq etc.' should be banned from
> driver code completely.
>
> Our team started to dig through drivers and this it the first batch of
> cleanups in drivers/net/. It's not yet complete, so expect further patches
> in the next days.
>
> The series contains:
>
>     - A couple of bug fixes
>
>     - Removal of the bitrotting CAIF SPI driver which has never had a
>       matching driver providing the necessary platform device support.
>
>     - Removal of WARN/BUG(in_interrupt()) en masse as most of them are
>       incomplete because they won't detect other non-preemptible
>       context. All of the functions which have these WARN/BUG invoke core
>       code functions which can sleep. These have plenty of checks to catch
>       _all_ invalid contexts. So it's pointless to have incomplete WARN/BUG
>       in the drivers.
>
>       If a driver wants to have such a check for paranoia reasons, then
>       e.g. lockdep_assert_preemtion_enabled() is the right mechanism to
>       chose because lockdep guarantees to catch all invalid contexts
>       independent of kernel configuration while e.g. preemptible() does
>       not.
>
>     - Conversion of in_interrupt() checks to use either different functions
>       or to hand the context information in from the caller.
>
>     - For some drivers handing the context into functions which decided
>       between netif_rx() and netif_rx_ni() turned out to be impossible due
>       to lack of driver knowledge and convoluted code pathes with multiple
>       indirections. For those a core code function netif_rx_any_context()
>       is provided which contains an in_interrupt() check as a stop
>       gap. This allows to make progess on the driver side cleanup and
>       the function should go away once the driver wizards have fixed it
>       up proper.
>
>     - Simplifcation and cleanups in various places where code pointlessly
>       contains in_interrupt() conditionals which are mostly leftovers from
>       calling conventions in older kernels and have never been cleaned up.
>
>       Along with removing if from the horrible DBG_FOO() macro mess which
>       probably should be removed completely as the kernel today provides
>       way more sensible mechanisms to do function tracing and similar.
>
>     - A few other cleanups which were obvious when chasing the
>       in_interrupt() usage.
>
> The pile is also available from:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git softirq
>
> The diffstat summary is:
>
>  86 files changed, 300 insertions(+), 2233 deletions(-)
>
> which is biased by the CAIF SPI removal. Without that it is:
>
>  79 files changed, 300 insertions(+), 697 deletions(-)
>
> Thanks,
>
> 	tglx
> ---

[...]

>  b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c     |    4 
>  b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h        |    5 
>  b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c       |   20 
>  b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c       |    8 
>  b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h       |    7 
>  b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c     |    2 
>  b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c       |   12 
>  b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h       |    2 
>  b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c        |    2 
>  b/drivers/net/wireless/intel/ipw2x00/ipw2100.c                  |    3 
>  b/drivers/net/wireless/intel/ipw2x00/ipw2200.h                  |    6 
>  b/drivers/net/wireless/intel/ipw2x00/libipw.h                   |    3 
>  b/drivers/net/wireless/intel/iwlegacy/common.h                  |    4 
>  b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c                |    5 
>  b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h         |    6 
>  b/drivers/net/wireless/intersil/hostap/hostap_hw.c              |   12 
>  b/drivers/net/wireless/marvell/libertas/defs.h                  |    3 
>  b/drivers/net/wireless/marvell/libertas/rx.c                    |   11 
>  b/drivers/net/wireless/marvell/libertas_tf/deb_defs.h           |    3 
>  b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c               |    6 
>  b/drivers/net/wireless/marvell/mwifiex/util.c                   |    6 
>  b/drivers/net/wireless/realtek/rtlwifi/base.c                   |   47 
>  b/drivers/net/wireless/realtek/rtlwifi/base.h                   |    3 
>  b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c |   12 
>  b/drivers/net/wireless/realtek/rtlwifi/core.c                   |    6 
>  b/drivers/net/wireless/realtek/rtlwifi/debug.c                  |   20 
>  b/drivers/net/wireless/realtek/rtlwifi/debug.h                  |    6 
>  b/drivers/net/wireless/realtek/rtlwifi/pci.c                    |    4 
>  b/drivers/net/wireless/realtek/rtlwifi/ps.c                     |   27 
>  b/drivers/net/wireless/realtek/rtlwifi/ps.h                     |   10 
>  b/drivers/net/wireless/realtek/rtlwifi/wifi.h                   |    3 
>  b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c                  |    1 

For the wireless patches:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

I assume Dave will take them, but just let me know if I should take them
instead.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
