From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 10 Aug 2020 14:59:09 -0700
Subject: [Intel-wired-lan] Further information on
 CVE-2019-0145/CVE-2019-0146/CVE-2019-0147/CVE-2019-0148/CVE-2019-0149 for
 Linux?
In-Reply-To: <20200810184731.GA300766@eldamar.local>
References: <20200716203902.acn3ea2b4iorxlhq@inutil.org>
 <alpine.LFD.2.23.451.2007281106010.590669@jbrandeb-desk.jf.intel.com>
 <20200810184731.GA300766@eldamar.local>
Message-ID: <20200810145909.0000134f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 10 Aug 2020 20:47:31 +0200
Salvatore Bonaccorso <carnil@debian.org> wrote:

> > We will get you the information, it was a mistake on our part to
> > not mention CVEs in the commit messages if/when we upstreamed the
> > patches. The only thing I can say for sure is that these have been
> > addressed in our Out-of-tree drivers, but I realize that is not
> > your question.
> 
> Thanks a lot as well for coming back to the question from Moritz, much
> appreiciated.
> 
> I noted here was a submission for i40e fixes to stable, as
> https://lore.kernel.org/stable/20200807205517.1740307-1-jesse.brandeburg at intel.com/
> . Is any of those referring to one of the above?
> 
> Thanks already for your time,

The patches to address the above issues are part of mainline kernel
5.2.0, and (upcoming) stable kernel 4.19.139, however I'm not sure if
there is anything else I need to do in order to have them backported to
4.9.y.

I hope that helps you! Thanks for bringing it to our attention.
