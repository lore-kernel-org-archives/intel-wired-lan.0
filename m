From: Julia Lawall <julia.lawall@lip6.fr>
Date: Fri, 13 May 2016 21:46:16 +0200 (CEST)
Subject: [Intel-wired-lan] [PATCH] i40e: constify i40e_client_ops
	structure
In-Reply-To: <1463168405.2612.23.camel@intel.com>
References: <1462104443-30724-1-git-send-email-Julia.Lawall@lip6.fr>
 <0c2df9ca-64bd-ac73-9071-f4d619887df8@redhat.com>
 <1463168405.2612.23.camel@intel.com>
Message-ID: <alpine.DEB.2.02.1605132143400.2235@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On Fri, 13 May 2016, Jeff Kirsher wrote:

> On Fri, 2016-05-13 at 12:50 -0400, Doug Ledford wrote:
> > On 05/01/2016 08:07 AM, Julia Lawall wrote:
> > > The i40e_client_ops structure is never modified, so declare it as
> > const.
> > >?
> > > Done with the help of Coccinelle.
> > >?
> > > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> > 
> > Thanks, applied.
> 
> I already have this patch queued up to push through David Miller's net-next 
> tree.
> 
> Julia- please do not shotgun blast several maintainers and several lists,
> it causes confusion on who is *REALLY* going to accept and apply the patch.
> Please use scripts/get_maintainer.pl to get the correct mailing lists and
> maintainers to add to the To: and CC: lines.

I do.  Probably the patch affects files maintained by different people.  
My assumption would be that everyone responsible for the code that is 
affected by the patch would want to see it.  Perhaps there would have been 
a way to separate it, but the const annotations typically have to be 
consistent everywhere.

julia
