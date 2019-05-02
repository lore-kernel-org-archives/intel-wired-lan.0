From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 2 May 2019 10:28:22 -0700
Subject: [Intel-wired-lan] i40e X722 RSS problem with NAT-Traversal
 IPsec packets
In-Reply-To: <20190502171636.3yquioe3gcwsxlus@csclub.uwaterloo.ca>
References: <20190501205215.ptoi2czhklte5jbm@csclub.uwaterloo.ca>
 <CAKgT0UczVvREiXwde6yJ8_i9RT2z7FhenEutXJKW8AmDypn_0g@mail.gmail.com>
 <20190502151140.gf5ugodqamtdd5tz@csclub.uwaterloo.ca>
 <CAKgT0Uc_OUAcPfRe6yCSwpYXCXomOXKG2Yvy9c1_1RJn-7Cb5g@mail.gmail.com>
 <20190502171636.3yquioe3gcwsxlus@csclub.uwaterloo.ca>
Message-ID: <CAKgT0Ufk8LXMb9vVWfvgbjbQFKAuenncf95pfkA0P1t-3+Ni_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, May 2, 2019 at 10:16 AM Lennart Sorensen
<lsorense@csclub.uwaterloo.ca> wrote:
>
> On Thu, May 02, 2019 at 10:03:23AM -0700, Alexander Duyck wrote:
> > On Thu, May 2, 2019 at 8:11 AM Lennart Sorensen
> > <lsorense@csclub.uwaterloo.ca> wrote:
> > >
> > > On Wed, May 01, 2019 at 03:52:57PM -0700, Alexander Duyck wrote:
> > > > I'm not sure how RSS will do much for you here. Basically you only
> > > > have the source IP address as your only source of entropy when it
> > > > comes to RSS since the destination IP should always be the same if you
> > > > are performing a server role and terminating packets on the local
> > > > system and as far as the ports in your example you seem to only be
> > > > using 4500 for both the source and the destination.
> > >
> > > I have thousands of IPsec clients connecting.  Simply treating them as
> > > normal UDP packets would work.  The IP address is different, and often
> > > the port too.
> >
> > Thanks for the clarification. I just wanted to verify that I know we
> > have had similar complaints in the past and it turns out those were
> > only using one set of IP addresses.
> >
> > > > In your testing are you only looking at a point to point connection
> > > > between two systems, or do you have multiple systems accessing the
> > > > system you are testing? I ask as the only way this should do any
> > > > traffic spreading via RSS would be if the source IPs are different and
> > > > that would require multiple client systems accessing the server.
> > >
> > > I tried changing the client IP address and the RSS hash key.  It never
> > > changed to another queue.  Something is broken.
> >
> > Okay, so if changing the RSS hash key has not effect then it is likely
> > not being used.
> >
> > > > In the case of other encapsulation types over UDP, such as VXLAN, I
> > > > know that a hash value is stored in the UDP source port location
> > > > instead of the true source port number. This allows the RSS hashing to
> > > > occur on this extra information which would allow for a greater
> > > > diversity in hash results. Depending on how you are generating the ESP
> > > > encapsulation you might look at seeing if it would be possible to have
> > > > a hash on the inner data used as the UDP source port in the outgoing
> > > > packets. This would help to resolve this sort of issue.
> > >
> > > Well it works on every other network card except this one.  Every other
> > > intel card in the past we have used had no problem doing this right.
> >
> > The question is what is different about this card, and I don't have an
> > immediate answer so we would need to do some investigation.
>
> I think the firmware has a bug. :)  My first email has my speculation
> of where the bug could be.

The thing is the firmware has to have some idea what it is dealing
with. As far as I know I don't believe port number 4500 is being
auto-flagged as any special type. In the case of the other tunnel
types such as VXLAN, NVGRE, and GENEVE the driver has to set a port
value indicating that the port will receive special handling. If it
isn't added via i40e_udp_tunnel_add then the firmware/hardware
shouldn't know anything about the tunnel.

> > You had stated in your earlier email that "Other UDP packets are
> > fine". Perhaps we need to do some further isolation to identify why
> > the ESP over UDP packets are not being hashed on while other UDP
> > packets are.
>
> Well they are IP packets encapsulated in UDP, while other UDP packets
> are not IP packets encapsulated in UDP, and there is special handling
> for some IP types inside UDP on this card, which is an unusual feature.

It really isn't that unusual of a feature. Many NICs have this
functionality now. In order to support it we usually have to populate
the port values for the device so the internal parser knows to expect
them.

> For the supported IP in UDP types, it actually is supposed to use the IP
> packet inside the UDP packet to generate the RSS value, so it pretends it
> wasn't even encapsulated.  But it does not handle ESP in UDP specifically,
> and hence I suspect that is the problem.  I think it tries to handle the
> IP in UDP and since it doesn't support ESP in UDP it fails to fall back
> to using the original UDP packet for the RSS value.  That would at least
> explain why regular UDP packets that don't contain an IP packet inside
> are fine, but this particular type of packet is being handled wrong.

That is one of the reasons I suggested testing with netperf as I did
below. Basically if we construct all the outer headers the same as
your packet we can see if some specific combination is causing a
parsing issue. I tested the netperf approach on an XL710 and didn't
see any issues, but perhaps the XL722 is doing something differently.

> > Would it be possible to provide a couple of raw Ethernet frames
> > instead of IP packets for us to examine? I noticed the two packets you
> > sent earlier didn't start until the IP header. One possibility would
> > be that if we had any extra outer headers or trailers added to the
> > packet that could possibly cause issues since that might either make
> > the packet not parsable or possibly flag it as some sort of length
> > error when the size of the packet doesn't match what is reported in
> > the headers.
>
> Oh did I forget the option for that?  I can try and capture some today
> with the full headers.

Thanks. If nothing else it should make it possible to just use
tcpreplay if needed to reproduce the issue.

> > One other thing we may want to look at doing is trying to identify the
> > particular part of the packets that might be causing the hash to not
> > be generated. One way to do that would be to use something like
> > netperf to generate packets and send them toward your test system.
> > Something like the command line below could be used to send packets
> > that should be similar to the ones you provided earlier:
> >      netperf -H <target IP> -t UDP_STREAM -N -- -P 4500,4500 -m 132
> >
> > If the packets generated by netperf were not hashed that would tell us
> > then it may be some sort of issue with how UDP packets are being
> > parsed, and from there we could narrow things down by modifying port
> > numbers and changing packet sizes. If that does get hashed then we
> > need to start looking outside of the IP/UDP header parsing for
> > possible issues since there is likely something else causing the
> > issue.
>
> I will see what I can do with that.
>
> --
> Len Sorensen
