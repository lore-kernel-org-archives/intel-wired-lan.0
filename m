From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 16:37:04 +0200
Subject: [Intel-wired-lan] [patch 11/35] net: ionic: Replace
 in_interrupt() usage.
In-Reply-To: <1d0950f8-cab4-9ef2-6cf7-73b71b750a8d@pensando.io>
References: <20200927194846.045411263@linutronix.de>
 <20200927194920.918550822@linutronix.de>
 <5e4c3201-9d90-65b1-5c13-e2381445be1d@pensando.io>
 <1d0950f8-cab4-9ef2-6cf7-73b71b750a8d@pensando.io>
Message-ID: <87h7rgk5tb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 28 2020 at 12:51, Shannon Nelson wrote:
> On 9/28/20 10:24 AM, Shannon Nelson wrote:
>>> ionic_lif_addr() can be called from:
>>>
>>> ? 1) ->ndo_set_rx_mode() which is under netif_addr_lock_bh()) so it 
>>> must not
>>> ???? sleep.
>>>
>>> ? 2) Init and setup functions which are in fully preemptible task 
>>> context.
>>>
>>> _ionic_lif_rx_mode() has only one call path with BH disabled.
>
> Now that I've had my coffee, let's look at this again - there are 
> multiple paths that get us to _ionic_lif_rx_mode():
>
> .ndo_set_rx_mode
>  ? ionic_set_rx_mode,
>  ??? _ionic_lif_rx_mode
>
> { ionic_open, ionic_lif_handle_fw_up, ionic_start_queues_reconfig }
>  ??? ionic_txrx_init
>  ????? ionic_set_rx_mode
>  ??????? _ionic_lif_rx_mode

Hrm. Let me stare at it again...
