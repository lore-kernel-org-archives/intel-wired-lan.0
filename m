From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Mon, 21 Dec 2020 15:16:47 +0000
Subject: [Intel-wired-lan] ixgbe: 5.10.0 kernel regression for 2.5Gbps
 link negotiation?
In-Reply-To: <07a977b0-c3f9-4cbe-482e-350d8b42cda7@molgen.mpg.de>
References: <7bb485c3-9556-d9f1-e70f-a4b3a05909c9@candelatech.com>
 <BYAPR11MB3606E48BA821185142354D67EFC30@BYAPR11MB3606.namprd11.prod.outlook.com>
 <3bcba0ca-8f3b-8428-861a-86aaff1688b6@molgen.mpg.de>
 <c54c8f2c-a295-c691-466e-07ae8f41b0ac@candelatech.com>
 <3c8510fb-af8c-b5f9-2af1-64584a667ac8@molgen.mpg.de>
 <BYAPR11MB36060F3889C66AE55092DA01EFC20@BYAPR11MB3606.namprd11.prod.outlook.com>
 <8635a2db-0d38-c088-321b-27bc4bb21ec4@candelatech.com>
 <MN2PR11MB3614FD0C52705864C05EFDF8EFC20@MN2PR11MB3614.namprd11.prod.outlook.com>
 <07a977b0-c3f9-4cbe-482e-350d8b42cda7@molgen.mpg.de>
Message-ID: <BYAPR11MB3606001E3832B5A04F9787E6EFC00@BYAPR11MB3606.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I would listen to you on Linus' list, but this is Intel-wired-lan.

Todd Fujinaka
Software Application Engineer
Data Center Group
Intel Corporation
todd.fujinaka at intel.com

-----Original Message-----
From: Paul Menzel <pmenzel@molgen.mpg.de> 
Sent: Monday, December 21, 2020 7:10 AM
To: Fujinaka, Todd <todd.fujinaka@intel.com>; Ben Greear <greearb@candelatech.com>
Cc: intel-wired-lan at lists.osuosl.org; Greg KH <gregkh@linuxfoundation.org>; Linus Torvalds <torvalds@linux-foundation.org>; Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Subject: Re: [Intel-wired-lan] ixgbe: 5.10.0 kernel regression for 2.5Gbps link negotiation?

Dear Todd,


I kindly ask you again, please do not top-post. It?s impolite, and more importantly, it wastes the readers time as it looses context, and results in misunderstandings.

Am 19.12.20 um 17:19 schrieb Fujinaka, Todd:
> This is a bad case with no ideal solution. Detecting the case is not 
> possible as autonegotiation happens in the hardware without software 
> involvement.
> 
> One solution was to update the switch firmware for the a switch that 
> is is the link partner that give us the most trouble. The issue 
> appears to be in competing or half-implemented standards. 2.5G and 5G 
> were initially non-IEEE standards that different manufacturers hacked 
> onto 1G in different ways. We implemented it to one of the standards 
> which should be interoperable, but the corner case of the 
> widely-deployed switch will take the link from 10G to 1G with no 
> automated way to fix it.

Thank you for the background, which should have been in the commit message.

Can you please tell us the problematic switch name and the problematic firmware version and the one, where this issues is fixed?

> Updating switches means a lot of downtime for a lot of datacenters and 
> the OEMs we deal with would not accept that answer.

Well, then please discuss the problem and possible solutions on the mailing list. Breaking other peoples setups is unacceptable. A Linux kernel runtime parameter would be one solution, your customers could have used.

> Our solution was to disable 2.5G and 5G by default. This fixes 10G 
> linking at 1G on that switch, but 2.5G and 5G will link at 1G by 
> default. And, as I said, I've had very little contact with people 
> using 2.5G and 5G and I'm the guy on all the mailing lists.

Unfortunately, a lot of users are not on the mailing list.

> I apologize for making your life harder, but it seems like it's just 
> you so far. Paul seems to be arguing with me just for the fun of it.

Please keep the discussion respectful, and do not insult others.

Unfortunately, at work we have now been bitten several times by regressions updating to the current mainline Linux kernel, causing frictions in the team about what Linux kernel to use.

I am missing a statement by you, acknowledging that the commit and the whole communication was a big fail, and how you will fix the regression. 
Additionally, an analysis would be nice, where the process failed ? why was the commit message incomplete and why did the test (Tested-by
present) not spot the issue ? and how to improve it to avoid such a situation in the future.


Kind regards,

Paul
