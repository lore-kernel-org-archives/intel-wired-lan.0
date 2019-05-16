From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 16 May 2019 12:17:53 -0700
Subject: [Intel-wired-lan] [PATCH 1/6] igb: mark expected switch
 fall-through
In-Reply-To: <dd2974a0-b559-cfd1-c3d8-0839594ef03c@embeddedor.com>
References: <20190329233850.29630-1-jeffrey.t.kirsher@intel.com>
 <b5f1f0c0-e27b-f861-c36e-35e493f45dff@embeddedor.com>
 <dd2974a0-b559-cfd1-c3d8-0839594ef03c@embeddedor.com>
Message-ID: <4fd1c087e5a19eea44521abc6b8d1213bca3ec22.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2019-05-08 at 12:59 -0500, Gustavo A. R. Silva wrote:
> Hi Jeff,
> 
> I wonder if there is any chance for this series to be queued up for
> 5.2-rc1.

Possibly, but since the nature of your patch is to just modify a code
comment because the tools used to check are not sophisticated enough to
realize the code comment already clearly states "Fall through ...", I
do not feel this is *really* necessary to get into 'net'.  If I have
other 'fixes' in my queue that need to get pushed, I may add this
change to the series.  I have not decided yet whether it warrants being
in 'net' or could wait till 'net-next'.

> 
> On 4/24/19 11:42 AM, Gustavo A. R. Silva wrote:
> > Hi Jeff,
> > 
> > I just wanted to check if this series has already been applied
> > somewhere.
> > 
> > Thanks
> > --
> > Gustavo
> > 
> > On 3/29/19 6:38 PM, Jeff Kirsher wrote:
> > > From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> > > 
> > > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > > cases
> > > where we are expecting to fall through.
> > > 
> > > This patch fixes the following warning:
> > > 
> > > drivers/net/ethernet/intel/igb/igb_main.c: In function
> > > ?__igb_notify_dca?:
> > > drivers/net/ethernet/intel/igb/igb_main.c:6694:6: warning: this
> > > statement may fall through [-Wimplicit-fallthrough=]
> > >    if (dca_add_requester(dev) == 0) {
> > >       ^
> > > drivers/net/ethernet/intel/igb/igb_main.c:6701:2: note: here
> > >   case DCA_PROVIDER_REMOVE:
> > >   ^~~~
> > > 
> > > Warning level 3 was used: -Wimplicit-fallthrough=3
> > > 
> > > Notice that, in this particular case, the code comment is
> > > modified
> > > in accordance with what GCC is expecting to find.
> > > 
> > > This patch is part of the ongoing efforts to enable
> > > -Wimplicit-fallthrough.
> > > 
> > > Signed-off-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> > > ---
> > >  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> > > b/drivers/net/ethernet/intel/igb/igb_main.c
> > > index 834e879e1d57..e8042b0254bc 100644
> > > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > > @@ -6701,7 +6701,7 @@ static int __igb_notify_dca(struct device
> > > *dev, void *data)
> > >  			igb_setup_dca(adapter);
> > >  			break;
> > >  		}
> > > -		/* Fall Through since DCA is disabled. */
> > > +		/* Fall Through - since DCA is disabled. */
> > >  	case DCA_PROVIDER_REMOVE:
> > >  		if (adapter->flags & IGB_FLAG_DCA_ENABLED) {
> > >  			/* without this a class_device is left
> > > 
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> > 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190516/2801b9e1/attachment-0001.asc>
