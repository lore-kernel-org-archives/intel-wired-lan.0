From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 7 Sep 2016 19:58:17 -0700
Subject: [Intel-wired-lan] Question about 4 TX/RX queues and ixgbe
In-Reply-To: <39C610DD-2516-4202-B77D-8032A25F3E6F@purestorage.com>
References: <A5A784DD-DB62-4511-8D8C-0A1CBCC23250@purestorage.com>
 <F6FB0E698C9B3143BDF729DF2228664696AE8088@ORSMSX116.amr.corp.intel.com>
 <39C610DD-2516-4202-B77D-8032A25F3E6F@purestorage.com>
Message-ID: <CAKgT0Ufn3+QVGokXs858_pf5LaCzGcSid7PYW4LnkyXUgQre2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 7, 2016 at 5:50 PM, Ruslan Nikolaev <ruslan@purestorage.com> wrote:
> Donald,
>
> Thank you very much for your responses! I still want to clarify several things.
>
>> We support two queue allocations in SR-IOV mode which is what the conditionals you are looking at here.  You can see the options in the MRQC register from the data sheet.  The two in question are:
>>
>> 1010b = SR-IOV and RSS - 32 pools, 4 RSS
>> 1011b = SR-IOV and RSS - 64 pools, 2 RSS
>>
>> This allows our PF to have the max queues available, since it has to use a queue pool just like all the VF's.  So limiting the PF to just use one RSS queue really doesn't buy you anything when it comes to the number of queues the VF can support.
>>
>
> I am a bit confused but is rss_i parameter for PF only?
> So, if we want to use RSS=1 for PF (ixgbe) but 4TX/RX for VF (dpdk), why does the driver forces us to use 2-queue mode instead of 4-queue mode (which would otherwise be allowed for rss_i >= 4)? Is there any difference for PF itself?

The problem is you have to populate the redirection table for 4
queues.  So in order to make this work what you would probably need to
do is modify more code than what was called out in the earlier patch.

Specifically one of the pieces missing is that we need to update
ixgbe_setup_reta so that it will populate with the maximum number of
queues supported per pool instead of 2.

>>> 2. We do not necessarily need separate interrupts for RX, we just need 4 TX
>>> but are going to use just one 1 RX. Is it still a problem to use the proposed
>>> change?
>>
>> In both drivers ixgbe/ixgbevf Rx and Tx queues are paired together.  If you want to write a driver pair that only has one RX queue and 4 TX queues that all share the interrupt you I imagine it could be done. But currently ixgbe/ixgbevf assume the queues are paired together and thus wouldn't work without a major refactor of the code in both drivers.  Likewise I'm not sure what would be gained by having multiple TX queues but only one RX?  But like I mentioned, I have never ran the driver in that mode either. :)
>>
>
> I guess, one confusion could be here that we do not use ixgbevf but rather dpdk. It seems like in dpdk, it is possible to set up 4TX-and-1RX mode but that requires 4-queue mode to be enabled by ixgbe.

Actually I think the confusion is in the request.  So essentially you
are wanting 4 Tx queues and 1 Rx queue.  You don't really care about
RSS or anything like that.  What we could probably do is allocate 4
queues per pool, but restrict the PF to 2 in the case of it trying to
allocate 3 queues.  I'll see about submitting something to address it
in the next hour or so.

- Alex
