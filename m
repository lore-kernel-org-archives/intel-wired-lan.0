From: Yuvaraj Ranganathan <yranganathan@juniper.net>
Date: Thu, 29 Jul 2021 09:37:16 +0000
Subject: [Intel-wired-lan] [E1000-devel] Traffic not passing for VLAN ID
 >= 32 on the I350 SR-IOV enabled NIC
In-Reply-To: <CAOAKi8yNzyj0yQNa1qNUAFuCdYUtE3fzZOW0=cSPUyd9THKg2A@mail.gmail.com>
References: <BY3PR05MB835694E97F5EA0D60B0DD2B3CAE99@BY3PR05MB8356.namprd05.prod.outlook.com>,
 <CAOAKi8yNzyj0yQNa1qNUAFuCdYUtE3fzZOW0=cSPUyd9THKg2A@mail.gmail.com>
Message-ID: <BY3PR05MB835660017E08EE8B6BC85AFFCAEB9@BY3PR05MB8356.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Laurent,

Thanks for your help.

Below is the information of SR-IOV interface, where VF 2 is directly mapped to VM interface.

root at local-node:~# ip link show heth-0-1
5: heth-0-1: <BROADCAST,MULTICAST,ALLMULTI,PROMISC,UP,LOWER_UP> mtu 9192 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 58:00:bb:aa:ee:49 brd ff:ff:ff:ff:ff:ff
    vf 0 MAC aa:81:c7:6f:b4:0a, spoof checking on, link-state auto, trust on
    vf 1 MAC 16:26:97:40:0f:86, spoof checking on, link-state auto, trust on
    vf 2 MAC 58:00:bb:aa:ee:60, spoof checking on, link-state auto, trust on
    vf 3 MAC 22:28:fa:f4:68:1a, spoof checking on, link-state auto, trust on
root at local-node:~#

On configuring the VLAN >=32 on the VM interface and tried sending outgoing traffic, there is no packet captured in tcpdump at SR-IOV(heth-0-1) interface. In case of VLAN <= 31, the outgoing packet captured in tcpdump at heth-0-1 interface.

You help is always appreciated!

Thanks,
Yuvaraj.

From: Laurent Dumont <laurentfdumont@gmail.com>
Date: Thursday, 29 July 2021 at 7:41 AM
To: Yuvaraj Ranganathan <yranganathan@juniper.net>
Cc: e1000-devel at lists.sourceforge.net <e1000-devel@lists.sourceforge.net>, intel-wired-lan at lists.osuosl.org <intel-wired-lan@lists.osuosl.org>, Pushp Saurav <psaurav@juniper.net>
Subject: Re: [E1000-devel] Traffic not passing for VLAN ID >= 32 on the I350 SR-IOV enabled NIC
[External Email. Be cautious of content]

Can you show the output of

ip link show $SRIOV_INT_NAME_HERE

Are you seeing any traffic reaching inside the VM if you tcpdump there?

On Tue, Jul 27, 2021 at 10:07 AM Yuvaraj Ranganathan via E1000-devel <e1000-devel at lists.sourceforge.net<mailto:e1000-devel@lists.sourceforge.net>> wrote:
Hi Team,

With the SR-IOV enabled on I350 NIC which has 4 VF?s, on configuring VLAN ID from range 1 to 31 on the VM interface, network traffic is fine and no issues. When trying to create an interface with VLAN ID >= 32 on the VM, traffic is not passing to that interface and as per HW specs, VLAN ID?s from 1 to 4096 are supported.

VM?s interface is directly mapped to one of the VF on I350 NIC. I am using IGB PF driver version 5.7.2(latest).

Could somebody please help!

Thanks in advance,
Yuvaraj.


Juniper Business Use Only

_______________________________________________
E1000-devel mailing list
E1000-devel at lists.sourceforge.net<mailto:E1000-devel@lists.sourceforge.net>
https://lists.sourceforge.net/lists/listinfo/e1000-devel<https://urldefense.com/v3/__https:/lists.sourceforge.net/lists/listinfo/e1000-devel__;!!NEt6yMaO-gk!XuSTry-yCsDfr50s_cea2F8i2aZsn1EgmahFyYNsHaHk47t9o3oazDYLdf8qTZlJS5Q$>
To learn more about Intel Ethernet, visit https://forums.intel.com/s/topic/0TO0P00000018NbWAI/intel-ethernet<https://urldefense.com/v3/__https:/forums.intel.com/s/topic/0TO0P00000018NbWAI/intel-ethernet__;!!NEt6yMaO-gk!XuSTry-yCsDfr50s_cea2F8i2aZsn1EgmahFyYNsHaHk47t9o3oazDYLdf8qBIRweU8$>


Juniper Business Use Only
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210729/8be33ee8/attachment-0001.html>
