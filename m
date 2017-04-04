From: Stefan Assmann <sassmann@kpanic.de>
Date: Tue, 4 Apr 2017 21:51:51 +0200
Subject: [Intel-wired-lan] [PATCH] i40e: limit client interface to X722
	hardware
In-Reply-To: <CAJ3xEMjvmXTAyLP2-BwHRj59uQeCNXA7XSX7kTA=8TmwwmzRkw@mail.gmail.com>
References: <20170404143446.16359-1-sassmann@kpanic.de>
 <CAJ3xEMjvmXTAyLP2-BwHRj59uQeCNXA7XSX7kTA=8TmwwmzRkw@mail.gmail.com>
Message-ID: <b28317c2-fa35-2ee1-7bf2-c3ca7d24677b@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 04.04.2017 18:56, Or Gerlitz wrote:
> On Tue, Apr 4, 2017 at 5:34 PM, Stefan Assmann <sassmann@kpanic.de> wrote:
>> The client interface is meant for X722 iWARP support. Modprobing i40iw
>> on systems with X710/XL710 NICs currently may crash the system.
> 
> just curious may or crash? and why?

The backtrace I got was not really conclusive. The code is not meant to
be run on that hardware so I didn't bother to dig deeper.

  Stefan
