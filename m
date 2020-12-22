From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 22 Dec 2020 09:59:05 +0100
Subject: [Intel-wired-lan] 5.10.0 kernel regression for 2.5Gbps link
 negotiation?
In-Reply-To: <1d9e12e5-56a5-7921-e4b6-b67bcc180942@candelatech.com>
References: <BYAPR11MB3606E48BA821185142354D67EFC30@BYAPR11MB3606.namprd11.prod.outlook.com>
 <3bcba0ca-8f3b-8428-861a-86aaff1688b6@molgen.mpg.de>
 <c54c8f2c-a295-c691-466e-07ae8f41b0ac@candelatech.com>
 <3c8510fb-af8c-b5f9-2af1-64584a667ac8@molgen.mpg.de>
 <BYAPR11MB36060F3889C66AE55092DA01EFC20@BYAPR11MB3606.namprd11.prod.outlook.com>
 <8635a2db-0d38-c088-321b-27bc4bb21ec4@candelatech.com>
 <MN2PR11MB3614FD0C52705864C05EFDF8EFC20@MN2PR11MB3614.namprd11.prod.outlook.com>
 <2108932e-ee2e-cadf-52cd-0cd11a6aeba4@candelatech.com>
 <BYAPR11MB3606A702240D0A1614AA6585EFC00@BYAPR11MB3606.namprd11.prod.outlook.com>
 <1d9e12e5-56a5-7921-e4b6-b67bcc180942@candelatech.com>
Message-ID: <X+G1WVz0qorjegSa@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 21, 2020 at 07:52:54AM -0800, Ben Greear wrote:
> On 12/21/20 7:20 AM, Fujinaka, Todd wrote:
> > Nope. The timing of the PHYs means the switch times out while we're trying 2.5G and 5G and the switch goes to its default lowest speed of 1G. Then we go to 1G and by that time bonding is broken in several of the cases we ran into.
> > 
> > Basically, we can have that switch work, or we can have 2.5G and 5G on by default. Not both. And since we're selling a 10G device with other speeds as a bonus, we're prioritizing the highest speed. That plus the very high profile customers who wanted this solution.
> > 
> > The solution for one camp or the other is to use the ethtool command at boot (I've forgotten exactly what that was) but the high profile customers refused to do that. Sounds like you're refusing as well?
> 
> I'm not refusing, I just would rather patch my kernels than use ethtool, that way my older user-space
> would work fine on newer kernels.
> 
> Would you accept a patch that makes this a module option, defaulted to disable 2.5/5, but which
> a user could enabled to enable 2.5/5 by default?

Module options are not ok, this is not the 1990's.  Please use the
proper configuration methods instead that can work on a per-device
basis.

thanks,

greg k-h
