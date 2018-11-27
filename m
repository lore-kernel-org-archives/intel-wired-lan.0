From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 27 Nov 2018 08:27:33 -0800
Subject: [Intel-wired-lan] [PATCH net] ixgbe: recognize 1000BaseLX SFP
 modules as 1Gbps
In-Reply-To: <20181126.205247.1196368459821644290.davem@davemloft.net>
References: <40FD0CE5-973C-4A7F-91BD-66C1A1699223@appneta.com>
 <937675447ad1ec2665d0b6f70390d498a01255d0.camel@intel.com>
 <F6168EB4-8C74-456F-B571-6492162CFA0F@appneta.com>
 <20181126.205247.1196368459821644290.davem@davemloft.net>
Message-ID: <2c43f30e8af44350d2585e48f4fade5e8b93ce0a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2018-11-26 at 20:52 -0800, David Miller wrote:
> From: Josh Elsasser <jelsasser@appneta.com>
> Date: Mon, 26 Nov 2018 16:54:11 -0800
> 
> > Jeff Kirsher <jeffrey.t.kirsher@intel.com> wrote:
> > 
> > > No need to re-spin the patch, just reply with the additional
> > > "Fixes"
> > > tag and if patchwork does not pick it up, I will add it to the
> > > patch I
> > > have in my tree for validation and review.
> > 
> > Thanks, let?s try that.
> > 
> > Fixes: e23f33367882 ("ixgbe: Fix 1G and 10G link stability for
> > X550EM_x SFP+?)
> 
> Unfortunately, patchwork isn't smart enough to pick up Fixes: tags
> still.

:-( I will get it added to the patch in my tree then.  Thanks Dave for
the info.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181127/cb866a70/attachment.asc>
