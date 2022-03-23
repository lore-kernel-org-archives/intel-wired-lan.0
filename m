From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Wed, 23 Mar 2022 13:06:43 +0100
Subject: [Intel-wired-lan] Don't do arithmetic on anything smaller than
 'int' (was: [PATCH v2] ice: use min_t() to make code cleaner in ice_gnss)
In-Reply-To: <68ccb162-459b-cb95-19cf-3e0335e4c981@molgen.mpg.de>
References: <20220321135947.378250-1-wanjiabing@vivo.com>
 <f888e3cf09944f9aa63532c9f59e69fb@AcuMS.aculab.com>
 <20220322175038.2691665-1-alexandr.lobakin@intel.com>
 <af3fa59809654c9b9939f1e0bd8ca76b@AcuMS.aculab.com>
 <20220322112730.482d674d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <68ccb162-459b-cb95-19cf-3e0335e4c981@molgen.mpg.de>
Message-ID: <20220323120643.2759011-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 22 Mar 2022 22:02:06 +0100

> Dear Linux folks,
> 
> 
> Am 22.03.22 um 19:27 schrieb Jakub Kicinski:
> > On Tue, 22 Mar 2022 18:12:08 +0000 David Laight wrote:
> >>>> Oh FFS why is that u16?
> >>>> Don't do arithmetic on anything smaller than 'int'
> >>>
> >>> Any reasoning? I don't say it's good or bad, just want to hear your
> >>> arguments (disasms, perf and object code measurements) etc.
> >>
> >> Look at the object code on anything except x86.
> >> The compiler has to add instruction to mask the value
> >> (which is in a full sized register) down to 16 bits
> >> after every arithmetic operation.
> >
> > Isn't it also slower on some modern x86 CPUs?
> > I could have sworn someone mentioned that in the past.
> 
> I know of Scott's article *Small Integers: Big Penalty* from 2012 [1].

Thank you all guys, makes sense!

Apart from this article, I tested some stuff on MIPS32 yesterday.
Previously I was sure that it's okay to put u16 on stack to conserve
it and there will be no code difference. I remember even having some
bloat-o-meter data. Well, human memory tends to lie sometimes.
I have a bunch of networking stats on stack which I collect during
a NAPI cycle (receiving 64 packets), it's about 20 counters. I made
them as u16 initially as it is (sizeof(u32) - sizeof(u16)) * 20 = 40
bytes. So I converted them yesterday to u32 and instead of having
+40 bytes of .text, I got -36 in one function and even -88 in
another one!
So it really makes no sense to declare anything on stack smaller
than u32 or int unless it is something to be passed to some HW or
standardized structures, e.g. __be16 etc.

Another interesting observation, on x86_64, is that u32 = u64
assignments take more instructions as well. I converted some
structure field recently from u64 to u32, but forgot that I'm
assigning it in one function from an onstack variable, which was
still unconverted from u64 to u32. When I did the latter, the .text
size became smaller.

> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://notabs.org/coding/smallIntsBigPenalty.htm

Thanks,
Al
