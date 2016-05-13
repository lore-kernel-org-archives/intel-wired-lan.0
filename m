From: Doug Ledford <dledford@redhat.com>
Date: Fri, 13 May 2016 12:50:02 -0400
Subject: [Intel-wired-lan] [PATCH] i40e: constify i40e_client_ops
	structure
In-Reply-To: <1462104443-30724-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1462104443-30724-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <0c2df9ca-64bd-ac73-9071-f4d619887df8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/01/2016 08:07 AM, Julia Lawall wrote:
> The i40e_client_ops structure is never modified, so declare it as const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Thanks, applied.


-- 
Doug Ledford <dledford@redhat.com>
              GPG KeyID: 0E572FDD


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 884 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160513/54058ad8/attachment.asc>
