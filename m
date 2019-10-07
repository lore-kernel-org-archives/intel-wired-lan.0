From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 07 Oct 2019 14:48:28 -0700
Subject: [Intel-wired-lan] i40e_pto.c: Odd use of strlcpy converted from
 strncpy
In-Reply-To: <02fe65d8989ef1d030cf31c7134c574a242afc17.camel@perches.com>
References: <edf91d8284a2a19d956eb8b7e8b6c4984ceaa1ab.camel@perches.com>
 <a00c9af7d24ac0dd6af8698c9e545591392720fe.camel@intel.com>
 <02fe65d8989ef1d030cf31c7134c574a242afc17.camel@perches.com>
Message-ID: <c1d8f90b8a8bf97554f40aba85154088e5c1181c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2019-10-07 at 13:48 -0700, Joe Perches wrote:
> On Mon, 2019-10-07 at 13:44 -0700, Jeff Kirsher wrote:
> > On Sun, 2019-10-06 at 10:19 -0700, Joe Perches wrote:
> > > This got converted from strncpy to strlcpy but it's
> > > now not necessary to use one character less than the
> > > actual size.
> > > 
> > > Perhaps the sizeof() - 1 is now not correct and it
> > > should use strscpy and a normal sizeof.
> []
> > You are also missing you signed-off-by: and Fixes:, I can get your
> > change under test in the meantime to confirm your fix.
> 
> I didn't sign off as all I intended was to bring it
> to your attention.  The diff is just the simplest way.
> It's trivial if it's a defect.

Ah, thanks for bringing it to our attention.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191007/f37d0888/attachment.asc>
