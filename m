From: Alexander E. Patrakov <patrakov@gmail.com>
Date: Fri, 5 Jun 2020 16:18:48 +0500
Subject: [Intel-wired-lan] VLAN-aware bridge and i40e driver problem
Message-ID: <CAN_LGv1uTo2MNso8nT0adWXJ_wGbX5VoiNn9xKoJDR1q04g6FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

We have some new servers with this kind of dual-port 40GbE network
cards, supported by the in-tree i40e driver:

21:00.0 Ethernet controller [0200]: Intel Corporation Ethernet
Controller XL710 for 40GbE QSFP+ [8086:1583] (rev 02)
21:00.1 Ethernet controller [0200]: Intel Corporation Ethernet
Controller XL710 for 40GbE QSFP+ [8086:1583] (rev 02)

On each server, the two network ports (exposed as enp33s0f0 and
enp33s0f1) are used as slaves of the "bond0" interface, which is
itself used as a port of a vlan-aware bridge (vmbr0). There are tap
interfaces for KVM virtual machines that are also in this bridge, and
assigned to different VLANs as needed. The bond0 interface carries all
VLANs, and is essentially used as a "trunk port".

This is Proxmox (a Debian-based system), so the VLANs are added to the
bond0 interface at boot time via the /etc/network/if-up.d/bridgevlan
script, which runs essentially this:

    port=bond0
    bridge vlan add dev $port vid 2-4094

And here is why this behaves badly.

The "bridge" command does send the whole "add vids" request as a
single netlink message, so there are no inefficiencies at this step.
Then, the bond driver attempts to pass down the VLAN filter down to
the underlying hardware (i.e. to the i40e driver), and that's where
things go downhill.

Apparently the driver attempts to add the VIDs to the hardware filter
one-by-one. And then, after adding 256 VIDs, it hits the hardware
limit and complains:

    i40e 0000:21:00.0: Error I40E_AQ_RC_ENOSPC, forcing overflow
promiscuous on PF

And then goes on to process the next VID, also noticing that it is
beyond the hardware limit, and so on. Result: 3839 lines of log spam
from each network port, and more than 1 minute spent fighting with the
hardware (i.e. slow boot). After that, VLAN filtering and dispatching
of packets to VMs are done in software, and done correctly.

In this setup, the hardware VLAN filtering capability of the card is
useless, because there is actually nothing to filter out from the
wire. However, the slow boot and the log spam annoy sysadmins here. It
would have been better if the i40e driver somehow saw beforehand that
the whole VLAN filtering request is beyond the abilities of the
hardware, and did not attempt to add, fruitlessly, the VID entries
one-by-one. After all, on other servers, with "Mellanox Technologies
MT27700 Family [ConnectX-4] [15b3:1013]" (mlx5_core driver), it takes
less than 1 second to add these VLANs to bond0. Is it because the
Mellanox card is somehow better, or is it just a gross inefficiency of
the i40e driver? Could anyone familiar with the card please try to fix
the i40e driver?

I have tried to force the VLAN filtering in software, via ethtool:

    ethtool -K enp33s0f0 rx-vlan-filter off

But it doesn't work, because (since at least commit
b0fe3306432796c8f7adbede8ccd479bb7b53d0a, which adds it to
netdev->features but not netdev->hw_features) this is not a
user-changeable option on i40e. Question to the driver maintainers:
why is it so?

P.S. We have finally found and adopted this workaround:

    ethtool -K bond0 rx-vlan-filter off

...and things work reasonably well: fast boot, no log spam, okay-ish
performance (14.5 Gbps per CPU core).

P.P.S. I suspect that it would have been better to use macvlan instead
of the VLAN-aware bridge, but for legacy reasons we can't do that.

-- 
Alexander E. Patrakov
CV: http://pc.cd/PLz7
