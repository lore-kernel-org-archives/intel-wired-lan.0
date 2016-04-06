From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 06 Apr 2016 15:08:56 -0700
Subject: [Intel-wired-lan] [PATCH net-next] net: intel: remove dead links
In-Reply-To: <20160406.165451.42694079252458681.davem@davemloft.net>
References: <3c9f8ea384ba033f83ec360eef17732ff0a5a8dd.1459866280.git.jbenc@redhat.com>
 <20160406.165451.42694079252458681.davem@davemloft.net>
Message-ID: <1459980536.2978.18.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-04-06 at 16:54 -0400, David Miller wrote:
> From: Jiri Benc <jbenc@redhat.com>
> Date: Tue,??5 Apr 2016 16:25:07 +0200
> 
> > 
> > The Kconfig for Intel NICs references two different URLs for the
> > "Adapter
> > & Driver ID Guide". Neither of those two links works. The current
> > URL seems
> > to be
> > http://www.intel.com/content/www/us/en/support/network-and-i-o/ethe
> > rnet-products/000005584.html
> > but given it's apparently constantly changing, there's no point in
> > having it
> > in the help text.
> > 
> > Just keep a generic pointer to http://support.intel.com. Hopefully,
> > this one
> > will have a longer live. It still works, at least.
> > 
> > Futhermore, remove a link to "the latest Intel PRO/100 network
> > driver for
> > Linux", this has no place in the mainline kernel and the latest
> > Linux driver
> > it offers is from 2006, anyway.
> > 
> > Signed-off-by: Jiri Benc <jbenc@redhat.com>
> I expect Jeff to pull this into his tree, thanks.

Yep, got it queued up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160406/bf6e2f9b/attachment.asc>
