From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 15 Dec 2017 20:04:51 +0100
Subject: [Intel-wired-lan] v4.15-rc2 on thinkpad x60: ethernet stopped
 working
In-Reply-To: <02874ECE860811409154E81DA85FBB5882B5FB49@ORSMSX115.amr.corp.intel.com>
References: <20171210083949.GA3872@amd>
 <d1ae924b-4d8f-a787-4c07-1f2db91482e5@gmail.com>
 <02874ECE860811409154E81DA85FBB5882B5FB2A@ORSMSX115.amr.corp.intel.com>
 <02874ECE860811409154E81DA85FBB5882B5FB49@ORSMSX115.amr.corp.intel.com>
Message-ID: <20171215190451.GA14423@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi!

> > > > Any ideas ?
> > >
> > > Yes , 19110cfbb34d4af0cdfe14cd243f3b09dc95b013 broke it.
> > >
> > > See:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=198047
> > >
> > > Fix there :
> > > https://marc.info/?l=linux-kernel&m=151272209903675&w=2
> > >
> > > Regards,
> > >
> > > Gabriel C
> > 
> > Hi,
> > 
> > Digging into this, the problem is complicated. The original bug assumed behavior
> > of the .check_for_link call, which is universally not implemented.
> > 
> > I think the correct fix is to revert 19110cfbb34d ("e1000e: Separate signaling for
> > link check/link up", 2017-10-10) and find a more proper solution.
> > 
> > I don't think any other code which uses check_for_link expects the interface to
> > return in the way this patch attempted.

> Alternatively, we can go a step farther and make sure every implementation of .check_for_link follows the modified interface.
> 

We are at -rc3 now. Reverting 19110cfbb34d seems like good solution at
the moment.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171215/19cf7295/attachment.asc>
