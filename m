From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 15 Dec 2017 13:25:37 -0800
Subject: [Intel-wired-lan] ixgbe driver - Link Modes
In-Reply-To: <02f03d55-67f9-c0e3-068a-4863629894ae@berginkonsult.se>
References: <02f03d55-67f9-c0e3-068a-4863629894ae@berginkonsult.se>
Message-ID: <CAKgT0Ufpxsb9VW1QXAUwert2Z+-aD10OCfA=wYCQ_qF_12_HHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Dec 15, 2017 at 5:31 AM, Peter Bergin <peter@berginkonsult.se> wrote:
> Hi,
>
> I'm currently working with a kernel upgrade in a system using Intel 82599EB
> 10Gb NIC. The kernel will be changed from version 3.4 to 4.1. When looking
> into the details with 'ethtool' I see a difference in the 'Supported link
> modes:' and 'Advertised link modes:' fields between the kernels on same
> hardware. Can anyone help me understand this difference and if it is
> critical or not?
>
> Thanks,
> /Peter
>
> With kernel 3.4:
>
> ~ # ethtool eth6
> Settings for eth6:
> Supported ports: [ FIBRE ]
> Supported link modes: 1000baseT/Full
> 10000baseT/Full
> Supports auto-negotiation: Yes
> Advertised link modes: 1000baseT/Full
> 10000baseT/Full
> Advertised pause frame use: No
> Advertised auto-negotiation: Yes
> Speed: 10000Mb/s
> Duplex: Full
> Port: Other
> PHYAD: 0
> Transceiver: external
> Auto-negotiation: on
> Supports Wake-on: umbg
> Wake-on: g
> Current message level: 0x00000007 (7)
> drv probe link
> Link detected: yes
>
> ~ # ethtool -i eth6
> driver: ixgbe
> version: 3.8.21-k
> firmware-version: 0x800000c9
> bus-info: 0000:05:00.1
>
>
>
> With kernel 4.1:
>
> ~ # ethtool eth6
> Settings for eth6:
> Supported ports: [ FIBRE ]
> Supported link modes: 1000baseT/Full
> Supports auto-negotiation: Yes
> Advertised link modes: 1000baseT/Full
> Advertised pause frame use: No
> Advertised auto-negotiation: Yes
> Speed: 10000Mb/s
> Duplex: Full
> Port: Other
> PHYAD: 0
> Transceiver: external
> Auto-negotiation: on
> Supports Wake-on: umbg
> Wake-on: g
> Current message level: 0x00000007 (7)
> drv probe link
> Link detected: yes
>
> ~ # ethtool -i eth6
> driver: ixgbe
> version: 4.4.0-k
> firmware-version: 0x800000c9
> bus-info: 0000:05:00.1

What is the SFP you are using to get link? The fact that it is saying
it only supports 1G when it is already connected at 10G is most likely
a bug of some sort. I'll see what we can do to reproduce and root
cause the issue. Also is there any chance you could try testing with
either out out-of-tree driver at e1000.sf.net or try testing with the
latest kernel to see if the issue has already been resolved there?

Thanks.

- Alex
