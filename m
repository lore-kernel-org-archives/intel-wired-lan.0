From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 Sep 2016 17:47:32 -0700
Subject: [Intel-wired-lan] Packet reordering for single flow non-UDP and
 TCP packets on Intel X520 and i350 adapters
In-Reply-To: <CY4PR18MB12713709045504B86558A133E7F90@CY4PR18MB1271.namprd18.prod.outlook.com>
References: <CY4PR18MB12713709045504B86558A133E7F90@CY4PR18MB1271.namprd18.prod.outlook.com>
Message-ID: <CAKgT0Uej=vLiwMY7pKHPKee-ssuMpSc-Co_Xz1SJtu7Enj1iOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Sep 6, 2016 at 7:54 AM, Eugene Cookmeyer
<Eugene.Cookmeyer@viavisolutions.com> wrote:
> Apologies if this topic has been raised before ? I searched through the
> extent of available archives and did not see this raised recently?
>
>
>
> We have a Linux-based testing application running on a Quad-Core server that
> natively sends only IP experimental (IP type 255) packets for testing
> network bandwidth and packet ordering.  Essentially we?re sending IP packets
> that have the same IP addresses and the payload differs by our own
> proprietary header which involves timestamps and sequence numbers.
>
>
>
> With the exception of very low bandwidth testing, we always see some blocks
> of packets getting delivered to the receiving host out-of-sequence.  I?ve
> tried everything I can configuration-wise, from restricting the number of
> Tx/Rx queues down to 1 (via a linux driver change), assigning SMP affinity
> for everything I can to a single CPU, making sure interrupts are serviced on
> a single CPU.  It doesn?t seem to matter? The card appears deliver receive
> packets out of order occasionally.  I?ve tested on the X520 and i350 cards
> and they both exhibit this behavior.
>
>
>
> When I restrict everything to a single CPU performance throughput plummets ?
> but packet reordering persists.
>
>
>
> In normal TCP environments where multiple flows are coming from different
> clients this packet reordering would likely never show up ? however in a
> single flow situation I expect it would like I?m seeing.  Where TCP is
> involved, the TCP protocol layer would handle all retransmissions in these
> scenarios so this would mostly seem transparent to end-users.
>
>
>
> I?m looking for advice from the Intel driver guys on this ? is this
> something I can programmatically deal with or is this a card design related
> symptom?
>
>
>
> Maybe I?m missing a controllable parameter somewhere, but I don?t seem to
> know where else to look next.  The linux driver doesn?t appear to have all
> the configurability as the Windows version except some parameters are
> available through the ethtool utility,  thus my having to modify the driver
> to get the Tx/Rx queues running on a single CPU.
>
>
>
> Eugene Cookmeyer
>
> Viavi Solutions

Hi Eugene,

The only thing that comes to mind is possibly Transmit Packet
Steering, aka XPS.  It is enabled by default on the x520 and can cause
reordering issues if your application is hopping between CPUs.  It
shouldn't effect the i350 though.  You could try disabling XPS by
going through and echoing 0 to into all of the tx queues for each of
your transmitting devices.  A script like the one below should work:

#!/bin/bash
iface=<your interface name here>
for xps in `ls /sys/class/net/$iface/queues/tx-*/xps_cpus`
do
  echo 0 > $xps
done

Other than that I can't think of too much else that should be able to
cause reordering at the driver level.  I would suspect this is
probably an issue with the Tx side and not the Rx, so you might want
to try isolating to verify if that is in fact the case.

Above the driver level if you are using your experimental protocol to
do tunnelling you might want to watch out for netif_rx.  If your Rx
interrupts are being bounced around between CPUs it is possible that
netif_rx could be enqueueing the packets to different backlogs and
that could result in packets being received out of order.

- Alex
