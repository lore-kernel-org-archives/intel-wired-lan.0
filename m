From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 17 Nov 2020 19:38:43 +0100
Subject: [Intel-wired-lan] [PATCH 0/8] New netdev feature flags for XDP
In-Reply-To: <CAAOQfrGzfKf-vpaitfC_KLDnWDo_uJFDF_PE5X9RH_G4Yt8QHA@mail.gmail.com>
References: <20201116093452.7541-1-marekx.majtyka@intel.com>
 <875z655t80.fsf@toke.dk>
 <CAJ8uoz1C7-a7A0WJqThomSxYwmdkfLpDyC5YnB8g_J+p486RXQ@mail.gmail.com>
 <CAAOQfrGzfKf-vpaitfC_KLDnWDo_uJFDF_PE5X9RH_G4Yt8QHA@mail.gmail.com>
Message-ID: <87wnyj25ho.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Marek Majtyka <alardam@gmail.com> writes:

> On Tue, Nov 17, 2020 at 8:37 AM Magnus Karlsson
> <magnus.karlsson@gmail.com> wrote:
>
> Thank you for your quick answers and comments.
>
>>
>> On Mon, Nov 16, 2020 at 2:25 PM Toke H?iland-J?rgensen <toke@redhat.com> wrote:
>> >
>> > alardam at gmail.com writes:
>> >
>> > > From: Marek Majtyka <marekx.majtyka@intel.com>
>> > >
>> > > Implement support for checking if a netdev has native XDP and AF_XDP zero
>> > > copy support. Previously, there was no way to do this other than to try
>> > > to create an AF_XDP socket on the interface or load an XDP program and
>> > > see if it worked. This commit changes this by extending existing
>> > > netdev_features in the following way:
>> > >  * xdp        - full XDP support (XDP_{TX, PASS, DROP, ABORT, REDIRECT})
>> > >  * af-xdp-zc  - AF_XDP zero copy support
>> > > NICs supporting these features are updated by turning the corresponding
>> > > netdev feature flags on.
>> >
>> > Thank you for working on this! The lack of a way to discover whether an
>> > interface supports XDP is really annoying.
>> >
>> > However, I don't think just having two separate netdev feature flags for
>> > XDP and AF_XDP is going to cut it. Whatever mechanism we end up will
>> > need to be able to express at least the following, in addition to your
>> > two flags:
>> >
>> > - Which return codes does it support (with DROP/PASS, TX and REDIRECT as
>> >   separate options)?
>> > - Does this interface be used as a target for XDP_REDIRECT
>> >   (supported/supported but not enabled)?
>> > - Does the interface support offloaded XDP?
>>
>> If we want feature discovery on this level, which seems to be a good
>> idea and goal to have, then it is a dead end to bunch all XDP features
>> into one. But fortunately, this can easily be addressed.
>
> Do you think that is it still considerable to have a single netdev
> flag that means "some" XDP feature support which would activate new
> further functionalities?

Why bother? The presence of any XDP-specific feature bits would imply
the support for XDP :)

>> > That's already five or six more flags, and we can't rule out that we'll
>> > need more; so I'm not sure if just defining feature bits for all of them
>> > is a good idea.
>>
>> I think this is an important question. Is extending the netdev
>> features flags the right way to go? If not, is there some other
>> interface in the kernel that could be used/extended for this? If none
>> of these are possible, then we (unfortunately) need a new interface
>> and in that case, what should it look like?
>
> Toke, are you thinking about any particular existing interface or a
> new specific one?

I have mostly been thinking about the internal kernel interface. The
simple thing would just be to define a whole new bitmap of XDP-specific
feature bits that the rest of the kernel can consume. That would also
mean we don't have to do pointer chasing to see if the ndos are
implemented, which Jesper pointed out the other day actually shows up on
his profiling traces.

The downside to having them be feature flags is that they can get out of
sync, of course. But if we block the support from working unless the
right flags are set, that should at least make driver developers pay
attention. Although we'd have to change all the drivers in one go, but I
suppose that's not too onerous seeing as you just did that for this
series :)

So what that boils down to is basically what you're doing in this
series, but more fine grained, via a new netdev->xdp_features instead of
burning bits in netdev->features.

As for UAPI, i dunno? Ethtool is netlink now, right? So it should be
fairly easy to just extend with a new attribute for XDP?

I believe there was originally some resistance to explicitly exposing
XDP capabilities to userspace because we wanted all drivers to implement
all features. Clearly that has not panned out, though, so as far as I'm
concerned we can just expose it and be done with it :) But I'll let
others weigh in here; the original discussions predate my involvement.

-Toke

