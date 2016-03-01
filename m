From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 01 Mar 2016 15:55:09 -0800
Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211
 using a device tree blob V5
In-Reply-To: <DC20A3D2-95E2-420B-911D-C6AC02338227@gmail.com>
References: <56C5A6BC.6030708@gmail.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81EA731A@ORSMSX101.amr.corp.intel.com>
 <DC20A3D2-95E2-420B-911D-C6AC02338227@gmail.com>
Message-ID: <1456876509.3039.10.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-03-01 at 07:56 +0100, John Holland wrote:
> On Mar 1, 2016, at 03:52, Brown, Aaron F <aaron.f.brown@intel.com>
> wrote:
> 
> > This throws a few checkpatch warnings, but I won't withhold my
> tested by for these:
> >?
> > total: 0 errors, 2 warnings, 0 checks, 21 lines checked
> >?
> > Your patch has style problems, please review.
> >?
> > NOTE: If any of the errors are false positives, please report
> >????? them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > u1463:[0]/usr/src/kernels/next-queue>
> 
> Thanks for testing...
> 
> Do you require me to reformat the patch text? And won't that break
> the link?

No, that checkpatch.pl warning on the link you provided is fine,
although I will clean up your signed-off-by when I go to push it
upstream. :-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160301/7abd7605/attachment.asc>
