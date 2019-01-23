From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 23 Jan 2019 09:44:48 -0800
Subject: [Intel-wired-lan] [PATCH net-next] intel: Mark expected switch
 fall-throughs
In-Reply-To: <368769c1-bb6c-b137-14c4-ef0ade488c2e@embeddedor.com>
References: <20190123074849.GA24230@embeddedor>
 <e356e64d3267bbca1cfa0373b7ce965edaf159bd.camel@intel.com>
 <368769c1-bb6c-b137-14c4-ef0ade488c2e@embeddedor.com>
Message-ID: <87311718008d10cf7f59578fce13c0beddbe1cf4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2019-01-23 at 11:11 -0600, Gustavo A. R. Silva wrote:
> Hi Jeffrey,
> 
> On 1/23/19 11:04 AM, Jeff Kirsher wrote:
> > On Wed, 2019-01-23 at 01:48 -0600, Gustavo A. R. Silva wrote:
> > > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > > cases
> > > where we are expecting to fall through.
> > > 
> > > This patch fixes the following warnings:
> > > 
> > > drivers/net/ethernet/intel/igb/e1000_82575.c:636:6: warning: this
> > > statement may fall through [-Wimplicit-fallthrough=]
> > > drivers/net/ethernet/intel/igb/igb_main.c:6710:6: warning: this
> > > statement may fall through [-Wimplicit-fallthrough=]
> > > drivers/net/ethernet/intel/i40e/i40e_xsk.c:237:3: warning: this
> > > statement may fall through [-Wimplicit-fallthrough=]
> > > 
> > > Warning level 3 was used: -Wimplicit-fallthrough=3
> > > 
> > > This patch is part of the ongoing efforts to enabling
> > > -Wimplicit-fallthrough.
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > ---
> > >   drivers/net/ethernet/intel/i40e/i40e_xsk.c   | 3 ++-
> > >   drivers/net/ethernet/intel/igb/e1000_82575.c | 2 +-
> > >   drivers/net/ethernet/intel/igb/igb_main.c    | 2 +-
> > >   3 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > NAK on the igb changes.  There is already a "fall through" code
> > comment
> > which is fine, adding a hyphen does not make the comment any more
> > readable.
> > 
> 
> Those comments are not fine. They trigger the warnings I mention in
> the
> commit log. With this patch such warnings are fixed.
> 
> Notice that warning level 3 was used: -Wimplicit-fallthrough=3

This is a "false positive" based on the compiler option definition:

-Wimplicit-fallthrough=3 case sensitively matches a wide range of
regular expressions, listed in the GCC manual. E.g., all of these are
accepted:
/* Falls through. */
/* fall-thru */
/* Else falls through. */
/* FALLTHRU */
/* ? falls through ? */
etc.

You should be looking to fix the problem with the compiler option,
which is reporting "acceptable" code comments.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190123/0e687cb8/attachment.asc>
