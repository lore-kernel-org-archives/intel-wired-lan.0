From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 7 Dec 2016 08:48:58 -0800
Subject: [Intel-wired-lan] ixgbe Port cannot load,
	"failed to register GSI"
In-Reply-To: <60fc28f5-9780-dc04-2721-043412d23d31@candelatech.com>
References: <60fc28f5-9780-dc04-2721-043412d23d31@candelatech.com>
Message-ID: <CAKgT0Uf2UGQabeoZeW1NudmmORnMiG8fmtAv3gD3_cfruNDscQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Dec 6, 2016 at 3:22 PM, Ben Greear <greearb@candelatech.com> wrote:
> We put 3 10-g dual-port ixgbe NICs and 4 4-port I350 NICs in a 2U rackmount,
> and one of the ixgbe ports
> fails to come up.  This previously worked before reboot, so maybe it is a
> race somehow.  Kernel is 4.4.11+,
> but not hacks to ixgbe or I350 drivers.
>
> Anyone know if there is some sort of way to make this work reliably?
>
> dmesg | grep ixgbe
>
> [    5.803307] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver -
> version 4.2.1-k
> [    5.803309] ixgbe: Copyright (c) 1999-2015 Intel Corporation.
> [    5.952119] ixgbe 0000:04:00.0: Multiqueue Enabled: Rx Queue count = 8,
> Tx Queue count = 8
> [    5.952245] ixgbe 0000:04:00.0: PCI Express bandwidth of 32GT/s available
> [    5.952246] ixgbe 0000:04:00.0: (Speed:5.0GT/s, Width: x8, Encoding
> Loss:20%)
> [    5.952328] ixgbe 0000:04:00.0: MAC: 2, PHY: 15, SFP+: 5, PBA No:
> FFFFFF-0FF
> [    5.952330] ixgbe 0000:04:00.0: 00:e0:ed:77:09:16
> [    5.954004] ixgbe 0000:04:00.0: Intel(R) 10 Gigabit Network Connection
> [    6.102346] ixgbe 0000:04:00.1: Multiqueue Enabled: Rx Queue count = 8,
> Tx Queue count = 8
> [    6.102475] ixgbe 0000:04:00.1: PCI Express bandwidth of 32GT/s available
> [    6.102478] ixgbe 0000:04:00.1: (Speed:5.0GT/s, Width: x8, Encoding
> Loss:20%)
> [    6.102562] ixgbe 0000:04:00.1: MAC: 2, PHY: 15, SFP+: 6, PBA No:
> FFFFFF-0FF
> [    6.102564] ixgbe 0000:04:00.1: 00:e0:ed:77:09:17
> [    6.104869] ixgbe 0000:04:00.1: Intel(R) 10 Gigabit Network Connection
> [    6.253429] ixgbe 0000:05:00.0: Multiqueue Enabled: Rx Queue count = 8,
> Tx Queue count = 8
> [    6.253558] ixgbe 0000:05:00.0: PCI Express bandwidth of 32GT/s available
> [    6.253560] ixgbe 0000:05:00.0: (Speed:5.0GT/s, Width: x8, Encoding
> Loss:20%)
> [    6.253644] ixgbe 0000:05:00.0: MAC: 2, PHY: 15, SFP+: 5, PBA No:
> FFFFFF-0FF
> [    6.253646] ixgbe 0000:05:00.0: 00:e0:ed:79:06:50
> [    6.255855] ixgbe 0000:05:00.0: Intel(R) 10 Gigabit Network Connection
> [    6.404128] ixgbe 0000:05:00.1: Multiqueue Enabled: Rx Queue count = 8,
> Tx Queue count = 8
> [    6.404254] ixgbe 0000:05:00.1: PCI Express bandwidth of 32GT/s available
> [    6.404255] ixgbe 0000:05:00.1: (Speed:5.0GT/s, Width: x8, Encoding
> Loss:20%)
> [    6.404337] ixgbe 0000:05:00.1: MAC: 2, PHY: 15, SFP+: 6, PBA No:
> FFFFFF-0FF
> [    6.404339] ixgbe 0000:05:00.1: 00:e0:ed:79:06:51
> [    6.405914] ixgbe 0000:05:00.1: Intel(R) 10 Gigabit Network Connection
> [    6.554373] ixgbe 0000:06:00.0: Multiqueue Enabled: Rx Queue count = 8,
> Tx Queue count = 8
> [    6.554501] ixgbe 0000:06:00.0: PCI Express bandwidth of 32GT/s available
> [    6.554504] ixgbe 0000:06:00.0: (Speed:5.0GT/s, Width: x8, Encoding
> Loss:20%)
> [    6.554588] ixgbe 0000:06:00.0: MAC: 2, PHY: 15, SFP+: 5, PBA No:
> FFFFFF-0FF
> [    6.554590] ixgbe 0000:06:00.0: 00:e0:ed:79:06:56
> [    6.556994] ixgbe 0000:06:00.0: Intel(R) 10 Gigabit Network Connection
> [    6.557160] ixgbe 0000:06:00.1: PCI INT B: failed to register GSI
> [    6.557169] ixgbe: probe of 0000:06:00.1 failed with error -28
>
> Thanks,
> Ben
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>

I'm adding e1000-devel and intel-wired-lan as they would be a better
place for an ixgbe question.

It might be useful if you could also provide an "lspci -vvv" for the
system, or at least for the network ports so that we can verify if
enough resources are present in terms of memory to allocate memory for
MMIO on all the devices.  Also any info you could provide on the
platform itself would be useful as it is possible what you are seeing
is a resource constraint as the GSI error seems to indicate ACPI is
having some sort of issue.

- Alex
