From: Shannon Nelson <snelson@pensando.io>
Date: Mon, 28 Sep 2020 12:51:14 -0700
Subject: [Intel-wired-lan] [patch 11/35] net: ionic: Replace
 in_interrupt() usage.
In-Reply-To: <5e4c3201-9d90-65b1-5c13-e2381445be1d@pensando.io>
References: <20200927194846.045411263@linutronix.de>
 <20200927194920.918550822@linutronix.de>
 <5e4c3201-9d90-65b1-5c13-e2381445be1d@pensando.io>
Message-ID: <1d0950f8-cab4-9ef2-6cf7-73b71b750a8d@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/28/20 10:24 AM, Shannon Nelson wrote:
> On 9/27/20 12:48 PM, Thomas Gleixner wrote:
>> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> The in_interrupt() usage in this driver tries to figure out which 
>> context
>> may sleep and which context may not sleep. in_interrupt() is not really
>> suitable as it misses both preemption disabled and interrupt disabled
>> invocations from task context.
>>
>> Conditionals like that in driver code are frowned upon in general 
>> because
>> invocations of functions from invalid contexts might not be detected
>> as the conditional papers over it.
>>
>> ionic_lif_addr() can be called from:
>>
>> ? 1) ->ndo_set_rx_mode() which is under netif_addr_lock_bh()) so it 
>> must not
>> ???? sleep.
>>
>> ? 2) Init and setup functions which are in fully preemptible task 
>> context.
>>
>> _ionic_lif_rx_mode() has only one call path with BH disabled.

Now that I've had my coffee, let's look at this again - there are 
multiple paths that get us to _ionic_lif_rx_mode():

.ndo_set_rx_mode
 ? ionic_set_rx_mode,
 ??? _ionic_lif_rx_mode

{ ionic_open, ionic_lif_handle_fw_up, ionic_start_queues_reconfig }
 ??? ionic_txrx_init
 ????? ionic_set_rx_mode
 ??????? _ionic_lif_rx_mode

We may not want to change this one.

sln



>>
>> ionic_link_status_check_request() has two call paths:
>>
>> ? 1) NAPI which obviously cannot sleep
>>
>> ? 2) Setup which is again fully preemptible task context
>>
>> Add 'can_sleep' arguments to the affected functions and let the callers
>> provide the context instead of letting the functions deduce it.
>>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Shannon Nelson <snelson@pensando.io>
>> Cc: Pensando Drivers <drivers@pensando.io>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: netdev at vger.kernel.org
>
> Acked-by: Shannon Nelson <snelson@pensando.io>
>
>> ---
>>
>> While reviewing the callpaths, a couple of things were observed which 
>> could
>> be improved:
>>
>> - ionic_lif_deferred_work() can iterate over the list. There is no need
>> ?? to schedule the work item after each iteration
>
> I think the original writer's intent was to avoid monopolizing the 
> work thread for very long on any one cycle, with the thought that we'd 
> be making more use of this than we currently are.? I'll address this.
>
>>
>> - ionic_link_status_check_request() could have ionic_deferred_work 
>> within
>> ?? ionic_lif(). This would avoid memory allocation from NAPI. More
>> ?? important, once IONIC_LIF_F_LINK_CHECK_REQUESTED is set and that 
>> alloc
>> ?? fails, the link check never happens.
>
> Thanks, I'll fix up that error condition.
>
>>
>> - ionic_lif_handle_fw_down() sets IONIC_LIF_F_FW_RESET. Invokes then
>> ?? ionic_lif_deinit() which only invokes cancel_work_sync() if
>> ?? IONIC_LIF_F_FW_RESET is not set. I think the logic is wrong here as
>> ?? the work must always be cancled. Also the list with ionic_deferred
>> ?? work items needs a clean up.
>
> I'll look at that, thanks.
>
> sln
>
>

