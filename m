From: Williams, Mitch A <mitch.a.williams@intel.com>
Date: Tue, 4 Apr 2017 22:51:11 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: limit client interface to X722
	hardware
In-Reply-To: <b28317c2-fa35-2ee1-7bf2-c3ca7d24677b@kpanic.de>
References: <20170404143446.16359-1-sassmann@kpanic.de>
 <CAJ3xEMjvmXTAyLP2-BwHRj59uQeCNXA7XSX7kTA=8TmwwmzRkw@mail.gmail.com>
 <b28317c2-fa35-2ee1-7bf2-c3ca7d24677b@kpanic.de>
Message-ID: <AAEA33E297BCAC4B9BB20A7C2DF0AB8D80544294@FMSMSX113.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org] On
> Behalf Of Stefan Assmann
> Sent: Tuesday, April 04, 2017 12:52 PM
> To: Or Gerlitz <gerlitz.or@gmail.com>
> Cc: intel-wired-lan at lists.osuosl.org; Linux Netdev List
> <netdev@vger.kernel.org>; David Miller <davem@davemloft.net>; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>
> Subject: Re: [PATCH] i40e: limit client interface to X722 hardware
> 
> On 04.04.2017 18:56, Or Gerlitz wrote:
> > On Tue, Apr 4, 2017 at 5:34 PM, Stefan Assmann <sassmann@kpanic.de> wrote:
> >> The client interface is meant for X722 iWARP support. Modprobing i40iw
> >> on systems with X710/XL710 NICs currently may crash the system.
> >
> > just curious may or crash? and why?
> 
> The backtrace I got was not really conclusive. The code is not meant to
> be run on that hardware so I didn't bother to dig deeper.
> 
>   Stefan

The i40iw module can't easily determine which hardware its loaded upon. So it assumes that we (i40e, that is) have handed it a handle to valid hardware. When the interface is opened, it starts reading and writing registers that are nonexistent on X710/XL710.

-Mitch
