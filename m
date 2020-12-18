From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 18 Dec 2020 20:43:25 +0100
Subject: [Intel-wired-lan] 5.10.0 kernel regression for 2.5Gbps link
 negotiation?
In-Reply-To: <BYAPR11MB3606E48BA821185142354D67EFC30@BYAPR11MB3606.namprd11.prod.outlook.com>
References: <7bb485c3-9556-d9f1-e70f-a4b3a05909c9@candelatech.com>
 <BYAPR11MB3606E48BA821185142354D67EFC30@BYAPR11MB3606.namprd11.prod.outlook.com>
Message-ID: <3bcba0ca-8f3b-8428-861a-86aaff1688b6@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Todd,


Am 18.12.20 um 20:27 schrieb Fujinaka, Todd:
> Yes, and I'm plugging the hole in the README right now. Here's the proposed text:
> 
> Advertisements for 2.5G and 5G on the x550 were turned off by default due to
> interoperability issues with certain switches. To turn them back on, use
> 
> ethtool -s <ethX> advertise N
> 
> where N is a combination of the following.
> 
> 100baseTFull    0x008
> 1000baseTFull   0x020
> 2500baseTFull   0x800000000000
> 5000baseTFull   0x1000000000000
> 10000baseTFull  0x1000
> 
> For example, to turn on all modes:
> ethtool -s <ethX> advertise 0x1800000001028
> 
> For more details please see the ethtool man page.

What commit introduced this regression. Please bear in mind, that this 
contradicts Linux? no-regression policy, and the commit should therefore 
be reverted as soon as possible.


Kind regards,

Paul
