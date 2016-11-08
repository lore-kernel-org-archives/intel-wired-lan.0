From: Benjamin Poirier <bpoirier@suse.com>
Date: Tue, 8 Nov 2016 14:52:00 +0800
Subject: [Intel-wired-lan] Kernel regression introduced by "e1000e: Do
 not write lsc to ics in msi-x mode" and/or "e1000e: Do not read ICR in
 Other interrupt"
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81FC067C@ORSMSX101.amr.corp.intel.com>
References: <1478044618.14119.774423193.0F79737A@webmail.messagingengine.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81FC067C@ORSMSX101.amr.corp.intel.com>
Message-ID: <20161108065200.77w6o5hz2uy4oukt@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2016/11/02 21:19, Brown, Aaron F wrote:
> > From: Jack Suter [mailto:jack at suter.io]
> > Sent: Tuesday, November 1, 2016 4:57 PM
> > To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> > Cc: intel-wired-lan at lists.osuosl.org; bpoirier at suse.com; Brown, Aaron F
> > <aaron.f.brown@intel.com>; jhodzic at ucdavis.edu; linux-
> > kernel at vger.kernel.org
> > Subject: Kernel regression introduced by "e1000e: Do not write lsc to ics in
> > msi-x mode" and/or "e1000e: Do not read ICR in Other interrupt"
> > 
> > Hi there,
> > 
> > I have some servers with an 82574L based NIC and recently upgraded from
> > a 4.4 series kernel to 4.7. Upon doing so, servers with this chipset
> > have begun frequently reporting "Link is Down" and "Link is Up"
> > messages. No other related network errors are reported by the kernel or
> > e1000e driver. I saw some reports about using "ethtool -s $iface msglvl
> > 6" to reveal more information, but nothing extra was reported.
> > 
> > Some testing showed that this was introduced between the 4.4 and 4.5
> > series. I was able to further narrow it down to two commits that look
> > related:
> > 
> >  e1000e: Do not write lsc to ics in msi-x mode
> >  (a61cfe4ffad7864a07e0c74969ca7ceb77ab2f1f)
> >  e1000e: Do not read ICR in Other interrupt
> >  (16ecba59bc333d6282ee057fb02339f77a880beb)
> 
> I did not notice any link flapping when I tested those patches, I would have rejected them if I had.  I have several systems with 82574L LOMs and as yet am not able to reproduce a link flap with recent upstream kernels/drivers (net-next 4.8.0 on one and 4.9.0-rc3 on another.) 
> 
> One of those systems is dedicated to a kernel regression setup, I checked the test logs from it and am not seeing any evidence of flaps in the 4.4, through 4.6 range either.
> 
> > 
> > Reverting these two commits resolves the Link is Down/Link is Up
> > messages. This has been tested on about six servers so far and all have
> > stopped reporting these link flaps.
> 
> Are you able to revert either of the patches independently, I don't recall if they were stand alone or not.

From what I recall, the series is entirely bisectable. I tested again
just now and could do a netperf RR test after applying each commit
sequentially.
