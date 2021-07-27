From: Yuvaraj Ranganathan <yranganathan@juniper.net>
Date: Tue, 27 Jul 2021 06:23:00 +0000
Subject: [Intel-wired-lan] Traffic not passing for VLAN ID >= 32 on the I350
 SR-IOV enabled NIC
Message-ID: <BY3PR05MB835694E97F5EA0D60B0DD2B3CAE99@BY3PR05MB8356.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Team,

With the SR-IOV enabled on I350 NIC which has 4 VF?s, on configuring VLAN ID from range 1 to 31 on the VM interface, network traffic is fine and no issues. When trying to create an interface with VLAN ID >= 32 on the VM, traffic is not passing to that interface and as per HW specs, VLAN ID?s from 1 to 4096 are supported.

VM?s interface is directly mapped to one of the VF on I350 NIC. I am using IGB PF driver version 5.7.2(latest).

Could somebody please help!

Thanks in advance,
Yuvaraj.


Juniper Business Use Only
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210727/19cc49b5/attachment.html>
