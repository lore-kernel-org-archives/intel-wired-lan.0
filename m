From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 28 Sep 2020 08:50:11 +0200
Subject: [Intel-wired-lan] [patch 21/35] net: usb: kaweth: Remove last
 user of kaweth_control()
In-Reply-To: <20200927194921.948595516@linutronix.de>
References: <20200927194846.045411263@linutronix.de>
 <20200927194921.948595516@linutronix.de>
Message-ID: <20200928065011.GB381927@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Sep 27, 2020 at 09:49:07PM +0200, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> kaweth_async_set_rx_mode() invokes kaweth_contol() and has two callers:
> 
> - kaweth_open() which is invoked from preemptible context
> .
> - kaweth_start_xmit() which holds a spinlock and has bottom halfs disabled.
> 
> If called from kaweth_start_xmit() kaweth_async_set_rx_mode() obviously
> cannot block, which means it can't call kaweth_control(). This is detected
> with an in_interrupt() check.
> 
> Replace the in_interrupt() check in kaweth_async_set_rx_mode() with an
> argument which is set true by the caller if the context is safe to sleep,
> otherwise false.
> 
> Now kaweth_control() is only called from preemptible context which means
> there is no need for GFP_ATOMIC allocations anymore. Replace it with
> usb_control_msg(). Cleanup the code a bit while at it.
> 
> Finally remove kaweth_control() since the last user is gone.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb at vger.kernel.org
> Cc: netdev at vger.kernel.org

Thanks for the cleanup, that driver really needed it!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
