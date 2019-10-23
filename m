From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 23 Oct 2019 14:21:34 +0900
Subject: [Intel-wired-lan] [PATCH] namespace: fix namespace.pl script to
 support relative paths
In-Reply-To: <02874ECE860811409154E81DA85FBB58968E1402@ORSMSX121.amr.corp.intel.com>
References: <20190129204319.15238-1-jacob.e.keller@intel.com>
 <7b26e6cc-10ce-5df2-6375-1f95bc4da04e@infradead.org>
 <02874ECE860811409154E81DA85FBB58968DBE54@ORSMSX121.amr.corp.intel.com>
 <CAK7LNARyUEakeG_N9TWcO2cjFSzbgY__k_QJm6C+oOz+fW0aeg@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB58968E1402@ORSMSX121.amr.corp.intel.com>
Message-ID: <CAK7LNARAhZtzdnS9+mgtamj=pLdV81dudnYVDa8NRxcQPpF0bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 1, 2019 at 5:49 AM Keller, Jacob E <jacob.e.keller@intel.com> wrote:
>
> > -----Original Message-----
> > From: Masahiro Yamada [mailto:yamada.masahiro at socionext.com]
> > Sent: Saturday, September 28, 2019 5:21 PM
> > To: Keller, Jacob E <jacob.e.keller@intel.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>; intel-wired-lan at lists.osuosl.org; linux-
> > kernel at vger.kernel.org; linux-kbuild <linux-kbuild@vger.kernel.org>
> > Subject: Re: [PATCH] namespace: fix namespace.pl script to support relative paths
> >
> > On Sat, Sep 28, 2019 at 8:30 AM Keller, Jacob E
> > <jacob.e.keller@intel.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: Randy Dunlap [mailto:rdunlap at infradead.org]
> > > > Sent: Friday, September 27, 2019 4:12 PM
> > > > To: Keller, Jacob E <jacob.e.keller@intel.com>
> > > > Cc: intel-wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org; linux-kbuild
> > <linux-
> > > > kbuild at vger.kernel.org>; Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > Subject: Re: [PATCH] namespace: fix namespace.pl script to support relative paths
> > > >
> > > >
> > > > re: https://lore.kernel.org/lkml/20190129204319.15238-1-
> > jacob.e.keller at intel.com/
> > > >
> > > > Did anything happen with this patch?
> > > >
> > > > Please send it to linux-kbuild at vger.kernel.org and
> > > > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > >
> > > > You can also add:
> > > > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > > > Tested-by: Randy Dunlap <rdunlap@infradead.org>
> > > >
> > > >
> > > > I was just about to fix this script but I decided to first see if anyone else
> > > > had already done so.  Thanks.
> > > >
> > > > --
> > > > ~Randy
> > >
> > > Done, thanks.
> > >
> > > Regards,
> > > Jake
> >
> >
> > Applied to linux/kbuild. Thanks.
> >
>
> Great, thanks!


This scripts has been 5-year broken,
and I did not see any complaint except from you.
So, I wonder how many people are using this.

Nor, do I understand how to use it.

Could you teach me a bit more about this script?



Something might be missing in my mind, but
I do not know how to use this script in a useful way.



It provides three checks.

[1] list_multiply_defined()

This warns multiple definition of functions.

The compiler would fail if it saw any multiple definition,
so the reports from this check are all false-positive.


[2] resolve_external_references()

This warns unresolved symbols.

The compiler would fail if it saw any unresolved symbol,
so the reports from this check are all false-positive, too.




[3] list_extra_externals

This warns symbols with no reference.

This potentially contains lots of false-positives.
For example, the core framework provides APIs, but if all drivers
are disabled, there is no user of those APIs.




I built the kernel with x86_64_defconfig,
and namespacecheck provides

1400 line reports for [1].
200 line reports for [2].
6800 line reports for [3].

Most of these seem false-positives.



How can I use it for the code improvement?

[3] might be still useful to find 'static' candidates,
but it would be difficult given the amount of the report.

-- 
Best Regards
Masahiro Yamada
