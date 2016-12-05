From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 5 Dec 2016 11:44:47 +0100
Subject: [Intel-wired-lan] e1000e on Thinkpad x60: gigabit not available
	due to "SmartSpeed"
In-Reply-To: <20160902165735.GJ14311@csclub.uwaterloo.ca>
References: <20160901201408.GA5061@amd> <1472767093.3889.4.camel@gmail.com>
 <20160902165735.GJ14311@csclub.uwaterloo.ca>
Message-ID: <20161205104447.GA7536@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri 2016-09-02 12:57:35, Lennart Sorensen wrote:
> On Thu, Sep 01, 2016 at 02:58:13PM -0700, Greg wrote:
> > On Thu, 2016-09-01 at 22:14 +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > I have trouble getting 1000mbit out of my ethernet card.
> > > 
> > > I tried direct connection between two PCs with different cables, and
> > > no luck.
> > > 
> > > Today I tried connection to 1000mbit switch, and no luck, either. (Two
> > > cables, one was cat6, both short).
> > > 
> > > My computer sees 1000mbit being advertised by the other side, but does
> > > not advertise 1000mbit, "Link Speed was downgraded by SmartSpeed".
> > 
> > Check your cables?
> > 
> > https://vmxp.wordpress.com/2015/01/06/1gbe-intel-nic-throttled-to-100mbit-by-smartspeed/
> 
> Of course if it isn't the cable, then it could even be a broken pin in
> the port.  As far as I can tell, anything that causes one of the 3rd
> or 4th pairs of wires to not work will degrade to 100Mbit on just the
> first 2 pairs of wires and give that message.  Some badly implemented
> switches can also cause it of course.

Ok, so it seems like broken pin in the port. I realized I had docking
station available for the machine, and when connecting using that
connector (not internal notebook one), I get gigabit speed.

Thanks and best regards,
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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161205/bdef978f/attachment.asc>
