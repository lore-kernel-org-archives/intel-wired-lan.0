From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Mar 2018 15:59:17 +0000
Subject: [Intel-wired-lan] [RFC PATCH 0/2] net:setup XPS mapping for
 each online CPU
In-Reply-To: <1521129082.2681.13.camel@redhat.com>
References: <cover.1521124830.git.pabeni@redhat.com>
 <CANn89iKcHzs2enS-CjNx3xJWwXwjX9Uu_7JYihOR4=HPsQLj6Q@mail.gmail.com>
 <1521129082.2681.13.camel@redhat.com>
Message-ID: <CANn89iLJOVuN-1j+9_qr_LaU7AE6COHdnp4Rc7fe9p6_s=hCCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 15, 2018 at 8:51 AM Paolo Abeni <pabeni@redhat.com> wrote:

> Hi,

> On Thu, 2018-03-15 at 15:31 +0000, Eric Dumazet wrote:
> > On Thu, Mar 15, 2018 at 8:08 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > > Currently, most MQ netdevice setup the default XPS configuration
mapping
> >
> > 1-1
> > > the first real_num_tx_queues queues and CPUs and no mapping is
created for
> > > the CPUs with id greater then real_num_tx_queues, if any.
> > > As a result, the xmit path for unconnected sockets on such cores
> >
> > experiences a
> > > relevant overhead in netdev_pick_tx(), which needs to dissect each
packet
> >
> > and
> > > compute its hash.
> > > Such scenario is easily triggered. e.g. from DNS server under relevant
> >
> > load, as
> > > the user-space process is moved away from the CPUs serving the
softirqs
> >
> > (note:
> > > this is beneficial for the overall DNS server performances).
> > > This series introduces an helper to easily setup up XPS mapping for
all
> >
> > the
> > > online CPUs, and use it in the ixgbe driver, demonstrating a relevant
> > > performance improvement in the above scenario.
> > > Paolo Abeni (2):
> > >    net: introduce netif_set_xps()
> > >    ixgbe: setup XPS via netif_set_xps()
> >
> >
> > Resent, not HTML this time, sorry for duplication.
> >
> > I truly believe XPS should not be setup by devices.
> >
> > XPS is policy, and policy does belong to user space.

> Thank you for your comments!

> As general principle, I agree policies should be in user-space, but I
> also think that the kernel should provide a reasonable default. Many MQ
> devices already configure XPS and their default is AFAICS sub-optimal.

> > Note that if XPS is not setup, MQ queue selection is just fine by
default ;

> I'm sorry, I do not follow. AFAICS with unconnected sockets without XPS
> we always hit the netdev_pick_tx()/skb_tx_hash()/skb_flow_dissect()
> overhead in xmit path.


Then fix this if you want, instead of fixing one NIC only, or by enforcing
XPS by all NIC.

For unconnected sockets, picking the TX queue based on current cpu is good,
we do not have to enforce ordering as much as possible.

(pfifo_fast no longer can enforce it anyway)
