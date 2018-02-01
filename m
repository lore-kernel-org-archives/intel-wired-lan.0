From: Ray Bellis <ray@isc.org>
Date: Thu, 1 Feb 2018 09:10:35 +0000
Subject: [Intel-wired-lan] X710 disable flow hashing?
In-Reply-To: <CAKgT0UdBA9KiCx93xfsYLpw3HhEx+kc1kasR5rRcD5Nekd6Ynw@mail.gmail.com>
References: <1d4c6e02-2800-1ecb-4e6d-88410837ff8c@isc.org>
 <CAKgT0UdBA9KiCx93xfsYLpw3HhEx+kc1kasR5rRcD5Nekd6Ynw@mail.gmail.com>
Message-ID: <4709cf54-5c87-d499-65dc-f420e8efb4ae@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 31/01/2018 17:46, Alexander Duyck wrote:

> Generally what I have found works for me is to use Flow Director rules
> based on the source/destination IP and source/destination port numbers
> and then have my traffic generator alter either the source IP or
> source port for the traffic in order to get the round robin effect
> without necessarily having to modify the driver. For example pktgen
> supports something like this by specifying a port range when
> generating a flow.

The traffic generator I'm using can only produce a very limited range of
source port numbers (24), which is insufficient to produce an even
distribution in the queues with flow hashing.

In fact, with that small a range I consistently get _no traffic at all_
to one of my 12 queues.   See for example this one second snapshot of
the per-queue RX rates:

   0      25856
   1      50669
   2      37624
   3          0
   4      35778
   5      13002
   6      24228
   7      35615
   8      24812
   9      22804
  10      26047
  11      50831

I suppose that with only 24 source ports I could perhaps create 24
individual flow director rules, though?

> This is a pretty old version of the driver. Does it need to be that
> specific driver or could you work with a later version such as the one
> provided by e1000.sf.net.  If driver only modifications don't concern
> you then probably the e1000.sf.net driver might be the best way to go
> since all you need to do is get it to a functional version that meets
> your needs and then you could probably just lock in on that version
> for all future tests.

For now, it needs to be that version.  See threads from November '16
where I reported a significant 50% regression in PPS rates when
upgrading beyond 1.3.9.

> I assume you must be benchmarking something up at the user-space
> layer. Hopefully my suggestions work for you, if not let me know.

Yes, I'm benchmarking DNS server software.

(https://www.isc.org/blogs/isc-performance-lab/)

kind regards,

Ray

