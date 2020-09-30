From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 30 Sep 2020 08:22:58 +0200
Subject: [Intel-wired-lan] [patch V2 21/36] net: usb: kaweth: Replace
 kaweth_control() with usb_control_msg()
In-Reply-To: <20200929203501.588965483@linutronix.de>
References: <20200929202509.673358734@linutronix.de>
 <20200929203501.588965483@linutronix.de>
Message-ID: <20200930062258.GA1471881@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Sep 29, 2020 at 10:25:30PM +0200, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> kaweth_control() is almost the same as usb_control_msg() except for the
> memory allocation mode (GFP_ATOMIC vs GFP_NOIO) and the in_interrupt()
> check.
> 
> All the invocations of kaweth_control() are within the probe function in
> fully preemtible context so there is no reason to use atomic allocations,
> GFP_NOIO which is used by usb_control_msg() is perfectly fine.
> 
> Replace kaweth_control() invocations from probe with usb_control_msg().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Note, the usb_control_msg_send/recv() new functions that will show up in
5.10-rc1 will help a bit with this logic, but for what you have now,
this is fine, nice cleanups.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
