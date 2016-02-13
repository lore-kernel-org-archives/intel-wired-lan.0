From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 13 Feb 2016 06:27:19 +0000
Subject: [Intel-wired-lan] [PATCH v4] igb: Add I210 cable fault
	detection to self test
In-Reply-To: <1455014822.3592.42.camel@intel.com>
References: <520205889.412690.1454977910808.JavaMail.zimbra@xes-inc.com>,
 <1455014822.3592.42.camel@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E89FBB@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Kirsher, Jeffrey T
> Sent: Tuesday, February 09, 2016 2:47 AM
> To: Aaron Sierra; intel-wired-lan at lists.osuosl.org
> Cc: Wyborny, Carolyn; Brown, Aaron F; Joe Schultz
> Subject: Re: [PATCH v4] igb: Add I210 cable fault detection to self test
> 
> On Mon, 2016-02-08 at 18:31 -0600, Aaron Sierra wrote:
>>  From: Joe Schultz <jschultz@xes-inc.com>
> >
> >  Add an offline diagnostic test for the I210 internal PHY which checks
> > for cable faults and reports the distance along the cable where the
> > fault was detected. Fault types detected include open, short, and
> > cross-pair short.
> >
> > Signed-off-by: Joe Schultz <jschultz@xes-inc.com>
> > Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> > ---
> >  v2 - account for changes made by this patch in dev-queue:
> >    drivers/net: get rid of unnecessary initializations in> 
> > .get_drvinfo()
> >  v3 - fix uninitialized variable compile warning
> >     - remove unneeded igb_cable_fault_test_prep() function
> >     - don't add unused define to e1000_defines.h
> >     - only run cable diagnostic if link test fails
> >  v4 - only set no-fault, link-present cable distance for I210
> >
> >  drivers/net/ethernet/intel/igb/e1000_defines.h |? 12 +-
> >  drivers/net/ethernet/intel/igb/igb_ethtool.c   | 186
> > ++++++++++++++++++++++++-
> >  2 files changed, 192 insertions(+), 6 deletions(-)
> 
> I try not to be a checkpatch.pl stickler, but your patch clearly has
> some style issues that checkpatch.pl complains about and need to be
> fixed.  I have gone ahead and applied your patch to my next-queue tree
> (dev-queue branch) so that Aaron can test the functional changes of
> your patch.

> So I will require a v5 to fix the coding style issues that
> checkpatch.pl whines about, but before re-spinning your patch, lets
> wait to see if Aaron finds any other issues with your patch.

I no longer see the kernel panics on other parts with this patch, and functionally it seems good on all the parts I have scrounged up.  Thanks.

But I still see "-1" for the Pair fault distance's when a good cable is connected and diags are run offline:
...
Pair D cable fault   (offline)   0
Pair A fault distance            -1
Pair B fault distance            -1
Pair C fault distance            -1
Pair D fault distance            -1
Pair A fault open                0
...

I'm not sure the intent here, but having something other than 0 looks / feels like an error to me,  It's also confusing as those values come up as 0 if the diags are run with the online keyword with a valid cable connection.  The diag session itself (ethtool -t ethX offline) returns 0 so the test as a whole is registering as passing.
