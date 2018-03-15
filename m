From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 15 Mar 2018 10:47:35 -0700
Subject: [Intel-wired-lan] [RFC PATCH 0/2] net:setup XPS mapping for
 each online CPU
In-Reply-To: <1521134431.2681.26.camel@redhat.com>
References: <cover.1521124830.git.pabeni@redhat.com>
 <CANn89iKcHzs2enS-CjNx3xJWwXwjX9Uu_7JYihOR4=HPsQLj6Q@mail.gmail.com>
 <1521129082.2681.13.camel@redhat.com>
 <CANn89iLJOVuN-1j+9_qr_LaU7AE6COHdnp4Rc7fe9p6_s=hCCA@mail.gmail.com>
 <1521134431.2681.26.camel@redhat.com>
Message-ID: <CAKgT0UfnVxW0s+pzcJib0fXnQvFV3pyYz26y7msKf2_s9tLjrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 15, 2018 at 10:20 AM, Paolo Abeni <pabeni@redhat.com> wrote:
> Hi,
>
> On Thu, 2018-03-15 at 15:59 +0000, Eric Dumazet wrote:
>> On Thu, Mar 15, 2018 at 8:51 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> > I'm sorry, I do not follow. AFAICS with unconnected sockets without XPS
>> > we always hit the netdev_pick_tx()/skb_tx_hash()/skb_flow_dissect()
>> > overhead in xmit path.
>>
>> Then fix this if you want, instead of fixing one NIC only, or by enforcing
>> XPS by all NIC.
>>
>> For unconnected sockets, picking the TX queue based on current cpu is good,
>> we do not have to enforce ordering as much as possible.
>>
>> (pfifo_fast no longer can enforce it anyway)
>
> Thank you for the prompt reply.
>
> I'm double checking to avoid misinterpretation on my side: are you
> suggesting to plug a CPU-based selection logic for unconnected sockets
> in netdev_pick_tx() or to cook patches like 2/2 for all the relevant
> NICs?
>
> Thanks!
>
> Paolo

We just need to watch out for any possible side effects. For example
using XPS on a virtualization host has been problematic as you end up
with the traffic getting reordered if the VM jumps from CPU to CPU.

Thanks.

- Alex
