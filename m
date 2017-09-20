From: levipearson@gmail.com <levipearson@gmail.com>
Date: Tue, 19 Sep 2017 23:17:54 -0600
Subject: [Intel-wired-lan] TSN Scorecard,
	was Re: [RFC net-next 0/5] TSN: Add qdisc-based config interfaces
	for traffic shapers
In-Reply-To: <20170918081248.txhars53icbqsvld@localhost>
References: <20170918081248.txhars53icbqsvld@localhost>
Message-ID: <20170920051754.21745-1-levipearson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 18, 2017, Richard Cochran wrote:
> Just for the record, here is my score card showing the current status
> of TSN support in Linux.  Comments and corrections are more welcome.
> 
> Thanks,
> Richard
> 
> 
>  | FEATURE                                        | STANDARD            | STATUS                       |
>  |------------------------------------------------+---------------------+------------------------------|
>  | Synchronization                                | 802.1AS-2011        | Implemented in               |
>  |                                                |                     | - Linux kernel PHC subsystem |
>  |                                                |                     | - linuxptp (userspace)       |
>  |------------------------------------------------+---------------------+------------------------------|

An alternate implementation of the userspace portion of gPTP is also available at [1]

>  | Forwarding and Queuing Enhancements            | 802.1Q-2014 sec. 34 | RFC posted (this thread)     |
>  | for Time-Sensitive Streams (FQTSS)             |                     |                              |
>  |------------------------------------------------+---------------------+------------------------------|
>  | Stream Reservation Protocol (SRP)              | 802.1Q-2014 sec. 35 | in Open-AVB [1]              |
>  |------------------------------------------------+---------------------+------------------------------|
>  | Audio Video Transport Protocol (AVTP)          | IEEE 1722-2011      | DNE                          |
>  |------------------------------------------------+---------------------+------------------------------|
>  | Audio/Video Device Discovery, Enumeration,     | IEEE 1722.1-2013    | jdksavdecc-c [2]             |
>  | Connection Management and Control (AVDECC)     |                     |                              |
>  | AVDECC Connection Management Protocol (ACMP)   |                     |                              |
>  | AVDECC Enumeration and Control Protocol (AECP) |                     |                              |
>  | MAC Address Acquisition Protocol (MAAP)        |                     | in Open-AVB                  |
>  |------------------------------------------------+---------------------+------------------------------|

All of the above are available to some degree in the AVTP Pipeline part of [1], specifically at this
location: https://github.com/AVnu/OpenAvnu/tree/master/lib/avtp_pipeline

The code is very modular and configurable, although some parts are in better shape than others. The AVTP
portion can use the custom userspace driver for the i210, which can be configured to use launch scheduling,
or it can use standard kernel interfaces via sendmsg or PACKET_MMAP. It runs as-is when configured for
standard interfaces with any network hardware that supports gPTP. I previously implemented a CMSG-based
launch time scheduling mechanism like the one you have proposed, and I have a socket backend for it that
could easily be ported to your proposal. It is not part of the repository yet since there's no kernel
support for it outside of my prototype and your RFC.

It is currently tied to the OpenAvnu gPTP daemon rather than linuxptp, as it uses a shared memory interface
to get the current rate-ratio and offset information between the various clocks. There may be better ways
to do this, but that's how the initial port of the codebase was done. It would be nice to get it working
with linuxptp's userspace tools at some point as well, though.

The libraries under avtp_pipeline are designed to be used separately, but a simple integrated application
is provided and is built by the CI system.

In addition to OpenAvnu, Renesas has a number of github repositories with what looks like a fairly
complete media streaming system:

https://github.com/renesas-rcar/avb-mse
https://github.com/renesas-rcar/avb-streaming
https://github.com/renesas-rcar/avb-applications

I haven't examined them in great detail yet, though.


>  | Frame Preemption                               | P802.1Qbu           | DNE                          |
>  | Scheduled Traffic                              | P802.1Qbv           | RFC posted (SO_TXTIME)       |
>  | SRP Enhancements and Performance Improvements  | P802.1Qcc           | DNE                          |
> 
>  DNE = Does Not Exist (to my knowledge)

Although your SO_TXTIME proposal could certainly form the basis of an endpoint's implementation of Qbv, I
think it is a stretch to consider it a Qbv implementation in itself, if that's what you mean by this.

I have been working with colleagues on some experiments relating to a Linux-controlled DSN switch
(a Marvell Topaz) that are a part of this effort in TSN: 

http://ieee802.org/1/files/public/docs2017/tsn-cgunther-802-3cg-multidrop-0917-v01.pdf

The proper interfaces for the Qbv configuration and managing of switch-level PTP timestamps are not yet
in place, so there's nothing even at RFC stage to present yet, but Qbv-capable Linux-managed switch
hardware is available and we hope to get some reusable code published even if it's not yet ready to be
integrated in the kernel.

> 
> 1. https://github.com/Avnu/OpenAvnu
> 
>    (DISCLAIMER from the website:)
> 
>    It is planned to eventually include the various packet encapsulation types,
>    protocol discovery daemons, libraries to convert media clocks to AVB clocks
>    and vice versa, and drivers.
> 
>    This repository does not include all components required to build a full
>    production AVB/TSN system (e.g. a turnkey solution to stream stored or live audio
>    or video content). Some simple example applications are provided which
>    illustrate the flow - but a professional Audio/Video system requires a full media stack
>    - including audio and video inputs and outputs, media processing elements, and
>    various graphical user interfaces. Various companies provide such integrated
>    solutions.

A bit of progress has been made since that was written, although it is true that it's still not
quite complete and certainly not turnkey. The most glaring absence at the moment is the media
clock recovery portion of AVTP, but I am actively working on this.

> 
> 2. https://github.com/jdkoftinoff/jdksavdecc-c

This is pulled in as a dependency of the AVDECC code in OpenAvnu; it's used in the command line driven
controller, but not in the avtp_pipeline code that implements the endpoint AVDECC behavior. I don't think
either are complete by any means, but they are complete enough to be mostly compliant and usable in the
subset of behavior they support.

The bulk of the command line controller is a clone of: https://github.com/audioscience/avdecc-lib 

Things are maybe a bit farther along than they seemed, but there is still important kernel work to be
done to reduce the need for out-of-tree drivers and to get everyone on the same interfaces. I plan
to be an active participant going forward.


Levi
