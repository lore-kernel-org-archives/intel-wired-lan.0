From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 23 Feb 2016 03:18:07 +0000
Subject: [Intel-wired-lan] [PATCH v4] igb: Add I210 cable fault
	detection to self test
In-Reply-To: <1005410641.144149.1455905095795.JavaMail.zimbra@xes-inc.com>
References: <520205889.412690.1454977910808.JavaMail.zimbra@xes-inc.com>
 <1455014822.3592.42.camel@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81E89FBB@ORSMSX101.amr.corp.intel.com>
 <1005410641.144149.1455905095795.JavaMail.zimbra@xes-inc.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EA1636@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Aaron Sierra [mailto:asierra at xes-inc.com]
> Sent: Friday, February 19, 2016 10:05 AM
> To: Brown, Aaron F <aaron.f.brown@intel.com>
> Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; Wyborny, Carolyn <carolyn.wyborny@intel.com>; Joe
> Schultz <jschultz@xes-inc.com>
> Subject: Re: [PATCH v4] igb: Add I210 cable fault detection to self test
> 
> ----- Original Message -----
> > From: "Aaron F Brown" <aaron.f.brown@intel.com>
> > Sent: Saturday, February 13, 2016 12:27:19 AM
> >
> > > From: Kirsher, Jeffrey T
> > > Sent: Tuesday, February 09, 2016 2:47 AM
> > > To: Aaron Sierra; intel-wired-lan at lists.osuosl.org
> > > Cc: Wyborny, Carolyn; Brown, Aaron F; Joe Schultz
> > > Subject: Re: [PATCH v4] igb: Add I210 cable fault detection to self
> > > test
> > >
> > > On Mon, 2016-02-08 at 18:31 -0600, Aaron Sierra wrote:
> > >>  From: Joe Schultz <jschultz@xes-inc.com>
> > > >
> > > >  Add an offline diagnostic test for the I210 internal PHY which
> > > > checks for cable faults and reports the distance along the cable
> > > > where the fault was detected. Fault types detected include open,
> > > > short, and cross-pair short.
> > > >
> > > > Signed-off-by: Joe Schultz <jschultz@xes-inc.com>
> > > > Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> > > > ---
> > > > ...
> >
> > But I still see "-1" for the Pair fault distance's when a good cable
> > is connected and diags are run offline:
> > ...
> > Pair D cable fault   (offline)   0
> > Pair A fault distance            -1
> > Pair B fault distance            -1
> > Pair C fault distance            -1
> > Pair D fault distance            -1
> > Pair A fault open                0
> > ...
> >
> > I'm not sure the intent here, but having something other than 0 looks
> > / feels like an error to me,
> 
> I wanted to avoid using values for the fault distance that could reasonably be
> misinterpreted as presence of a fault. For instance, if no cable is connected,
> open faults should be detected on all pairs. The distance to those faults will
> be 0 because the trace lengths to the connector are almost certainly shorter
> than 1 meter. If link is present, fault distance should really be undefined, but
> is displayed as a signed integer.

That make sense, and I tend to agree.  Just that the Unix convention for 0 as passed / returned properly is so ingrained in me that my first instinct is something failed when I get something other than 0 back.  

> 
> > It's also confusing as those values come up as 0 if the diags are run
> > with the online keyword with a valid cable connection.
> > The diag session itself (ethtool -t ethX offline) returns 0 so the
> > test as a whole is registering as passing.
> 
> I can see this either way and defaulting to zero would be easier.
> 
> This difference in result output is unintentional, but this leads me to wonder
> what reasonable output for the online case should look like, since none of
> the fault tests will be run in that case.

I'm not really sure, but I feel it should be consistent with the results of an offline test that is run with a good cable attached.  Anyone out there have an opinion on this and want to weigh in?

> I think these strings should include an
> (offline) tag, like the original tests.

I agree, the offline tag makes sense. 

Would it be possible to suppress the fault distance messages if no fault is found?  I'm not all that familiar with ethtool's inner workings.

> 
> In order to do that I'm inclined to merge inter and intra pair shorts into a
> single short output, like this:
> 
> Register test         (offline)
> Eeprom test           (offline)
> Interrupt test        (offline)
> Loopback test         (offline)
> Link test          (on/offline)
> Pair A cable fault    (offline)
> Pair B cable fault    (offline)
> Pair C cable fault    (offline)
> Pair D cable fault    (offline)
> Pair A fault distance (offline)
> Pair B fault distance (offline)
> Pair C fault distance (offline)
> Pair D fault distance (offline)
> Pair A fault open     (offline)
> Pair B fault open     (offline)
> Pair C fault open     (offline)
> Pair D fault open     (offline)
> Pair A fault short    (offline)
> Pair B fault short    (offline)
> Pair C fault short    (offline)
> Pair D fault short    (offline)
> 
> Please let me know what you think.

I think that's just a matter of how much info you want to show and how you envision people using the info.  If differentiating between inter and intra is likely to help someone track a problem down by all means keep both.  If you expect people to simply toss the cable and try a new one including both forms is probably just extra noise.

Thanks Aaron B.
