From: Matthew Wilcox <willy@infradead.org>
Date: Sun, 18 Oct 2020 19:59:43 +0100
Subject: [Intel-wired-lan] [Ocfs2-devel] [RFC] treewide: cleanup
 unreachable breaks
In-Reply-To: <20201017160928.12698-1-trix@redhat.com>
References: <20201017160928.12698-1-trix@redhat.com>
Message-ID: <20201018185943.GM20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Oct 17, 2020 at 09:09:28AM -0700, trix at redhat.com wrote:
> clang has a number of useful, new warnings see
> https://urldefense.com/v3/__https://clang.llvm.org/docs/DiagnosticsReference.html__;!!GqivPVa7Brio!Krxz78O3RKcB9JBMVo_F98FupVhj_jxX60ddN6tKGEbv_cnooXc1nnBmchm-e_O9ieGnyQ$ 

Please get your IT department to remove that stupidity.  If you can't,
please send email from a non-Red Hat email address.

I don't understand why this is a useful warning to fix.  What actual
problem is caused by the code below?

> return and break
> 
>  	switch (c->x86_vendor) {
>  	case X86_VENDOR_INTEL:
>  		intel_p5_mcheck_init(c);
>  		return 1;
> -		break;

Sure, it's unnecessary, but it's not masking a bug.  It's not unclear.
Why do we want to enable this warning?

