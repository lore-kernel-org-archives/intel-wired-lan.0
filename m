From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Fri, 18 Dec 2020 19:27:46 +0000
Subject: [Intel-wired-lan] 5.10.0 kernel regression for 2.5Gbps link
 negotiation?
In-Reply-To: <7bb485c3-9556-d9f1-e70f-a4b3a05909c9@candelatech.com>
References: <7bb485c3-9556-d9f1-e70f-a4b3a05909c9@candelatech.com>
Message-ID: <BYAPR11MB3606E48BA821185142354D67EFC30@BYAPR11MB3606.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Yes, and I'm plugging the hole in the README right now. Here's the proposed text:

Advertisements for 2.5G and 5G on the x550 were turned off by default due to
interoperability issues with certain switches. To turn them back on, use

ethtool -s <ethX> advertise N

where N is a combination of the following.

100baseTFull    0x008
1000baseTFull   0x020
2500baseTFull   0x800000000000
5000baseTFull   0x1000000000000
10000baseTFull  0x1000

For example, to turn on all modes:
ethtool -s <ethX> advertise 0x1800000001028

For more details please see the ethtool man page.

Todd Fujinaka
Software Application Engineer
Data Center Group
Intel Corporation
todd.fujinaka at intel.com

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Ben Greear
Sent: Friday, December 18, 2020 10:08 AM
To: intel-wired-lan <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] 5.10.0 kernel regression for 2.5Gbps link negotiation?

Hello,

One of our users reports that our 5.10 kernel negotiates the 1/2.5/5/10g NIC to 1Gbps instead of 2.5Gbps.  Booting the 5.4 kernel shows 2.5Gbps as expected.

I have not yet tried to bisect this...is it a known issue?

Thanks,
Ben

--
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com _______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
