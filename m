From: Salvatore Bonaccorso <carnil@debian.org>
Date: Mon, 10 Aug 2020 20:47:31 +0200
Subject: [Intel-wired-lan] Further information on
 CVE-2019-0145/CVE-2019-0146/CVE-2019-0147/CVE-2019-0148/CVE-2019-0149 for
 Linux?
In-Reply-To: <alpine.LFD.2.23.451.2007281106010.590669@jbrandeb-desk.jf.intel.com>
References: <20200716203902.acn3ea2b4iorxlhq@inutil.org>
 <alpine.LFD.2.23.451.2007281106010.590669@jbrandeb-desk.jf.intel.com>
Message-ID: <20200810184731.GA300766@eldamar.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jessie,

On Tue, Jul 28, 2020 at 11:10:27AM -0700, Jesse Brandeburg wrote:
> 
> 
> On Thu, 16 Jul 2020, Moritz Muehlenhoff wrote:
> 
> > Hi,
> > https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00255.html refers
> > to vulnerabilities in Intel Ethernet drivers and a few of them refer to the i40e driver
> > specifically:
> 
> I'm sorry Moritz that we haven't gotten back to you. We are chasing down the
> specific patches made upstream for software portions of the below fixes.
> 
> > CVEID: CVE-2019-0145
> > Description: Buffer overflow in i40e driver for Intel(R) Ethernet 700 Series Controllers
> > versions before 7.0 may allow an authenticated user to potentially enable an escalation
> > of privilege via local access.
> > 
> > CVEID: CVE-2019-0146
> > Description: Resource leak in i40e driver for Intel(R) Ethernet 700 Series Controllers
> > versions before 2.8.43 may allow an authenticated user to potentially enable a denial of
> > service via local access.
> > 
> > CVEID: CVE-2019-0147
> > Description: Insufficient input validation in i40e driver for Intel(R) Ethernet 700 Series
> > Controllers versions before 7.0 may allow an authenticated user to potentially enable a
> > denial of service via local access.
> > 
> > CVEID: CVE-2019-0148
> > Description: Resource leak in i40e driver for Intel(R) Ethernet 700 Series Controllers
> > versions before 7.0 may allow an authenticated use to potentially enable a denial of
> > service via local access.
> > 
> > CVEID: CVE-2019-0149
> > Description: Insufficient input validation in i40e driver for Intel(R) Ethernet 700
> > Series Controllers versions before 2.8.43 may allow an authenticated user to potentially
> > enable a denial of service via local access.
> > 
> > Is there any further information which commits fixed these and if so, were they submitted
> > to stable kernels? (The Debian kernels are based on 4.9.x and 4.19.x LTS kernels, so that
> > we can make sure these are addressed in stable/oldstable releases)
> 
> We will get you the information, it was a mistake on our part to not mention
> CVEs in the commit messages if/when we upstreamed the patches. The only
> thing I can say for sure is that these have been addressed in our
> Out-of-tree drivers, but I realize that is not your question.

Thanks a lot as well for coming back to the question from Moritz, much
appreiciated.

I noted here was a submission for i40e fixes to stable, as
https://lore.kernel.org/stable/20200807205517.1740307-1-jesse.brandeburg at intel.com/
. Is any of those referring to one of the above?

Thanks already for your time,

Regards,
Salvatore
