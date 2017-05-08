From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 8 May 2017 11:23:38 -0400
Subject: [Intel-wired-lan] e1000e echo request response latency and
	tcph->ack
In-Reply-To: <CAF=yD-+CpkwaEZeZA3UR4CLoqYQfUb-srBd-gew98=PjxTYauw@mail.gmail.com>
References: <CAF=yD-+CpkwaEZeZA3UR4CLoqYQfUb-srBd-gew98=PjxTYauw@mail.gmail.com>
Message-ID: <CAF=yD-LswC=sB4WiYx6rEJd5VSsGpVNkY_4YG+DKNXFb-EgVfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 2, 2017 at 1:15 PM, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> With RR tests on a pair of 82571EB I am seeing much lower latency with
> TCP (40 usec) vs UDP (105 usec). But only for TCP with the ACK bit
> set.
>
> I observed the initial TCP vs UDP results with sockperf.  Digging into
> this behavior by emulating the protocol headers with packet sockets
> show that just toggling the ACK bit changes this behavior. I shared
> the test program that does this on github [1].
>
> Is this known behavior? Is there some fast path on the NIC triggered
> only for TCP ACK packets? If so, then my real question is, is there a
> way to make UDP packets take this fast path?

Found the cause. This happens because because on the 82571 the default
setting for RxIntDelay (0) is overridden by BURST_RDTR (0x20) in
e1000_configure_tx.

                /* override the delay timers for enabling bursting, only if
                 * the value was not set by the user via module options
                 */
                if (adapter->rx_int_delay == DEFAULT_RDTR)
                        adapter->rx_int_delay = BURST_RDTR;
                if (adapter->rx_abs_int_delay == DEFAULT_RADV)
                        adapter->rx_abs_int_delay = BURST_RADV;

Loading the module with modprobe e1000e RxIntDelay=1 avoids that
branch and removes almost all of the latency. Loading the module
explicitly with modprobe e1000e RxIntDelay=0 probably should avoid
that burst mode, too. I can send a patch.

As a matter of fact, both RDTR and RADV should perhaps be set to 0
whenever the administrator sets ITR is set to 0 (e.g., as programmed
through ethtool -C ethX rx-usecs 0 tx-usecs 0).

Or even initialized to zero unconditionally. The 82571/82572 errata
lists "69. Receive Packet Delayed When Using RDTR or RADV Register."
with suggested workaround "It is recommended that the RDTR and RADV
registers not be used for moderating Rx interrupts. The preferred
solution is to use the Interrupt Throttling Register; ITR."
