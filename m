From: JD <jdtxs00@gmail.com>
Date: Fri, 30 Oct 2020 12:33:28 -0500
Subject: [Intel-wired-lan] i40e/iavf bandwidth spikes to 500Gbps & returning
 IAVF_ERR_PARAM
Message-ID: <CAMnf+PhD9VJH-db8nssDr9RgyJY6JV7bBL-Yvn2U87gSxfp+mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

Over the past month I've observed some KVM servers exhibiting
extremely high bandwidth activity (500gbit, which is impossible).
Please see the attached graphs from Prometheus. It starts small then
progressively gets worse over time.

During these spikes, I see the following appear on the KVM guest about
once every minute.
iavf 0000:00:05.0: PF returned error -5 (IAVF_ERR_PARAM) to our request 15

And on the KVM parent, I see this about once every minute:
i40e 0000:81:00.0: VF 20 failed opcode 15, retval: -5

This doesn't seem to happen with any obvious cause, the only other
thing I see in dmesg that may be related is the following (which is
repeated a few times over several hours, but not at the same rate)

vfio-pci 0000:81:0c.3: Event logged [IO_PAGE_FAULT domain=0x0000
address=0xfffffffdf8040000 flags=0x0008]


The KVM guest is running the iavf driver:
driver: iavf
version: 3.9.3

The KVM parent is running the i40e driver:
driver: i40e
version: 2.11.21

I'm running 2 of the following NIC's on the KVM parent in a bonded
setup (mode 4, hash policy 3+4, IEEE 802.3ad dynamic link aggregation)
:
Intel Corporation Ethernet Controller XXV710 for 25GbE SFP28 (rev 02)

Both the parent/guest are running the same kernel version of 4.19.107

I'm not sure whether this is a NIC issue, driver issue, or something
else. I'm happy to provide any more information about the system on
request if it is relevant (qemu versions, mobo/cpu/ram).  I've
observed this issue on 3 different KVM parents/guests in different
regions.

If this has already been fixed or is a known issue, then I apologize,
but I could not find anything by searching the mailing list w/ my
codes from dmesg.

If anyone can provide any information about this or any pointers on
this or how to narrow the issue down, I'd greatly appreciate it.

Thank you.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: prom-graph.png
Type: image/png
Size: 50550 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201030/dffc13c2/attachment-0001.png>
