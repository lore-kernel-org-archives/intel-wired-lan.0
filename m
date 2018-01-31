From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 31 Jan 2018 09:46:44 -0800
Subject: [Intel-wired-lan] X710 disable flow hashing?
In-Reply-To: <1d4c6e02-2800-1ecb-4e6d-88410837ff8c@isc.org>
References: <1d4c6e02-2800-1ecb-4e6d-88410837ff8c@isc.org>
Message-ID: <CAKgT0UdBA9KiCx93xfsYLpw3HhEx+kc1kasR5rRcD5Nekd6Ynw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 31, 2018 at 7:15 AM, Ray Bellis <ray@isc.org> wrote:
> Hi,
>
> Is there a way to make an X710 card just deliver UDP packets to its
> queues (12 in my case) round-robin without using flow hashing?

Generally what I have found works for me is to use Flow Director rules
based on the source/destination IP and source/destination port numbers
and then have my traffic generator alter either the source IP or
source port for the traffic in order to get the round robin effect
without necessarily having to modify the driver. For example pktgen
supports something like this by specifying a port range when
generating a flow.

> I'm using Fedora Core 23 with i40e driver version 1.3.9-k.

This is a pretty old version of the driver. Does it need to be that
specific driver or could you work with a later version such as the one
provided by e1000.sf.net.  If driver only modifications don't concern
you then probably the e1000.sf.net driver might be the best way to go
since all you need to do is get it to a functional version that meets
your needs and then you could probably just lock in on that version
for all future tests.

> I know that's old, but I need to preserve this environment for long-term
> benchmark comparisons.

I assume you must be benchmarking something up at the user-space
layer. Hopefully my suggestions work for you, if not let me know.

Thanks.

- Alex
