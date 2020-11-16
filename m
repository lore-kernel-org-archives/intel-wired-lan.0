From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 16 Nov 2020 14:25:35 +0100
Subject: [Intel-wired-lan] [PATCH 0/8] New netdev feature flags for XDP
In-Reply-To: <20201116093452.7541-1-marekx.majtyka@intel.com>
References: <20201116093452.7541-1-marekx.majtyka@intel.com>
Message-ID: <875z655t80.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

alardam at gmail.com writes:

> From: Marek Majtyka <marekx.majtyka@intel.com>
>
> Implement support for checking if a netdev has native XDP and AF_XDP zero
> copy support. Previously, there was no way to do this other than to try
> to create an AF_XDP socket on the interface or load an XDP program and
> see if it worked. This commit changes this by extending existing
> netdev_features in the following way:
>  * xdp        - full XDP support (XDP_{TX, PASS, DROP, ABORT, REDIRECT})
>  * af-xdp-zc  - AF_XDP zero copy support
> NICs supporting these features are updated by turning the corresponding
> netdev feature flags on.

Thank you for working on this! The lack of a way to discover whether an
interface supports XDP is really annoying.

However, I don't think just having two separate netdev feature flags for
XDP and AF_XDP is going to cut it. Whatever mechanism we end up will
need to be able to express at least the following, in addition to your
two flags:

- Which return codes does it support (with DROP/PASS, TX and REDIRECT as
  separate options)?
- Does this interface be used as a target for XDP_REDIRECT
  (supported/supported but not enabled)?
- Does the interface support offloaded XDP?

That's already five or six more flags, and we can't rule out that we'll
need more; so I'm not sure if just defining feature bits for all of them
is a good idea.

In addition, we should be able to check this in a way so we can reject
XDP programs that use features that are not supported. E.g., program
uses REDIRECT return code (or helper), but the interface doesn't support
it? Reject at attach/load time! Or the user attempts to insert an
interface into a redirect map, but that interface doesn't implement
ndo_xdp_xmit()? Reject the insert! Etc.

That last bit can be added later, of course, but we need to make sure we
design the support in a way that it is possible to do so...

-Toke

