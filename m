From: James Cameron <quozl@laptop.org>
Date: Wed, 30 Sep 2020 07:53:03 +1000
Subject: [Intel-wired-lan] [patch V2 33/36] net: libertas: Use
 netif_rx_any_context()
In-Reply-To: <20200929203502.769744809@linutronix.de>
References: <20200929202509.673358734@linutronix.de>
 <20200929203502.769744809@linutronix.de>
Message-ID: <20200929215302.GB16571@laptop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Sep 29, 2020 at 10:25:42PM +0200, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> The usage of in_interrupt() in non-core code is phased out. Ideally the
> information of the calling context should be passed by the callers or the
> functions be split as appropriate.
> 
> libertas uses in_interupt() to select the netif_rx*() variant which matches
> the calling context. The attempt to consolidate the code by passing an
> arguemnt or by distangling it failed due lack of knowledge about this
> driver and because the call chains are hard to follow.
> 
> As a stop gap use netif_rx_any_context() which invokes the correct code
> path depending on context and confines the in_interrupt() usage to core
> code.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Kalle Valo <kvalo@codeaurora.org>

Reviewed-by: James Cameron <quozl@laptop.org>

-- 
James Cameron
http://quozl.netrek.org/
