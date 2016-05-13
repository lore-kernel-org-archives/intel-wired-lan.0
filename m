From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 13 May 2016 12:40:05 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: constify i40e_client_ops
	structure
In-Reply-To: <0c2df9ca-64bd-ac73-9071-f4d619887df8@redhat.com>
References: <1462104443-30724-1-git-send-email-Julia.Lawall@lip6.fr>
 <0c2df9ca-64bd-ac73-9071-f4d619887df8@redhat.com>
Message-ID: <1463168405.2612.23.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-05-13 at 12:50 -0400, Doug Ledford wrote:
> On 05/01/2016 08:07 AM, Julia Lawall wrote:
> > The i40e_client_ops structure is never modified, so declare it as
> const.
> >?
> > Done with the help of Coccinelle.
> >?
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Thanks, applied.

I already have this patch queued up to push through David Miller's net-next 
tree.

Julia- please do not shotgun blast several maintainers and several lists,
it causes confusion on who is *REALLY* going to accept and apply the patch.
Please use scripts/get_maintainer.pl to get the correct mailing lists and
maintainers to add to the To: and CC: lines.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160513/4ed80b73/attachment-0001.asc>
