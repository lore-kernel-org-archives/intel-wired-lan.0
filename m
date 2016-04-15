From: KY Srinivasan <kys@microsoft.com>
Date: Fri, 15 Apr 2016 00:26:20 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/2] intel: ixgbevf: Support
 Windows hosts (Hyper-V)
In-Reply-To: <CAKgT0UckBes1tNXrNjA0R4uCdXouG9qQrf+VaLJMd8AhgYQieQ@mail.gmail.com>
References: <1460678121-30308-1-git-send-email-kys@microsoft.com>
 <1460678142-30353-1-git-send-email-kys@microsoft.com>
 <1460678142-30353-2-git-send-email-kys@microsoft.com>
 <5F69AC74-16B9-4EAD-8B4B-21D2EB6B3653@intel.com>
 <SN2PR03MB1919133D2E9B5DDBC2AED643A0680@SN2PR03MB1919.namprd03.prod.outlook.com>
 <DA0F5562-FC38-4037-B018-42116DD142E8@intel.com>
 <SN2PR03MB19196E84DF934294DE7BB739A0680@SN2PR03MB1919.namprd03.prod.outlook.com>
 <CAKgT0UckBes1tNXrNjA0R4uCdXouG9qQrf+VaLJMd8AhgYQieQ@mail.gmail.com>
Message-ID: <SN2PR03MB191946453781944A4ABF37BDA0680@SN2PR03MB1919.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Thursday, April 14, 2016 5:19 PM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: Rustad, Mark D <mark.d.rustad@intel.com>; David Miller
> <davem@davemloft.net>; netdev <netdev@vger.kernel.org>; linux-
> kernel at vger.kernel.org; devel at linuxdriverproject.org; olaf at aepfle.de;
> apw at canonical.com; jasowang at redhat.com; eli at mellanox.com;
> jackm at mellanox.com; yevgenyp at mellanox.com; Ronciak, John
> <john.ronciak@intel.com>; intel-wired-lan at linuxonhyperv.com
> Subject: Re: [PATCH net-next 2/2] intel: ixgbevf: Support Windows hosts
> (Hyper-V)
> 
> On Thu, Apr 14, 2016 at 5:11 PM, KY Srinivasan <kys@microsoft.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Rustad, Mark D [mailto:mark.d.rustad at intel.com]
> >> Sent: Thursday, April 14, 2016 5:07 PM
> >> To: KY Srinivasan <kys@microsoft.com>
> >> Cc: David Miller <davem@davemloft.net>; netdev
> >> <netdev@vger.kernel.org>; linux-kernel at vger.kernel.org;
> >> devel at linuxdriverproject.org; olaf at aepfle.de; apw at canonical.com;
> >> jasowang at redhat.com; eli at mellanox.com; jackm at mellanox.com;
> >> yevgenyp at mellanox.com; Ronciak, John <john.ronciak@intel.com>;
> intel-
> >> wired-lan at linuxonhyperv.com
> >> Subject: Re: [PATCH net-next 2/2] intel: ixgbevf: Support Windows hosts
> >> (Hyper-V)
> >>
> >> KY Srinivasan <kys@microsoft.com> wrote:
> >>
> >> >
> >> >
> >> >> -----Original Message-----
> >> >> From: Rustad, Mark D [mailto:mark.d.rustad at intel.com]
> >> >> Sent: Thursday, April 14, 2016 4:01 PM
> >> >> To: KY Srinivasan <kys@microsoft.com>
> >> >> Cc: David Miller <davem@davemloft.net>; netdev
> >> >> <netdev@vger.kernel.org>; linux-kernel at vger.kernel.org;
> >> >> devel at linuxdriverproject.org; olaf at aepfle.de; apw at canonical.com;
> >> >> jasowang at redhat.com; eli at mellanox.com; jackm at mellanox.com;
> >> >> yevgenyp at mellanox.com; Ronciak, John <john.ronciak@intel.com>;
> >> intel-
> >> >> wired-lan at linuxonhyperv.com
> >> >> Subject: Re: [PATCH net-next 2/2] intel: ixgbevf: Support Windows
> hosts
> >> >> (Hyper-V)
> >> >>
> >> >> Some comments below:
> >> >
> >> > Mark,
> >> >
> >> > Thank you for the comments. I will address them and repost the
> patches.
> >> >
> >> > Regards,
> >> >
> >> > K. Y
> >>
> >> Please look closely at Alex's comments. I think they are much more
> >> important.
> >
> > I am looking at Alex's comments as I am writing this.
> >
> 
> On additional thought that just occurred to me after looking over the
> other patches you submitted for the hv_netvsc is that you might just
> stub out the multicast, unicast, and vfta configuration calls for the
> hyperV interface since all that stuff should be handled by the other
> link in the bond anyway.  Then you should be able to mostly contain
> all the changes other than the device IDs to the vf.c file which is
> really how this kind of change should work anyway.

I will do that.
> 
> Also I was wondering.  Since HyperV is using a proprietary device ID
> anyway do you really need the calls like the one below?:
> +       if (x86_hyper == &x86_hyper_ms_hyperv) {
> 
> If we can just identify HyperV via the device Id then we could drop
> the x86 arch specific bits and instead just build for all cases.
Yes; I was planning to get rid of the x86 dependency. I will fix this.

K. Y
> 
> - Alex
