From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 8 Sep 2017 11:28:27 +0200
Subject: [Intel-wired-lan] [PATCH] e1000e: changed some expensive calls
 of udelay to usleep_range
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B8C69E5E5@ORSMSX101.amr.corp.intel.com>
References: <1503503985-3869-1-git-send-email-matthew.tan_1@nxp.com>
 <20170904162555.GB21849@amd>
 <309B89C4C689E141A5FF6A0C5FB2118B8C69E5E5@ORSMSX101.amr.corp.intel.com>
Message-ID: <20170908092827.GC18365@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu 2017-09-07 22:19:47, Brown, Aaron F wrote:
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> > Behalf Of Pavel Machek
> > Sent: Monday, September 4, 2017 9:26 AM
> > To: Matthew Tan <matthew.tan_1@nxp.com>
> > Cc: michael.kardonik at nxp.com; Williams, Mitch A
> > <mitch.a.williams@intel.com>; linux-kernel at vger.kernel.org;
> > john.ronciak at intel.com; intel-wired-lan at lists.osuosl.org;
> > netdev at vger.kernel.org
> > Subject: Re: [Intel-wired-lan] [PATCH] e1000e: changed some expensive calls
> > of udelay to usleep_range
> > 
> > Hi!
> > 
> > > @@ -183,7 +183,7 @@ s32 e1000e_read_phy_reg_mdic(struct e1000_hw
> > *hw, u32 offset, u16 *data)
> > >  	 * reading duplicate data in the next MDIC transaction.
> > >  	 */
> > >  	if (hw->mac.type == e1000_pch2lan)
> > > -		udelay(100);
> > > +		usleep_range(90, 100);
> > >
> > >  	return 0;
> > >  }
> > 
> > Can you explain why shortening the delay is acceptable here?
> 
> Maybe it's not.
> 
> This patch is causing speed / duplex tests to fail on several of my test systems.  Specifically a Lenova laptop with an 82577 and a NUC with an i218 (though that does not mean it is limited to those or that it's not related to the individual link partner.)
>

Ok, this should be quite easy to verify -- just adjust all the ranges
to be >= original ones.

Thanks,
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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170908/f37ebd8b/attachment.asc>
