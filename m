From: Aaron Sierra <asierra@xes-inc.com>
Date: Fri, 11 Dec 2015 13:39:04 -0600 (CST)
Subject: [Intel-wired-lan] [PATCH v2] igb: Add I210 cable fault
 detection to	self test
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81E2CB69@ORSMSX101.amr.corp.intel.com>
References: <494008248.99336.1449171467578.JavaMail.zimbra@xes-inc.com>
 <27181503.100057.1449171821628.JavaMail.zimbra@xes-inc.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81E2CB69@ORSMSX101.amr.corp.intel.com>
Message-ID: <52350642.317695.1449862744982.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

----- Original Message -----
> From: "Aaron F Brown" <aaron.f.brown@intel.com>
> Sent: Thursday, December 10, 2015 9:21:27 PM
> 
> > From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf
> > of Aaron Sierra [asierra at xes-inc.com]
> > Sent: Thursday, December 03, 2015 11:43 AM
> > To: Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org
> > Cc: Matthew Vick; Joe Schultz
> > Subject: [Intel-wired-lan] [PATCH v2] igb: Add I210 cable fault detection
> > to    self test
> > 
> > From: Joe Schultz <jschultz@xes-inc.com>
> > 
> > Add an offline diagnostic test for the I210 internal PHY which checks
> > for cable faults and reports the distance along the cable where the
> > fault was detected. Fault types detected include open, short, and
> > cross-pair short.
> > 
> > Signed-off-by: Joe Schultz <jschultz@xes-inc.com>
> > Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> > ---
> >  v2 - account for changes made by this patch in dev-queue:
> >    drivers/net: get rid of unnecessary initializations in .get_drvinfo()
> > 
> >  drivers/net/ethernet/intel/igb/e1000_defines.h |  13 +-
> >  drivers/net/ethernet/intel/igb/igb_ethtool.c   | 189
> >  ++++++++++++++++++++++++-
> >  2 files changed, 197 insertions(+), 5 deletions(-)
> >
> 
> This introduces a compile warning:
> --------------------------------------------------------------------------------------------------------------------------------
>   CC [M]  drivers/net/ethernet/intel/igb/igb_ethtool.o
> drivers/net/ethernet/intel/igb/igb_ethtool.c: In function
> ?igb_cable_fault_test?:
> drivers/net/ethernet/intel/igb/igb_ethtool.c:2074: warning: ?pcdc? may be
> used uninitialized in this function
>   CC [M]  drivers/net/ethernet/intel/igb/e1000_82575.o
> --------------------------------------------------------------------------------------------------------------------------------
> 
> I'm also wondering if the fault distance checks are getting run with diags in
> the offline mode and a cable is connected.  Whenever I run "ethtool -t ethX
> offline" while I have a valid link I get a "-1", which I believe is the
> default value, for the results on each pair.
> --------------------------------------------------------------------------------------------------------------------------------
> ...
> Pair D cable fault   (offline)   0
> Pair A fault distance            -1This is true with an i210 and i211 (other
> parts I have tried do not show the fault checks, as expected.
> Pair B fault distance            -1
> Pair C fault distance            -1
> Pair D fault distance            -1
> Pair A fault open                0
> ...
> --------------------------------------------------------------------------------------------------------------------------------
> This is true with an i210 and i211 (other parts I have tried do not show the
> fault checks, as expected.

Aaron,
The test will not report real values unless the port is "up" when testing is
done. Perhaps, we need to modify the test to ensure that it is in the
necessary state via igb_power_up_link()?

> > ...
> > ...
> > +       /* Wait up to 1.5s for the results to be ready */
> > +       while (pcdc & I347AT4_PCDC_CABLE_DIAG_STATUS) {
> > +               ret_val = igb_read_phy_reg(hw, I347AT4_PCDC, &pcdc);
> > +               if (ret_val || timeout == 1500)
> > +                       break;
> > +               udelay(1000);
> > +               timeout++;
> > +       }
> > +
> > +       if (timeout >= 1500)
> > +               dev_warn(&adapter->pdev->dev,
> > +                       "Cable fault test timed out. Results may be
> > invalid");
> 
> How did you come up with this (1.5) second value?  I'm getting this message
> fair amount of the time with what I thought are good cables plugged into
> both ancient and modern switches.

The timeout value was chosen through testing. We don't know of any documented
value that defines the typical runtime.

-Aaron S.
