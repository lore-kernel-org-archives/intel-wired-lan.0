From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 17 Nov 2020 08:37:41 +0100
Subject: [Intel-wired-lan] [PATCH 0/8] New netdev feature flags for XDP
In-Reply-To: <875z655t80.fsf@toke.dk>
References: <20201116093452.7541-1-marekx.majtyka@intel.com>
 <875z655t80.fsf@toke.dk>
Message-ID: <CAJ8uoz1C7-a7A0WJqThomSxYwmdkfLpDyC5YnB8g_J+p486RXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 16, 2020 at 2:25 PM Toke H?iland-J?rgensen <toke@redhat.com> wrote:
>
> alardam at gmail.com writes:
>
> > From: Marek Majtyka <marekx.majtyka@intel.com>
> >
> > Implement support for checking if a netdev has native XDP and AF_XDP zero
> > copy support. Previously, there was no way to do this other than to try
> > to create an AF_XDP socket on the interface or load an XDP program and
> > see if it worked. This commit changes this by extending existing
> > netdev_features in the following way:
> >  * xdp        - full XDP support (XDP_{TX, PASS, DROP, ABORT, REDIRECT})
> >  * af-xdp-zc  - AF_XDP zero copy support
> > NICs supporting these features are updated by turning the corresponding
> > netdev feature flags on.
>
> Thank you for working on this! The lack of a way to discover whether an
> interface supports XDP is really annoying.
>
> However, I don't think just having two separate netdev feature flags for
> XDP and AF_XDP is going to cut it. Whatever mechanism we end up will
> need to be able to express at least the following, in addition to your
> two flags:
>
> - Which return codes does it support (with DROP/PASS, TX and REDIRECT as
>   separate options)?
> - Does this interface be used as a target for XDP_REDIRECT
>   (supported/supported but not enabled)?
> - Does the interface support offloaded XDP?

If we want feature discovery on this level, which seems to be a good
idea and goal to have, then it is a dead end to bunch all XDP features
into one. But fortunately, this can easily be addressed.

> That's already five or six more flags, and we can't rule out that we'll
> need more; so I'm not sure if just defining feature bits for all of them
> is a good idea.

I think this is an important question. Is extending the netdev
features flags the right way to go? If not, is there some other
interface in the kernel that could be used/extended for this? If none
of these are possible, then we (unfortunately) need a new interface
and in that case, what should it look like?

Thanks for taking a look at this Toke.

> In addition, we should be able to check this in a way so we can reject
> XDP programs that use features that are not supported. E.g., program
> uses REDIRECT return code (or helper), but the interface doesn't support
> it? Reject at attach/load time! Or the user attempts to insert an
> interface into a redirect map, but that interface doesn't implement
> ndo_xdp_xmit()? Reject the insert! Etc.
>
> That last bit can be added later, of course, but we need to make sure we
> design the support in a way that it is possible to do so...
>
> -Toke
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
