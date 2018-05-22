From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 22 May 2018 11:23:58 -0700
Subject: [Intel-wired-lan] Regression: Approximate 34% performance hit
 in receive throughput over ixgbe seen due to build_skb patch
In-Reply-To: <A940030A-CDBF-41CD-816F-0BBC76E7C4F4@oracle.com>
References: <A940030A-CDBF-41CD-816F-0BBC76E7C4F4@oracle.com>
Message-ID: <CAKgT0Ud2qriAkWcs56WEkw2vhYzBbWvzZOoY24ndsqPKaWn=Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 22, 2018 at 11:00 AM, William Kucharski
<william.kucharski@oracle.com> wrote:
> A performance hit of approximately 34% in receive numbers for some packet sizes is
> seen when testing traffic over ixgbe links using the network test netperf.
>
> Starting with the top of tree commit 7addb3e4ad3db6a95a953c59884921b5883dcdec,
> a git bisect narrowed the issue down to:
>
> commit 6f429223b31c550b835b4f066ac034d0cf0cc71e
>
>     ixgbe: Add support for build_skb
>
>     This patch adds build_skb support to the Rx path.  There are several
>     advantages to this change.
>
>     1.  It avoids the memcpy and skb->head allocation for small packets which
>         improves performance by about 5% in my tests.
>     2.  It avoids the memcpy, skb->head allocation, and eth_get_headlen
>         for larger packets improving performance by about 10% in my tests.
>     3.  For VXLAN packets it allows the full header to be in skb->data which
>         improves the performance by as much as 30% in some of my tests.
>
> Netperf was sourced from:
>
>     https://hewlettpackard.github.io/netperf/
>
> Two machines were directly connected via ixgbe links.
>
> The process "netserver" was started on 10.196.11.8, and running this test:
>
> # netperf -l 60 -H 10.196.11.8 -i 10,2 -I 99,10 -t UDP_STREAM -- -m 64 -s 32768 -S 32768

Okay, so I can already see what the most likely issue is. The
build_skb code is more CPU efficient, but it will consume more memory
in the process since it is avoiding the memcpy and is instead using a
full 2K block of memory for a small frame. I'm suspecting any
performance issue you are seeing may be due to a slow interrupt rate
causing us to either exhaust available Tx memory, or overrun the
available Rx memory.

There end up being multiple ways to address this.
1. Use a larger value for your "-s/-S" values to allow for more memory
to be handled in the queues.
2. Update the interrupt moderation code for the driver. You can either
manually decrease the per-interrupt delay via "ethtool -C" or just
update the adaptive ITR code, see commit b4ded8327fea ("ixgbe: Update
adaptive ITR algorithm").
3. There should be a private flag that can be updated via "ethtool
--set-priv-flags" called "legacy-rx" that you can enable that will
roll back to the original that did the copy-break type approach for
small packets and the headers of the frame.

Thanks.

- Alex
