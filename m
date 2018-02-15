From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 15 Feb 2018 10:11:12 -0800
Subject: [Intel-wired-lan] [PATCH] i40evf/i40evf_main: Fix variable
 assignment in i40evf_parse_cls_flower
In-Reply-To: <1518717442.29950.1.camel@intel.com>
References: <20180215174435.GA19969@embeddedor.com>
 <1518717442.29950.1.camel@intel.com>
Message-ID: <1518718272.6698.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2018-02-15 at 09:56 -0800, Ramamurthy, Harshitha wrote:
> On Thu, 2018-02-15 at 11:44 -0600, Gustavo A. R. Silva wrote:
> > It seems this is a copy-paste error and that the proper variable to
> > use
> > in this particular case is _src_ instead of _dst_.
> > 
> > Addresses-Coverity-ID: 1465282 ("Copy-paste error")
> > Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> > Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> 
> Thanks for the patch!
> 
> Acked-by:Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Dave, no need for me to pick this patch up and then push to you.  You
can circumvent me and pick this up.

> > ---
> >  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180215/e5253f21/attachment.asc>
