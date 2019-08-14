From: Ben Greear <greearb@candelatech.com>
Date: Wed, 14 Aug 2019 11:12:30 -0700
Subject: [Intel-wired-lan] CMA alloc failed with 6 4-port X710 QAD4 NICs
In-Reply-To: <CAKgT0UfyuDAnY5oHNAtFuBQkqn7NQiCxF9eSD+m+1EkrUOaaHA@mail.gmail.com>
References: <9e598973-0bca-eda1-c5df-9f3ef16bf700@candelatech.com>
 <CAKgT0UfyuDAnY5oHNAtFuBQkqn7NQiCxF9eSD+m+1EkrUOaaHA@mail.gmail.com>
Message-ID: <c8123132-c811-7467-fcf5-b3320961b527@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/14/19 10:54 AM, Alexander Duyck wrote:
> On Mon, Aug 12, 2019 at 2:19 PM Ben Greear <greearb@candelatech.com> wrote:
>>
>> Hello,
>>
>> I have a user trying to boot up our 4.20+ kernel with 6 4-port 10G NICs in it.
>>
>> dmesg is full of cma_alloc errors.  I increased CMA space to 32MB, but still no luck.
>>
>> Any idea how much CMA memory is needed for this config?
>>
>> Thanks,
>> Ben
> 
> You are going to need to go much bigger since you have 24 ports. Each
> port can consume several MB of contiguous space due to all the
> dma_alloc_coherent calls. It also depends on the number of queues you
> have enabled on the system as each queue pair will consume 24K of
> contiguous space as well.
> 
> My advise would be to look at increasing it to somewhere in the range
> of 64MB to 128MB.
> 
> Another alternative, assuming that the drivers are still working after
> making a fall-back allocation out of non-CMA space would be to just
> add __GFP_NOWARN to the flags passed to dma_alloc_coherent. That
> should mute the warnings on allocation failures and just fall back to
> the warning provided by the caller.

cma=512M made the warnings go away, but last I heard, the user could not get
link on any of the ports with or without that change.  I'm not sure the root cause of that at this point, possibly it is
cabling or some higher software stack issue.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

