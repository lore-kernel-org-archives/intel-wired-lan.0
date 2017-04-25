From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 25 Apr 2017 10:16:22 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: initialize u64_stats_sync
 structures early at ixgbe_probe
In-Reply-To: <trinity-a348af9b-9ef5-47a9-a14e-94265c880cf1-1493134775614@3capp-gmx-bs78>
References: <1480909244-16460-1-git-send-email-liwei.song@windriver.com>
 <EF50CC0C76A53A44BAD798C58E0A157E50B87CBB@ORSMSX103.amr.corp.intel.com>
 <CAKgT0UeTdY9j1qDHP=DscgAZF2pPFCb+=ACySqKBK+UuBsaNBA@mail.gmail.com>
 <trinity-a348af9b-9ef5-47a9-a14e-94265c880cf1-1493134775614@3capp-gmx-bs78>
Message-ID: <CAKgT0Uc31ehKGmjKWFg6YNWtqvD1grosaVXqBX+GUCxUBdQUHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Apr 25, 2017 at 8:39 AM, Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:
> Hi,
>
>> This patch doesn't look right to me. I would suggest rejecting it.
>>
>> The call to initialize the stats should be done when the ring is
>> allocated, not in ixgbe_probe(). This should probably be done in
>> ixgbe_alloc_q_vector() instead.
>>
>
> AFAICS ixgbe_alloc_q_vector() is also called in probe() (by ixgbe_init_interrupt_scheme()).
> Furthermore it is also called in resume() which would lead to multiple initialization of
> the u64_stats_sync in case of resume.

ixgbe_alloc_q_vector() is what allocates the ring structures that are
being initialized here. Calling it anywhere other than here doesn't
make sense since what we want to do is initialize the memory after we
have allocated it, but before we hand the pointer to it over to a
netdev or in this case an adapter structure.

> IMHO the u64_stats_sync variables have to be initialized before register_netdev() is called
> since this is the point from which userspace can call ixgbe_get_stats64(). I would say the
> best place to do so is the probe() function as it is done in this patch.

I would disagree here. We should be initializing the stats variables
after we allocate them. Especially since we can end up freeing and
reallocating them any time the number of queues is changed.

> Just my 2 cents.
>
> Regards,
> Lino

My advice would be to look through the code and verify what it is you
need to initialize and where it should happen. In this case we are
getting a lockdep splat since we are just letting things get
initialized with kzalloc and aren't following up in the right place. I
don't disagree that the original code has the u64_stats_init in the
wrong place since we can open/close the interface and trigger a
reinitialization of the stats. I would say we need to initialize the
stats just after we allocate them in memory so that if we decide to
free and reallocate the rings we initialize the new rings before they
are added to the netdev and don't reintroduce this issue in just a
different form.

- Alex
