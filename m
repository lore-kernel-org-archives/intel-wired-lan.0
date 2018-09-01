From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 31 Aug 2018 19:01:41 -0700
Subject: [Intel-wired-lan] igb Detected Tx Unit Hang after upgrade to
 4.18-rc6 [was Re: igb Detected Tx Unit Hang after upgrade to 4.17]
In-Reply-To: <231579625.943257.1535706026202@mail.libero.it>
References: <528200032.321946.1528186357567@mail.libero.it>
 <963322856.1365958.1530796944033@mail.libero.it>
 <931347915.758706.1532606173777@mail.libero.it>
 <CAKgT0UdmzKG6usaHqFt2N4q1FVX-8r58hbhWb9dc8ygS2UmKWQ@mail.gmail.com>
 <1265852288.743881.1532617415845@mail.libero.it>
 <CAKgT0Ud3CMQBKabty07ordkeDPoaaWK3_q3rMoAh7XMSJMSE9g@mail.gmail.com>
 <1312873949.790150.1532681266921@mail.libero.it>
 <117857591.886490.1532956286262@mail.libero.it>
 <403709248.209641.1533555587417@mail.libero.it>
 <978998680.826474.1535469615050@mail.libero.it>
 <CAKgT0Ueo7by0AuVocZiieZuv=ZhL9_FSP8R8yXndZwU1+eV-Mg@mail.gmail.com>
 <231579625.943257.1535706026202@mail.libero.it>
Message-ID: <CAKgT0UcKxnUK-5E-hr+DHLMAXQtzad21XNuoskh5k8O0Nia7PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Aug 31, 2018 at 2:00 AM Marco Berizzi <pupilla@libero.it> wrote:
>
> > Il 28 agosto 2018 alle 19.01 Alexander Duyck <alexander.duyck@gmail.com> ha scritto:
>
> > Okay, so this looks like a Tx hang of some sort where writeback is not
> > being triggered.
> >
> > What we may want do is turn up the level of information we are getting
> > out of the error. You can do that by running:
> > ethtool -s eth0 msglvl hw on tx_done on pktdata on
> >
> > That should cause us to dump the Tx descriptor rings and packet data
> > when we encounter one of these hangs. It is possible we are looking at
> > some sort of error in the way the data is being formatted on the
> > descriptor ring that is resulting int he device stopping on whatever
> > descriptor is at offset .
>
> Hello Alexander, everyone
>
> Here is the output:
>
> [2712507.323017] igb 0000:08:00.0: Detected Tx Unit Hang
>                    Tx Queue             <1>
>                    TDH                  <7c>
>                    TDT                  <7c>
>                    next_to_use          <7d>
>                    next_to_clean        <7c>
>                  buffer_info[next_to_clean]
>                    time_stamp           <1a1a98a00>
>                    next_to_watch        <00000000c658a9f5>
>                    jiffies              <1a1a98e00>
>                    desc.status          <a8010>

<snip>

> [2712515.514954] igb 0000:08:00.0: TX Rings Summary
> [2712515.514954] igb: Queue [NTU] [NTC] [bi(ntc)->dma  ] leng ntw timestamp
> [2712515.514957] igb:      0    E7    E7 00000000FF71E7C0 0000           (null) 00000001A1A8B476
> [2712515.514959] igb:      1    7D    7C 00000000FF6E6C02 002A 00000000c658a9f5 00000001A1A98A00
> [2712515.514961] igb:      2    3C    3C 00000000FF375D40 0000           (null) 00000001A1A951B0
> [2712515.514962] igb:      3    15    15 00000000FF709040 0000           (null) 00000001A1A6FB5E
> [2712515.514963] igb 0000:08:00.0: TX Rings Dump

<snip>

> [2712515.515457] igb: ------------------------------------
> [2712515.515458] igb: TX QUEUE INDEX = 1
> [2712515.515458] igb: ------------------------------------
> [2712515.515459] igb: T [desc]     [address 63:0  ] [PlPOCIStDDM Ln] [bi->dma       ] leng  ntw timestamp        bi->skb

<snip>

> [2712515.515677] igb: T [0x078]    00000000FEFCB000 0010C0192B300043 00000000FEFCB000 0000            (null) 00000001A1A98667 00000000c5ed1096
> [2712515.515679] igb: T [0x079]    00000000FD7DBE40 001000192B300040 00000000FD7DBE40 0000            (null) 00000001A1A98671 000000002e13a21e
> [2712515.515681] igb: T [0x07A]    00000000FF930C80 000F00192B30003C 00000000FF930C80 0000            (null) 00000001A1A98672 000000009976f72e
> [2712515.515682] igb: T [0x07B]    00000000FF71CAC0 000F00192B30003C 00000000FF71CAC0 0000            (null) 00000001A1A98675 000000000339ac31
> [2712515.515684] igb: T [0x07C]    00000000FF6E6C02 000A80102B30002A 00000000FF6E6C02 002A  00000000c658a9f5 00000001A1A98A00 00000000b1f60b47 NTC
> [2712515.515687] 00000000d7c2311d: b4 96 91 0e fd 1f 00 19 99 ab 0b 38 08 06 00 01  ...........8....
> [2712515.515687] 00000000922018be: 08 00 06 04 00 01 00 19 99 ab 0b 38 0a 51 6e 0f  ...........8.Qn.
> [2712515.515688] 00000000a423f9da: 00 00 00 00 00 00 0a 51 6e fe                    .......Qn.
> [2712515.515690] igb: T [0x07D]    0000000000001C14 0000001020200800 00000000FEFAB46A 0000            (null) 00000001A1A8883A 0000000047f33a64 NTU
> [2712515.515692] igb: T [0x07E]    00000000FEFAB46A 00AA821122300036 00000000FF542D00 0000            (null) 00000001A1A83F2A 00000000b9702733
> [2712515.515694] igb: T [0x07F]    00000000FF1EC508 000000092B300274 00000000FF1EC508 0000            (null) 00000001A1A83F2E 00000000bd02a543

Okay so looking over the data everything here is correct except for
the fact that NTU and the tail register values don't match. The only
way that should be able to happen is if the xmit_more hint is set on
the packet, which unfortunately we don't dump.

However with that being said it does occur to me that you mentioned
using VirtualBox. I dug back through the dmesg output and found the
line:
[   20.944982] VBoxNetFlt: attached to 'eth0' / 00:19:99:ab:0b:38

I think there may be an issue with the filter stripping out packets at
the end of a queue and as a result we are receiving packets with
xmit_more set and not updating tail. At least that is my understanding
of things for now as I am not that familiar with the VBoxNetFlt
driver.

There are two ways to verify if this is the case. The first and more
correct solution might be to look at updating
vboxNetFltLinuxStartXmitFilter so that it will clear the xmit_more bit
before handing it off to the lower device. If you don't have access to
that an alternative would be to just modify the igb driver you have so
that you replace "skb->xmit_more" with "true" and just force the tail
to always be written out. It will cause a small performance hit but it
will work around the issue in the driver that overwrote our network
device ops.

Hope that helps.

- Alex
