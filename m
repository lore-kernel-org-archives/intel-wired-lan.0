From: Kushal Gautam <kushal.gautam@gmail.com>
Date: Sun, 10 Sep 2017 20:07:03 +0200
Subject: [Intel-wired-lan] Tuning the napi_poll function.
In-Reply-To: <1504799550.21804.28.camel@intel.com>
References: <CAGv3bDfGVD75dEQGwjUFQt0EpCsJwvO-L60WMXO+_vA4zF+ejw@mail.gmail.com>
 <1504799550.21804.28.camel@intel.com>
Message-ID: <CAGv3bDcPo7aY6OcJrxBhch0H=o1_+vOU_duK2OmGAk3sie79cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alex,

Thank you for your response.


> Have you looked at busy polling at all?


Will X710 support busy poll at all? I guess, it has support for Mellanox,
right ? And for the time being, my access is restricted to only one NIC.

Other than the i40e driver in the kernel you might also want to look at the
> i40e code for the DPDK driver


Yes, I had looked at the i40e driver from the Kernel source tree.
Surprisingly, the flow director in that driver package seems to have flaws.
I had posted about this issue in this mailing list well as Intel Community
forum as well. But, there was no particular solution on this problem. Thus,
I switched to i40e-2.0.30.
Regarding DPDK. yes, I looked at it too. Essentially, I did understand the
logic for it (regarding the memory allocation and stuffs), but I could not
understand the polling mode properly, since they have completely revamped
the driver code. May be, for this I should post in the DPDK forum once.

 As far as having NAPI execute every 500ms probably the easiest way to do
> that would be to just drop the use of the device interrupts and instead
> setup a timer and have the timer schedule NAPI for the queue from the timer
> interrupt


Yes, based on your suggestions, for the time being, I have set an HR Timer
for given xx ms time interval. The timer tick handler works fine enough.
But the issue that I am facing right now is to invoke NAPI Poll at every
timer tick handler event. At the interval elapsed event, I have called
napi_schedule(napi);. This simply does not trigger napi poll  I thougth, it
would do that( as I saw similar invocatio in Do I need to take care of
other variables as well ? I tried changing the napi->state as napi->state =
1 ( as it was set to 0). But this stalls the system. A solution to this
issue would give me a preliminary progress to monitor my result.

Any inputs on this would be very helpful.

Thanks,
Kushal.

On Thu, Sep 7, 2017 at 5:52 PM, Duyck, Alexander H <
alexander.h.duyck@intel.com> wrote:

> On Thu, 2017-09-07 at 16:56 +0200, Kushal Gautam wrote:
>
> I have gone through multiple posts (in and outside Stackoverflow)
> regarding this topic. Currently, I am working on to modify the i40e-2.0.30
> driver for Intel X710 NIC.
>
> My query is particularly concerned with the NAPI Poll mechanism. I
> understand that napi_poll function is triggered when a packet arrives, and
> if the amount of work done while receiving the packets exceeds the
> allocated budget, NAPI Polling continues; else polling stops.
>
> Based on this information, I modified my driver to keep polling if a
> particular signature of data arrives on a particular queue ( using flow
> director), e.g. UDP Packets on Port XXX for 10,000 poll cycles. But, I am
> trying to eliminate the possibility of interrupts as much as possible.
>
> Have you looked at busy polling at all? If you have a socket application
> listening for those packets it might be able to use busy polling to keep
> NAPI going by having the application itself poll for the packets instead of
> relying on an interrupt to initiate polling.
>
> One caveat with the X710 though is that it will need to have interrupts
> enabled while busy polling is running in order to trigger descriptor
> flushes when there are 3 or fewer descriptors (or packets assuming frame
> size <= 1514) that need to be written back to memory from the device. We
> are investigating to see if there is a way to optimize this behavior to
> avoid unnecessary re-enabling of the interrupts, but we don't have any ETA
> on when we might have patches to do that available.
>
> Thus, here is my main question. Will I be able to schedule the NAPI poll
> to be executed at a certain point in time ? Like, I want NAPI poll to be
> executed every 500 ms and may be last for 20ms. For instance, I will be
> expecting my packet at time *T ms*, while I might start the polling at
> time *(T-10) ms* and stop polling at *(T + 10) ms*. This may, I might be
> able to reduce the usage of interrupts. Right now, I have been resetting
> the interrupts every 10,000 poll cycles.
>
> Any explanation or reference on this would be really helpful.
>
> As far as having NAPI execute every 500ms probably the easiest way to do
> that would be to just drop the use of the device interrupts and instead
> setup a timer and have the timer schedule NAPI for the queue from the timer
> interrupt.
>
> Other than the i40e driver in the kernel you might also want to look at
> the i40e code for the DPDK driver at http://www.dpdk.org/browse/
> dpdk-stable/tree/drivers/net/i40e. The reason I suggest that is that DPDK
> can use a poll mode driver similar to what you have described in order to
> allow a userspace process to poll for packets on the device. You may be
> able to review that code to get a better idea of how to implement your own
> poll mode driver.
>
>
> Regards,
> Kushal.
>
>
> Thanks.
>
> - Alex
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170910/ee2b3d3f/attachment.html>
