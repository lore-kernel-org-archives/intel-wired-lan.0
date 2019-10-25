From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 25 Oct 2019 20:20:51 +0000
Subject: [Intel-wired-lan] [PATCH] namespace: fix namespace.pl script to
 support relative paths
In-Reply-To: <6127ec91-ad81-f0d7-576e-22e06e677442@infradead.org>
References: <20190129204319.15238-1-jacob.e.keller@intel.com>
 <7b26e6cc-10ce-5df2-6375-1f95bc4da04e@infradead.org>
 <02874ECE860811409154E81DA85FBB58968DBE54@ORSMSX121.amr.corp.intel.com>
 <CAK7LNARyUEakeG_N9TWcO2cjFSzbgY__k_QJm6C+oOz+fW0aeg@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB58968E1402@ORSMSX121.amr.corp.intel.com>
 <CAK7LNARAhZtzdnS9+mgtamj=pLdV81dudnYVDa8NRxcQPpF0bw@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB589693A38A@ORSMSX121.amr.corp.intel.com>
 <CAK7LNAQow8N9a5e_=pu7qDiuvETy1x1P5fxp20zYOZgQhXPJhg@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB589693D053@ORSMSX121.amr.corp.intel.com>
 <6127ec91-ad81-f0d7-576e-22e06e677442@infradead.org>
Message-ID: <02874ECE860811409154E81DA85FBB589693DABC@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Friday, October 25, 2019 12:30 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; Masahiro Yamada
> <yamada.masahiro@socionext.com>
> Cc: intel-wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org; linux-kbuild
> <linux-kbuild@vger.kernel.org>
> Subject: Re: [PATCH] namespace: fix namespace.pl script to support relative
> paths
> 
> On 10/25/19 10:45 AM, Keller, Jacob E wrote:
> >
> >> -----Original Message-----
> >> From: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> Sent: Wednesday, October 23, 2019 6:22 PM
> >> To: Keller, Jacob E <jacob.e.keller@intel.com>
> >> Cc: Randy Dunlap <rdunlap@infradead.org>; intel-wired-lan at lists.osuosl.org;
> >> linux-kernel at vger.kernel.org; linux-kbuild <linux-kbuild@vger.kernel.org>
> >> Subject: Re: [PATCH] namespace: fix namespace.pl script to support relative
> >> paths
> >>
> >> If you want to detect missing 'static',
> >> have you tried 'sparse'?
> >>
> >
> > We've used that as well.
> >
> > To be fair, I agree that it covers similar functionality as other tools. I haven't
> looked directly at namespace.pl output in a while, and the fix here is multiple
> years old that took a long time to get picked up.
> >
> > If it's agreed that the tool has no value, and especially if it results in false
> indications of a problem, then maybe removing it to prevent someone from mis-
> reading its output makes sense?
> 
> If there is a satisfactory alternative, I expect that namespace.pl is old,
> unmaintained, and unneeded, and should go away.
> 
> --
> ~Randy

Given Yamada's comments and my experience, modpost and sparse are both good at detecting the issues that namespace.pl handles.

I am not sure if there's any other output that would be valuable from namespace.pl, but if not.. I don't see a reason to keep it compared to the other tools.

Thanks,
Jake
