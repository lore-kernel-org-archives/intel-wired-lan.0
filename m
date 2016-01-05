From: Aaron Sierra <asierra@xes-inc.com>
Date: Tue, 5 Jan 2016 13:44:20 -0600 (CST)
Subject: [Intel-wired-lan] Add I210 cable fault detection to self test
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81E48F04@ORSMSX101.amr.corp.intel.com>
References: <907278953.561265.1450303005823.JavaMail.zimbra@xes-inc.com>
 <1481105116.578767.1450304180215.JavaMail.zimbra@xes-inc.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81E48F04@ORSMSX101.amr.corp.intel.com>
Message-ID: <102278362.74276.1452023060885.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

----- Original Message -----
> From: "Aaron F Brown" <aaron.f.brown@intel.com>
> Sent: Monday, January 4, 2016 5:56:31 PM
> 
> > From: Aaron Sierra [asierra at xes-inc.com]
> > Sent: Wednesday, December 16, 2015 2:16 PM
> > To: Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org
> > Cc: Wyborny, Carolyn; Brandeburg, Jesse; Williams, Mitch A; Brown, Aaron F;
> > Joe Schultz
> > Subject: [PATCH v3] igb: Add I210 cable fault detection to self test
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
> >  v3 - fix uninitialized variable compile warning
> >     - remove unneeded igb_cable_fault_test_prep() function
> >     - don't add unused define to e1000_defines.h
> >     - only run cable diagnostic if link test fails
> > 
> >  drivers/net/ethernet/intel/igb/e1000_defines.h |  12 +-
> >  drivers/net/ethernet/intel/igb/igb_ethtool.c   | 186
> >  ++++++++++++++++++++++++-
> >  2 files changed, 192 insertions(+), 6 deletions(-)
> 
> A question and a bug.  Question first since it's short:
> 
> Q. Was this version supposed to suppress running the cable diagnostics if the
> system has link?  I am still seeing the cable fault output (complete with -1
> for the fault distances) when I run ethtool -t against an i210 or i211.

Aaron,
This latest version should not *run* the cable diagnostics when link is
present, but it will *report* diagnostic results (i.e. fault status of
"false" and a length that suggests there's no fault). In the case of a
fault, a length of 0 means there's a fault within the first meter, so it
didn't seem appropriate to reuse that in the "no fault" case.
 
> When I run diagnostics against a number of parts I get a "Bug:  This version
> of the patch is causing (or exposing) a "BUG: unable to handle kernel paging
> request at ffffffffffffffff" followed by a Call Trace.  It does not seem to
> occur with i210 or i211, but I consistently get the trace on 82575EB, 82576,
> i350 and i354.

Interesting. I thought the only devices we had were I210, but I was able to
find an 82576. I'll do some testing with it.

-Aaron S.
