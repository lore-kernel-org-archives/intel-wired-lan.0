From: Laurent Dumont <laurentfdumont@gmail.com>
Date: Wed, 28 Jul 2021 22:11:11 -0400
Subject: [Intel-wired-lan] [E1000-devel] Traffic not passing for VLAN ID
 >= 32 on the I350 SR-IOV enabled NIC
In-Reply-To: <BY3PR05MB835694E97F5EA0D60B0DD2B3CAE99@BY3PR05MB8356.namprd05.prod.outlook.com>
References: <BY3PR05MB835694E97F5EA0D60B0DD2B3CAE99@BY3PR05MB8356.namprd05.prod.outlook.com>
Message-ID: <CAOAKi8yNzyj0yQNa1qNUAFuCdYUtE3fzZOW0=cSPUyd9THKg2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Can you show the output of

ip link show $SRIOV_INT_NAME_HERE

Are you seeing any traffic reaching inside the VM if you tcpdump there?

On Tue, Jul 27, 2021 at 10:07 AM Yuvaraj Ranganathan via E1000-devel <
e1000-devel@lists.sourceforge.net> wrote:

> Hi Team,
>
> With the SR-IOV enabled on I350 NIC which has 4 VF?s, on configuring VLAN
> ID from range 1 to 31 on the VM interface, network traffic is fine and no
> issues. When trying to create an interface with VLAN ID >= 32 on the VM,
> traffic is not passing to that interface and as per HW specs, VLAN ID?s
> from 1 to 4096 are supported.
>
> VM?s interface is directly mapped to one of the VF on I350 NIC. I am using
> IGB PF driver version 5.7.2(latest).
>
> Could somebody please help!
>
> Thanks in advance,
> Yuvaraj.
>
>
> Juniper Business Use Only
>
> _______________________________________________
> E1000-devel mailing list
> E1000-devel at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/e1000-devel
> To learn more about Intel Ethernet, visit
> https://forums.intel.com/s/topic/0TO0P00000018NbWAI/intel-ethernet
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210728/6e31a24c/attachment-0001.html>
