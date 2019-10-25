From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 25 Oct 2019 17:45:43 +0000
Subject: [Intel-wired-lan] [PATCH] namespace: fix namespace.pl script to
 support relative paths
In-Reply-To: <CAK7LNAQow8N9a5e_=pu7qDiuvETy1x1P5fxp20zYOZgQhXPJhg@mail.gmail.com>
References: <20190129204319.15238-1-jacob.e.keller@intel.com>
 <7b26e6cc-10ce-5df2-6375-1f95bc4da04e@infradead.org>
 <02874ECE860811409154E81DA85FBB58968DBE54@ORSMSX121.amr.corp.intel.com>
 <CAK7LNARyUEakeG_N9TWcO2cjFSzbgY__k_QJm6C+oOz+fW0aeg@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB58968E1402@ORSMSX121.amr.corp.intel.com>
 <CAK7LNARAhZtzdnS9+mgtamj=pLdV81dudnYVDa8NRxcQPpF0bw@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB589693A38A@ORSMSX121.amr.corp.intel.com>
 <CAK7LNAQow8N9a5e_=pu7qDiuvETy1x1P5fxp20zYOZgQhXPJhg@mail.gmail.com>
Message-ID: <02874ECE860811409154E81DA85FBB589693D053@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Masahiro Yamada <yamada.masahiro@socionext.com>
> Sent: Wednesday, October 23, 2019 6:22 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>; intel-wired-lan at lists.osuosl.org;
> linux-kernel at vger.kernel.org; linux-kbuild <linux-kbuild@vger.kernel.org>
> Subject: Re: [PATCH] namespace: fix namespace.pl script to support relative
> paths
> 
> On Thu, Oct 24, 2019 at 6:34 AM Keller, Jacob E
> <jacob.e.keller@intel.com> wrote:
> >
> > > -----Original Message-----
> > > From: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Sent: Tuesday, October 22, 2019 10:22 PM
> > > To: Keller, Jacob E <jacob.e.keller@intel.com>; Randy Dunlap
> > > <rdunlap@infradead.org>
> > > Cc: intel-wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org; linux-
> kbuild
> > > <linux-kbuild@vger.kernel.org>
> > > Subject: Re: [PATCH] namespace: fix namespace.pl script to support relative
> > > paths
> > >
> > > This scripts has been 5-year broken,
> > > and I did not see any complaint except from you.
> > > So, I wonder how many people are using this.
> > >
> > > Nor, do I understand how to use it.
> > >
> > > Could you teach me a bit more about this script?
> > >
> > >
> > >
> > > Something might be missing in my mind, but
> > > I do not know how to use this script in a useful way.
> > >
> > >
> > >
> > > It provides three checks.
> > >
> > > [1] list_multiply_defined()
> > >
> > > This warns multiple definition of functions.
> > >
> > > The compiler would fail if it saw any multiple definition,
> > > so the reports from this check are all false-positive.
> > >
> > >
> > > [2] resolve_external_references()
> > >
> > > This warns unresolved symbols.
> > >
> > > The compiler would fail if it saw any unresolved symbol,
> > > so the reports from this check are all false-positive, too.
> > >
> > >
> >
> > The compiler won't necessarily fail when building modules, because the symbol
> might be in another loadable module.
> 
> Right, but this is already checked by modpost, isn't it?
> 
> 
> 
> > >
> > >
> > > [3] list_extra_externals
> > >
> > > This warns symbols with no reference.
> > >
> > > This potentially contains lots of false-positives.
> > > For example, the core framework provides APIs, but if all drivers
> > > are disabled, there is no user of those APIs.
> > >
> >
> > We use this to help verify that driver modules do not expose symbols.
> 
> Ah, the output is quite large, so
> you search for only modules in your interest. Right?
> 

We run it on only one module at a time, yes.

> 
> If you want to detect missing 'static',
> have you tried 'sparse'?
> 

We've used that as well. 

To be fair, I agree that it covers similar functionality as other tools. I haven't looked directly at namespace.pl output in a while, and the fix here is multiple years old that took a long time to get picked up.

If it's agreed that the tool has no value, and especially if it results in false indications of a problem, then maybe removing it to prevent someone from mis-reading its output makes sense?

Thanks,
Jake

> 
> 
> > Thanks,
> > Jake
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
