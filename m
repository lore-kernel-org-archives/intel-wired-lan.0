From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 20 Sep 2017 07:49:19 +0200
Subject: [Intel-wired-lan] TSN Scorecard,
 was Re: [RFC net-next 0/5] TSN: Add qdisc-based config interfaces
 for traffic shapers
In-Reply-To: <20170920051754.21745-1-levipearson@gmail.com>
References: <20170918081248.txhars53icbqsvld@localhost>
 <20170920051754.21745-1-levipearson@gmail.com>
Message-ID: <20170920054919.jtqckuybsu42tvpk@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Sep 19, 2017 at 11:17:54PM -0600, levipearson at gmail.com wrote:
> In addition to OpenAvnu, Renesas has a number of github repositories with what looks like a fairly
> complete media streaming system:

Is it a generic stack or a set of hacks for their HW?

> Although your SO_TXTIME proposal could certainly form the basis of an endpoint's implementation of Qbv, I
> think it is a stretch to consider it a Qbv implementation in itself, if that's what you mean by this.

No, that is not what I meant.  We need some minimal additional kernel
support in order to fully implement the TSN family of standards.  Of
course, the bulk will have to be done in user space.  It would be a
mistake to cram the stuff that belongs in userland into the kernel.

Looking at the table, and reading your descriptions of the state of
OpenAVB, I remained convinced that the kernel needs only three
additions:

1. SO_TXTIME
2. CBS Qdisc
3. ALSA support for DAC clock control (but that is another story)

> The proper interfaces for the Qbv configuration and managing of switch-level PTP timestamps are not yet
> in place, so there's nothing even at RFC stage to present yet, but Qbv-capable Linux-managed switch
> hardware is available and we hope to get some reusable code published even if it's not yet ready to be
> integrated in the kernel.

Right, configuring Qbv in an attached DSA switch needs its own
interface.

Regarding PHC support for DSA switches, I have something in the works
to be published soon.

> A bit of progress has been made since that was written, although it is true that it's still not
> quite complete and certainly not turnkey.

So OpenAVB is neither complete nor turnkey.  That was my impression,
too.

> Things are maybe a bit farther along than they seemed, but there is still important kernel work to be
> done to reduce the need for out-of-tree drivers and to get everyone on the same interfaces. I plan
> to be an active participant going forward.

You mentioned a couple of different kernel things you implemented.
I would encourage you to post the work already done.

Thanks,
Richard
