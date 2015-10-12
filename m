From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 12 Oct 2015 11:59:30 -0700
Subject: [Intel-wired-lan] [iproute2 PATCH] iplink: Support VF Trust
In-Reply-To: <20151012095423.4feabde1@urahara>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05F42A95@BPXM14GP.gisp.nec.co.jp>
 <20151012095423.4feabde1@urahara>
Message-ID: <1444676370.2781.15.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-10-12 at 09:54 -0700, Stephen Hemminger wrote:
> On Wed, 7 Oct 2015 10:06:32 +0000
> Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com> wrote:
> 
> > From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> > 
> > Add IFLA_VF_TRUST message to trust the VF.
> > PF can accept some privileged operation from the trusted VF.
> > For example, ixgbe PF doesn't allow to enable VF promiscuous mode
> until
> > the VF is trusted because it may hurt performance.
> > 
> > To trust VF.
> >  # ip link set dev eth0 vf 1 trust on
> > 
> > To untrust VF.
> >  # ip link set dev eth0 vf 1 trust off
> > 
> > Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> 
> I am waiting until this is accepted into kernel before merging it
> into iproute2.

Yeah, I figured.  I had him resend it since our validation team did not
have these changes available to test Hiroshi's latest set of
driver/core changes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151012/01b9a561/attachment.asc>
