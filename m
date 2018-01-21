From: Matheus Almeida <hm.matheus@gmail.com>
Date: Sun, 21 Jan 2018 22:51:01 +0000
Subject: [Intel-wired-lan] Cable pull behaviour on Intel I350 card
In-Reply-To: <CACmWKm+42jegq0BbXPDdrqJqq_dGahvEdQV1xaDgW8bOO-RCZQ@mail.gmail.com>
References: <CACmWKmKsyKc13JoszThZREcCbJK46eRrAd8mJ0+4TL-dYg_e5g@mail.gmail.com>
 <CAKgT0UegUOPhD1h_d6YtrxPaPBdbBHF058exQXuS8AE1YSD-qg@mail.gmail.com>
 <CACmWKmJ0VZTdSquFgrznP7FLGBDeDruevJ5T2UKCYJuTeMNSEA@mail.gmail.com>
 <CAKgT0Uf83sTrJOPjv_sqtwaJE1u6qi6OwmP8L82YN=A+z6fO9A@mail.gmail.com>
 <CACmWKmL6X9zBO+QXrxNUSo_HZoksf1_HvUXGY8fvmf_kNCXcjQ@mail.gmail.com>
 <CAKgT0Ue3Gx502D+f6r-2X3JEq7hHUNbJ95HeyhYdYEtyw+x_wg@mail.gmail.com>
 <CACmWKm+VCyjFSXaHnT3CKEbHimRHNArO+dm7DjLAKKFSGa0fXw@mail.gmail.com>
 <CACmWKm+42jegq0BbXPDdrqJqq_dGahvEdQV1xaDgW8bOO-RCZQ@mail.gmail.com>
Message-ID: <CACmWKmLYNd1tDKmR0DuhhN6EzZKFmAYTvk-x5OnZ1NEvnfa7sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Is there any other information I can give to you to to finalise the
assessment of this problem ?

Regards,
Matheus



On Wed, Jan 17, 2018 at 9:34 AM, Matheus Almeida <hm.matheus@gmail.com>
wrote:

> Hi again,
>
> Reviving this old thread as I know have more information about this driver
> and adapter's behaviour.
>
> Short description of the problem again: For an Intel I350 network adapter,
> removing one of the ethernet cables from one of the ports causes the
> adapter to reset if TX packets are found in the TX ring.
> On our system, this causes a delay of up to 80ms to the other physical
> interfaces and causes a video transmission to stop for a considerable
> amount of time.
>
> I instrumented almost all instructions in the following functions
> (igb_main.c):
>
>    - igb_down()
>    - igb_up()
>    - igb_configure()
>
> [13354.898065] igb_main.c: igb_down loop took 0 ms
> [13354.898065] igb_main.c: igb_down del_timer_sync watchdog_timer took 0
> ms
> [13354.898066] igb_main.c: igb_down del_timer_sync phy_info_timer took 0
> ms
> [13354.898067] igb_main.c: igb_down recording the stats took 0 ms
> [13356.729525] igb_main.c: igb_down igb_reset took 1831 ms
> [13356.729824] igb_main.c: igb_down clean_all_tx_rings took 0 ms
> [13356.732590] igb_main.c: igb_down clean_all_rx_rings took 3 ms
> [13356.732590] igb_main.c: igb_down the rest took 0 ms
> [13356.732591] igb_main.c: igb_reinit_locked igb_down total took 2444 ms
> [13356.732593] igb_main.c: igb_configure igb_get_hw_control took 0 ms
> [13356.732624] igb_main.c: igb_configure igb_set_rx_mode took 0 ms
> [13356.732630] igb_main.c: igb_configure igb_restore_vlan took 0 ms
> [13356.732635] igb_main.c: igb_configure igb_setup_tctl took 0 ms
> [13356.732644] igb_main.c: igb_configure igb_setup_mrqc took 0 ms
> [13356.732646] igb_main.c: igb_configure igb_setup_rctl took 0 ms
> [13356.732647] igb_main.c: igb_configure igb_nfc_filter_restore took 0 ms
> *[13356.812783] igb_main.c: igb_configure igb_configure_tx took 80 ms*
> <<<<
> [13356.812802] igb_main.c: igb_configure igb_configure_rx took 0 ms
> [13356.812804] igb_main.c: igb_configure igb_rx_fifo_flush_82575 took 0 ms
> [13356.815569] igb_main.c: igb_configure igb_alloc_rx_buffers took 3 ms
> *[13356.815570] igb_main.c: igb_up igb_configure took 83 ms* <<<<<<
> [13356.815598] igb_main.c: igb_reinit_locked igb_up total took 83 ms
>
> The problem seems to come from igb_configure_tx that takes 80 milliseconds
> to complete. From a code inspection, this seems to be: number_of_tx_rings *
> mdelay(10).
>
> Question: Is the mdelay(10) call necessary ? It causes the kworker threads
> to stop handling the requests to send data to other interfaces.
>
> I made a quick experiment and removed the call to mdelay. This fixes the
> problem BUT I'm very concerned about possible side effects. Can someone
> please comment on this ?
>
> Any idea how this can be improved ?
>
> Best Regards,
> Matheus
>
> On Wed, Nov 22, 2017 at 2:07 PM, Matheus Almeida <hm.matheus@gmail.com>
> wrote:
>
>> Hi Alexander,
>>
>> I started instrumenting the following functions: igb_down(), igb_up() and
>> igb_reset() and unfortunately I stopped being able to replicate the problem.
>> It seems that affects the scheduling of kernel workers and the problem
>> isn't replicated using the same test case.
>>
>> I'm going to improve the reproduction steps [yet again] and update you as
>> soon as I have more data.
>>
>> Regards,
>> Matheus
>>
>> On Mon, Nov 20, 2017 at 4:16 PM, Alexander Duyck <
>> alexander.duyck at gmail.com> wrote:
>>
>>> Hi Matheus,
>>>
>>> The reset is most likely being triggered by the fact that there is Tx
>>> work in one of the queues on the port that is unplugged. The reset
>>> itself shouldn't be effecting all of the ports though.
>>>
>>> I am thinking that the reset is somehow preempting the other tasks for
>>> some period of time. We might need to start crawling through the
>>> various functions to try and sort out where the delay might be coming
>>> from. As such you may want to look at breaking things down and
>>> watching for igb_down() and igb_up() and doing some further testing to
>>> see if we can identify which one of these would be adding a
>>> significant amount of time. One of my concerns is that igb_down() has
>>> calls to functions such as del_timer_sync which ends up calling things
>>> that will disable interrupts for short periods of time. It is possible
>>> that something like this might be causing the short stalls you are
>>> seeing.
>>>
>>> Thanks.
>>>
>>> - Alex
>>>
>>> On Mon, Nov 20, 2017 at 5:49 AM, Matheus Almeida <hm.matheus@gmail.com>
>>> wrote:
>>> > Hi Alexander,
>>> >
>>> > I was on annual leave for the last 2 weeks so I couldn't get back to
>>> the
>>> > list earlier.
>>> >
>>> > I reproduced the problem again and it seems that 'igb_reset_task' is
>>> called
>>> > whenever the problem occurs.
>>> >
>>> > Here's a link to an ftrace file that shows the problem including
>>> traces to
>>> > 'igb_reset_task': https://goo.gl/WVkMjz
>>> >
>>> > Do you think this issue is caused by Tx work being left in the queue ?
>>> Is
>>> > the problem related to a call to igb_reset_task that preempts the other
>>> > processes from sending data for a big chunk of time ? If positive,
>>> what can
>>> > we do about it ?
>>> >
>>> > Regards,
>>> > Matheus
>>> >
>>> > On Fri, Nov 3, 2017 at 4:23 PM, Alexander Duyck <
>>> alexander.duyck at gmail.com>
>>> > wrote:
>>> >>
>>> >> One other function that would be useful to monitor would be
>>> >> igb_reset_task. It is normally called when either the DMA engine gets
>>> >> hung, or there is Tx work left in the queue following a cable being
>>> >> unplugged.
>>> >>
>>> >> - Alex
>>> >>
>>> >> On Fri, Nov 3, 2017 at 6:46 AM, Matheus Almeida <hm.matheus@gmail.com
>>> >
>>> >> wrote:
>>> >> > Hi Alexander,
>>> >> >
>>> >> > Thank you very much for the prompt reply.
>>> >> >
>>> >> > I managed to set up a better testing environment that allows me to
>>> >> > replicate
>>> >> > the problem
>>> >> > and gather more meaningful trace information.
>>> >> >
>>> >> > My testing environment is roughly the following:
>>> >> >
>>> >> > Server 1:
>>> >> > Two separate processes send a continuous stream of data uniquely
>>> >> > identified
>>> >> > on two separate data ports
>>> >> > of a i350 network card.
>>> >> >
>>> >> > Server 2:
>>> >> > Two separate processes receive the data and check if there was a
>>> delay
>>> >> > between packets that is greater
>>> >> > than a arbitrary threshold.
>>> >> >
>>> >> > Here's a link to a "trace.dat" file -> https://goo.gl/6KuBqz
>>> >> >
>>> >> > You should see 3 instances of a "cable" pull causing a delay on the
>>> task
>>> >> > with PID 14618.
>>> >> >
>>> >> > The task with PID 14617 was the one I was "upsetting" on purpose by
>>> >> > removing
>>> >> > a network
>>> >> > cable.
>>> >> >
>>> >> > I can see instances of igb_watchdog* function calls from the trace.
>>> >> >
>>> >> > I can trace other functions of interest if required and/or other
>>> >> > processes.
>>> >> > Just let me know which
>>> >> > ones would help us narrow down this issue even further.
>>> >> >
>>> >> > Regards,
>>> >> > Matheus
>>> >> >
>>> >> >
>>> >> > On Tue, Oct 31, 2017 at 4:05 PM, Alexander Duyck
>>> >> > <alexander.duyck@gmail.com>
>>> >> > wrote:
>>> >> >>
>>> >> >> On Tue, Oct 31, 2017 at 6:22 AM, Matheus Almeida <
>>> hm.matheus at gmail.com>
>>> >> >> wrote:
>>> >> >> > Hi,
>>> >> >> >
>>> >> >> > I'm developing an appliance for the broadcast industry for
>>> real-time
>>> >> >> > video
>>> >> >> > transmission.
>>> >> >> > We use Intel I350 network adapters (4 ports) and am seeking more
>>> >> >> > information
>>> >> >> > about a behaviour that causes a transmission disruption (~20ms to
>>> >> >> > 80ms)
>>> >> >> > when
>>> >> >> > one of the ethernet cables is pulled.
>>> >> >> >
>>> >> >> > Assuming that data port 0 and data port 1 are both transmitting
>>> data.
>>> >> >> > Disconnecting the ethernet cable from data port 1 seems to stop
>>> the
>>> >> >> > transmission of data port 0 for a short period of time. This is
>>> a big
>>> >> >> > issue
>>> >> >> > for low-latency appliances like ours (I'll get into more in a
>>> >> >> > second).
>>> >> >> >
>>> >> >> > More information about our system:
>>> >> >> >
>>> >> >> > We use buildroot with Linux Kernel 4.9.29
>>> >> >> > igb driver version 5.4.0-k
>>> >> >> > 8 rx queues, 8 tx queues
>>> >> >> >
>>> >> >> > The level of traffic flowing through the network seems to make
>>> the
>>> >> >> > issue
>>> >> >> > more reproducible.
>>> >> >> >
>>> >> >> > Is this behaviour expected ? If positive, is there a way around
>>> it ?
>>> >> >>
>>> >> >> I wouldn't say this is expected, but then again, I don't know the
>>> >> >> exact cause for what you may be seeing. To narrow it down we could
>>> use
>>> >> >> some more information.
>>> >> >>
>>> >> >> In your setup are you running anything like a team or bond on top
>>> of
>>> >> >> the igb driver interfaces? Also how many CPUs are you running on
>>> the
>>> >> >> system the device is installed in?
>>> >> >>
>>> >> >> > I ran ftrace to get a better picture of what happens during that
>>> >> >> > period
>>> >> >> > of
>>> >> >> > no transmission[1] and all I see [using the sched_switch option]
>>> is a
>>> >> >> > continuous execution of a kernel worker thread on that CPU.
>>> >> >> >
>>> >> >> > I tried to make the following changes to our system with no
>>> >> >> > improvements:
>>> >> >>
>>> >> >> Would it be possible to provide a trace for that worker thread? I
>>> >> >> would be interested in seeing if the worker thread happens to have
>>> >> >> igb_watchdog_task in the path or not. My thought is that we are
>>> likely
>>> >> >> spending time busy waiting in one of the PHY register functions
>>> due to
>>> >> >> the link status changing so we are probably either re-reading the
>>> link
>>> >> >> or resetting the port if there was Tx traffic pending. We would
>>> need
>>> >> >> to sort out which of these events is taking place.
>>> >> >>
>>> >> >> > Changed task priority to RT (this should preempt the kernel
>>> worker
>>> >> >> > threads
>>> >> >> > and give more ) for our transmitter task
>>> >> >> > Changed the cpu_mask for the kernel worker threads so that they
>>> would
>>> >> >> > execute on a spare CPU core
>>> >> >> > Compiled the kernel with PREEMPT=1
>>> >> >>
>>> >> >> One thing you might try just to eliminate hardware as being a
>>> possible
>>> >> >> issue would be to use a second NIC and just use one port on each
>>> >> >> device to verify we aren't looking at any sort of issue where we
>>> are
>>> >> >> doing something like resetting one port and somehow introducing a
>>> >> >> delay through that.
>>> >> >>
>>> >> >> > I have also tried to get ftrace to generate call stacks to get an
>>> >> >> > even
>>> >> >> > better understand of what's happening behind the scenes.
>>> >> >> > Unfortunately
>>> >> >> > this
>>> >> >> > seems to generate too much overhead and I haven't been able to
>>> get a
>>> >> >> > clean
>>> >> >> > execution trace that highlights everything that happens during a
>>> >> >> > cable
>>> >> >> > pull.
>>> >> >> >
>>> >> >> > Is there a better way to debug this issue ? I have total control
>>> of
>>> >> >> > the
>>> >> >> > kernel that we build so I can build the igb driver differently
>>> if it
>>> >> >> > allows
>>> >> >> > us to get to the bottom of this issue.
>>> >> >>
>>> >> >> If nothing else you might look at using trace_printk to just
>>> manually
>>> >> >> add printouts as needed through the driver. That is usually my
>>> default
>>> >> >> when I really need to get in and check various points in the
>>> kernel.
>>> >> >>
>>> >> >> Other than that I would say the main thing we need to look at is
>>> >> >> finding the source of our stalls. You might look at testing the
>>> start
>>> >> >> and exit of igb_watchdog_task and see if that is taking the
>>> 20-80usecs
>>> >> >> you are seeing being consumed when you hit this event.
>>> >> >>
>>> >> >> - Alex
>>> >> >
>>> >> >
>>> >
>>> >
>>>
>>
>>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180121/e0330e41/attachment-0001.html>
