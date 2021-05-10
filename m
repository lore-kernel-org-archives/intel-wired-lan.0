From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Mon, 10 May 2021 17:01:10 +0200
Subject: [Intel-wired-lan] Dropped packets mapping IRQs for adjusted
 queue counts on i40e
In-Reply-To: <87h7jaq1dd.fsf@toke.dk>
References: <CAC1LvL1NHj6n+RNYRmja2YDhkcCwREuhjaBz_k255rU1jdO8Sw@mail.gmail.com>
 <CADS2XXpjasmJKP__oHsrvv3EG8n-FjB6sqHwgQfh7QgeJ8GrrQ@mail.gmail.com>
 <CAC1LvL2Q=s8pmwKAh2615fsTFEETKp96jpoLJS+75=0ztwuLFQ@mail.gmail.com>
 <CADS2XXptoyPTBObKgp3gcRZnWzoVyZrC26tDpLWhC9YrGMSefw@mail.gmail.com>
 <CAC1LvL2zmO1ntKeAoUMkJSarJBgxNhnTva3Di4047MTKqo8rPA@mail.gmail.com>
 <CAC1LvL1Kd-TCuPk0BEQyGvEiLzgUqkZHOKQNOUnxXSY6NjFMmw@mail.gmail.com>
 <20210505130128.00006720@intel.com>
 <20210505212157.GA63266@ranger.igk.intel.com>
 <87fsz0w3xn.fsf@toke.dk>
 <20210509155033.GB36905@ranger.igk.intel.com>
 <87h7jaq1dd.fsf@toke.dk>
Message-ID: <20210510170110.52640ae8@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 10 May 2021 13:22:54 +0200
Toke H?iland-J?rgensen <toke@redhat.com> wrote:

> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > On Thu, May 06, 2021 at 12:29:40PM +0200, Toke H?iland-J?rgensen wrote:  
> >> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> >>   
> >> > On Wed, May 05, 2021 at 01:01:28PM -0700, Jesse Brandeburg wrote:  
> >> >> Zvi Effron wrote:
> >> >>   
> >> >> > On Tue, May 4, 2021 at 4:07 PM Zvi Effron <zeffron@riotgames.com> wrote:  
> >> >> > > I'm suspecting it's something with how XDP_REDIRECT is implemented in
> >> >> > > the i40e driver, but I don't know if this is a) cross driver behavior,
> >> >> > > b) expected behavior, or c) a bug.  
> >> >> > I think I've found the issue, and it appears to be specific to i40e
> >> >> > (and maybe other drivers, too, but not XDP itself).
> >> >> > 
> >> >> > When performing the XDP xmit, i40e uses the smp_processor_id() to
> >> >> > select the tx queue (see
> >> >> > https://elixir.bootlin.com/linux/v5.12.1/source/drivers/net/ethernet/intel/i40e/i40e_txrx.c#L3846).
> >> >> > I'm not 100% clear on how the CPU is selected (since we don't use
> >> >> > cores 0 and 1), we end up on a core whose id is higher than any
> >> >> > available queue.
> >> >> > 
> >> >> > I'm going to try to modify our IRQ mappings to test this.
> >> >> > 
> >> >> > If I'm correct, this feels like a bug to me, since it requires a user
> >> >> > to understand low level driver details to do IRQ remapping, which is a
> >> >> > bit higher level. But if it's intended, we'll just have to figure out
> >> >> > how to work around this. (Unfortunately, using split tx and rx queues
> >> >> > is not possible with i40e, so that easy solution is unavailable.)
> >> >> > 
> >> >> > --Zvi  
> >> >
> >> > Hey Zvi, sorry for the lack of assistance, there has been statutory free
> >> > time in Poland and today i'm in the birthday mode, but we managed to
> >> > discuss the issue with Magnus and we feel like we could have a solution
> >> > for that, more below.
> >> >  
> >> >> 
> >> >> 
> >> >> It seems like for Intel drivers, igc, ixgbe, i40e, ice all have
> >> >> this problem.
> >> >> 
> >> >> Notably, igb, fixes it like I would expect.  
> >> >
> >> > igb is correct but I think that we would like to avoid the introduction of
> >> > locking for higher speed NICs in XDP data path.
> >> >
> >> > We talked with Magnus that for i40e and ice that have lots of HW
> >> > resources, we could always create the xdp_rings array of num_online_cpus()
> >> > size and use smp_processor_id() for accesses, regardless of the user's
> >> > changes to queue count.  
> >> 
> >> What is "lots"? Systems with hundreds of CPUs exist (and I seem to
> >> recall an issue with just such a system on Intel hardware(?)). Also,
> >> what if num_online_cpus() changes?  
> >
> > "Lots" is 16k for ice. For i40e datasheet tells that it's only 1536 for
> > whole device, so I back off from the statement that i40e has a lot of
> > resources :)
> >
> > Also, s/num_online_cpus()/num_possible_cpus().  
> 
> OK, even 1536 is more than I expected; I figured it would be way lower,
> which is why you were suggesting to use num_online_cpus() instead; but
> yeah, num_possible_cpus() is obviously better, then :)
> 
> >> > This way the smp_processor_id() provides the serialization by itself as
> >> > we're under napi on a given cpu, so there's no need for locking
> >> > introduction - there is a per-cpu XDP ring provided. If we would stick to
> >> > the approach where you adjust the size of xdp_rings down to the shrinked
> >> > Rx queue count and use a smp_processor_id() % vsi->num_queue_pairs formula
> >> > then we could have a resource contention. Say that you did on a 16 core
> >> > system:
> >> > $ ethtool -L eth0 combined 2
> >> >
> >> > and then mapped the q0 to cpu1 and q1 to cpu 11. Both queues will grab the
> >> > xdp_rings[1], so we would have to introduce the locking.
> >> >
> >> > Proposed approach would just result with more Tx queues packed onto Tx
> >> > ring container of queue vector.
> >> >
> >> > Thoughts? Any concerns? Should we have a 'fallback' mode if we would be
> >> > out of queues?  
> >> 
> >> Yes, please :)  
> >
> > How to have a fallback (in drivers that need it) in a way that wouldn't
> > hurt the scenario where queue per cpu requirement is satisfied?  
> 
> Well, it should be possible to detect this at setup time, right? Not too
> familiar with the driver code, but would it be possible to statically
> dispatch to an entirely different code path if this happens?

The ndo_xdp_xmit call is a function pointer.  Thus, if it happens at
this level, then at setup time the driver can simply change the NDO to
use a TX-queue-locked variant.

I actually consider it a bug that i40e allow this misconfig to happen.
The ixgbe driver solves the problem by rejecting XDP attach if the
system have more CPUs than TXQs available.

IMHO it is a better solution to add shard'ed/partitioned TXQ-locking
when this situation happens, instead of denying XDP attach.  Since the
original XDP-redirect the ndo_xdp_xmit call have gotten bulking added,
thus the locking will be amortized over the bulk.

One question is how do we inform the end-user that XDP will be using
a slightly slower TXQ-locking scheme?  Given we have no XDP-features
exposed, I suggest a simple kernel log message, which we already have
for other XDP situations when the MTU is too large, or TSO is enabled.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

