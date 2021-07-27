From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Tue, 27 Jul 2021 16:04:19 +0000
Subject: [Intel-wired-lan] [E1000-devel] Traffic not passing for VLAN ID
 >= 32 on the I350 SR-IOV enabled NIC
In-Reply-To: <CO6PR11MB5652E3BC545B93D49C86B3D6EFE99@CO6PR11MB5652.namprd11.prod.outlook.com>
References: <BY3PR05MB835694E97F5EA0D60B0DD2B3CAE99@BY3PR05MB8356.namprd05.prod.outlook.com>
 <CO6PR11MB5652E3BC545B93D49C86B3D6EFE99@CO6PR11MB5652.namprd11.prod.outlook.com>
Message-ID: <CO6PR11MB56524631CBAEE3AA229AD0A5EFE99@CO6PR11MB5652.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

You've already reported this internally, and you've mailed this to two different mailing lists. This just delays the issue so please go through the internal route.

Todd Fujinaka
Software Application Engineer
Data Center Group
Intel Corporation
todd.fujinaka at intel.com

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Fujinaka, Todd
Sent: Tuesday, July 27, 2021 8:04 AM
To: Yuvaraj Ranganathan <yranganathan@juniper.net>; intel-wired-lan at lists.osuosl.org
Cc: Pushp Saurav <psaurav@juniper.net>
Subject: Re: [Intel-wired-lan] [E1000-devel] Traffic not passing for VLAN ID >= 32 on the I350 SR-IOV enabled NIC

Can you please file this through your company contact? I think you have very specific requirements that we can't discuss on a public mailing list.

Todd Fujinaka
Software Application Engineer
Data Center Group
Intel Corporation
todd.fujinaka at intel.com

-----Original Message-----
From: Yuvaraj Ranganathan via E1000-devel <e1000-devel@lists.sourceforge.net> 
Sent: Monday, July 26, 2021 11:23 PM
To: e1000-devel@lists.sourceforge.net; intel-wired-lan at lists.osuosl.org
Cc: Pushp Saurav <psaurav@juniper.net>
Subject: [E1000-devel] Traffic not passing for VLAN ID >= 32 on the I350 SR-IOV enabled NIC

Hi Team,

With the SR-IOV enabled on I350 NIC which has 4 VF's, on configuring VLAN ID from range 1 to 31 on the VM interface, network traffic is fine and no issues. When trying to create an interface with VLAN ID >= 32 on the VM, traffic is not passing to that interface and as per HW specs, VLAN ID's from 1 to 4096 are supported.

VM's interface is directly mapped to one of the VF on I350 NIC. I am using IGB PF driver version 5.7.2(latest).

Could somebody please help!

Thanks in advance,
Yuvaraj.


Juniper Business Use Only

_______________________________________________
E1000-devel mailing list
E1000-devel at lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/e1000-devel
To learn more about Intel Ethernet, visit https://forums.intel.com/s/topic/0TO0P00000018NbWAI/intel-ethernet
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
