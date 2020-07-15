From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Wed, 15 Jul 2020 23:12:23 +0200
Subject: [Intel-wired-lan] NAT performance issue 944mbit -> ~40mbit
In-Reply-To: <CAA85sZu09Z4gydJ8rAO_Ey0zqx-8Lg28=fBJ=FxFnp6cetNd3g@mail.gmail.com>
References: <CAA85sZvKNXCo5bB5a6kKmsOUAiw+_daAVaSYqNW6QbSBJ0TcyQ@mail.gmail.com>
 <CAA85sZua6Q8UR7TfCGO0bV=VU0gKtqj-8o_mqH38RpKrwYZGtg@mail.gmail.com>
 <20200715133136.5f63360c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAA85sZu09Z4gydJ8rAO_Ey0zqx-8Lg28=fBJ=FxFnp6cetNd3g@mail.gmail.com>
Message-ID: <CAA85sZtjCW2Yg+tXPgYyoFA5BKAVZC8kVKG=6SiR64c8ur8UcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jul 15, 2020 at 11:02 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> On Wed, Jul 15, 2020 at 10:31 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > On Wed, 15 Jul 2020 22:05:58 +0200 Ian Kumlien wrote:
> > > After a  lot of debugging it turns out that the bug is in igb...
> > >
> > > driver: igb
> > > version: 5.6.0-k
> > > firmware-version:  0. 6-1
> > >
> > > 03:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network
> > > Connection (rev 03)
> >
> > Unclear to me what you're actually reporting. Is this a regression
> > after a kernel upgrade? Compared to no NAT?
>
> It only happens on "internet links"
>
> Lets say that A is client with ibg driver, B is a firewall running NAT
> with ixgbe drivers, C is another local node with igb and
> D is a remote node with a bridge backed by a bnx2 interface.
>
> A -> B -> C is ok (B and C is on the same switch)
>
> A -> B -> D -- 32-40mbit
>
> B -> D 944 mbit
> C -> D 944 mbit
>
> A' -> D ~933 mbit (A with realtek nic -- also link is not idle atm)

This should of course be A' -> B -> D

Sorry, I've been scratching my head for about a week...

> Can it be a timing issue? this is on a AMD Ryzen 9 system - I have
> tcpdumps but i doubt that they'll help...
>
> > > It's interesting that it only seems to happen on longer links... Any clues?
> >
> > Links as in with longer cables?
>
> Longer links, as in more hops and unknown (in this case Juniper) switches/boxes
