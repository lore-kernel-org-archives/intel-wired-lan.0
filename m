From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 23 Oct 2019 21:34:06 +0000
Subject: [Intel-wired-lan] [PATCH] namespace: fix namespace.pl script to
 support relative paths
In-Reply-To: <CAK7LNARAhZtzdnS9+mgtamj=pLdV81dudnYVDa8NRxcQPpF0bw@mail.gmail.com>
References: <20190129204319.15238-1-jacob.e.keller@intel.com>
 <7b26e6cc-10ce-5df2-6375-1f95bc4da04e@infradead.org>
 <02874ECE860811409154E81DA85FBB58968DBE54@ORSMSX121.amr.corp.intel.com>
 <CAK7LNARyUEakeG_N9TWcO2cjFSzbgY__k_QJm6C+oOz+fW0aeg@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB58968E1402@ORSMSX121.amr.corp.intel.com>
 <CAK7LNARAhZtzdnS9+mgtamj=pLdV81dudnYVDa8NRxcQPpF0bw@mail.gmail.com>
Message-ID: <02874ECE860811409154E81DA85FBB589693A38A@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Masahiro Yamada <yamada.masahiro@socionext.com>
> Sent: Tuesday, October 22, 2019 10:22 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; Randy Dunlap
> <rdunlap@infradead.org>
> Cc: intel-wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org; linux-kbuild
> <linux-kbuild@vger.kernel.org>
> Subject: Re: [PATCH] namespace: fix namespace.pl script to support relative
> paths
> 
> This scripts has been 5-year broken,
> and I did not see any complaint except from you.
> So, I wonder how many people are using this.
> 
> Nor, do I understand how to use it.
> 
> Could you teach me a bit more about this script?
> 
> 
> 
> Something might be missing in my mind, but
> I do not know how to use this script in a useful way.
> 
> 
> 
> It provides three checks.
> 
> [1] list_multiply_defined()
> 
> This warns multiple definition of functions.
> 
> The compiler would fail if it saw any multiple definition,
> so the reports from this check are all false-positive.
> 
> 
> [2] resolve_external_references()
> 
> This warns unresolved symbols.
> 
> The compiler would fail if it saw any unresolved symbol,
> so the reports from this check are all false-positive, too.
> 
> 

The compiler won't necessarily fail when building modules, because the symbol might be in another loadable module.

> 
> 
> [3] list_extra_externals
> 
> This warns symbols with no reference.
> 
> This potentially contains lots of false-positives.
> For example, the core framework provides APIs, but if all drivers
> are disabled, there is no user of those APIs.
> 

We use this to help verify that driver modules do not expose symbols.

Thanks,
Jake
