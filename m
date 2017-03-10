From: Stefan Kooman <stefan@bit.nl>
Date: Fri, 10 Mar 2017 14:30:17 +0100
Subject: [Intel-wired-lan] TX driver issue detected, PF reset issued
Message-ID: <20170310133017.GA24542@shell.dmz.bit.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi list,

Today we ran into an issue with our test Ceph cluster:

Problem: TX driver issue detected, PF reset issued
Symptoms: LACP bond (openvswitch) not functioning anymore
Resolution: delete bond from bridge, rmmod i40e, modprobe i40e,
re-create bond

The hypervisor with VM's running with Ceph disk images hit this driver
issue.  We recently switched network adapters to new Intel X710-DA2
adapters in this server (see inventory.xml attached to this mail for
hardware / version info).

Our test setup:

Ubuntu 16.04.2 LTS with HWE kernel (currently 4.8.0.39.10).
Normal openvswitch bond (no DPDK):  (bond_mode=balance-tcp lacp=active
other_config:lacp-time=fast trunks=a_bunch_of_vlans)
Linux driver version: 1.6.11-k
Intel NVM version: firmware-version: 5.05 0x80002928 1.1313.0 (latest
available)

This issue seems to be triggered by high load. In this setup this
particular hypervisor is also the router for the Ceph (IPv6) network
(routing interfaces are tagged vlan ports on top of this bond). This PF
reset issue has been brought up earlier in an e-mail thread on this list
[1]. That issue seems to be related to specific stress testing tools. In
our setup we are using the linux kernel ip(v6) stack. I would really
like to find out what's triggering this issue. This type of event seems
to be called MMD (Malicious Driver Detection). How can one analyse these
MMD's? We currently have plenty of hardware to perform various (stress)
tests so if we need to build a special setup in order to analyse this
issue we have the ability to do so. Any help on this is highly
appreciated.

In the mean time we'll try to find a way to reliably reproduce this
issue.

Kind regards,

Stefan Kooman

[1]:
http://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20160314/004395.html

-- 
| BIT BV  http://www.bit.nl/        Kamer van Koophandel 09090351
| GPG: 0xD14839C6                   +31 318 648 688 / info at bit.nl
-------------- next part --------------
A non-text attachment was scrubbed...
Name: inventory.xml
Type: application/xml
Size: 4530 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170310/ecc8d658/attachment.xml>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: Digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170310/ecc8d658/attachment.asc>
