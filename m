From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 11 Dec 2015 22:32:58 +0000
Subject: [Intel-wired-lan] [PATCH v2] igb: Add I210 cable fault
 detection to	self test
In-Reply-To: <52350642.317695.1449862744982.JavaMail.zimbra@xes-inc.com>
References: <494008248.99336.1449171467578.JavaMail.zimbra@xes-inc.com>
 <27181503.100057.1449171821628.JavaMail.zimbra@xes-inc.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81E2CB69@ORSMSX101.amr.corp.intel.com>,
 <52350642.317695.1449862744982.JavaMail.zimbra@xes-inc.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E2D0BF@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Aaron Sierra [asierra at xes-inc.com]
> Sent: Friday, December 11, 2015 11:39 AM
> To: Brown, Aaron F
> Cc: Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org; Matthew Vick; Joe Schultz
> Subject: Re: [Intel-wired-lan] [PATCH v2] igb: Add I210 cable fault detection to        self test
> 
> > From: "Aaron F Brown" <aaron.f.brown@intel.com>
> > Sent: Thursday, December 10, 2015 9:21:27 PM
> >
> > > From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf
> > > of Aaron Sierra [asierra at xes-inc.com]
> > > Sent: Thursday, December 03, 2015 11:43 AM
> > > To: Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org
> > > Cc: Matthew Vick; Joe Schultz
> > > Subject: [Intel-wired-lan] [PATCH v2] igb: Add I210 cable fault detection
> > > to    self test
> > >
> > > From: Joe Schultz <jschultz@xes-inc.com>
> > >
> > > Add an offline diagnostic test for the I210 internal PHY which checks
> > > ...
> > > ...
> > I'm also wondering if the fault distance checks are getting run with diags in
> > the offline mode and a cable is connected.  Whenever I run "ethtool -t ethX
> > offline" while I have a valid link I get a "-1", which I believe is the
> > default value, for the results on each pair.
> > --------------------------------------------------------------------------------------------------------------------------------
> > ...
> > Pair D cable fault   (offline)   0
> > Pair A fault distance            -1
> > Pair B fault distance            -1
> > Pair C fault distance            -1
> > Pair D fault distance            -1
> > Pair A fault open                0
> > ...
> --------------------------------------------------------------------------------------------------------------------------------
> > This is true with an i210 and i211 (other parts I have tried do not show the
> > fault checks, as expected.
> 
> Aaron,
> The test will not report real values unless the port is "up" when testing is
> done. Perhaps, we need to modify the test to ensure that it is in the
> necessary state via igb_power_up_link()?

Ah, that makes sense, even if the port is up when the test starts, the diags offline mode brings it down.  Yes, I could by into some way of bringing the link up so the test will get run properly.  Alternatively I guess you could bypass the test when in offline mode and throw a message stating the port needs to be up (run in online mode) for this set of checks.  I prefer bringing the link up and running it as offline is supposed to be a more inclusive set of tests than online.

> > > ...
> > > ...
> > > +       if (timeout >= 1500)
> > > +               dev_warn(&adapter->pdev->dev,
> > > +                       "Cable fault test timed out. Results may be
> > > invalid");
> >
> > How did you come up with this (1.5) second value?  I'm getting this message
> > fair amount of the time with what I thought are good cables plugged into
> > both ancient and modern switches.
> 
> The timeout value was chosen through testing. We don't know of any documented
> value that defines the typical runtime.
> 
> -Aaron S.

Nor do I.  Would the test being run with link down (offline mode) make the difference?  I only noticed the message when I was running in offline mode (but I also ran it a lot more often with offline as I was chasing those "-1"s.

Thanks, Aaron B.
