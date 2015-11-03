From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 3 Nov 2015 23:19:40 +0000
Subject: [Intel-wired-lan] [PATCH v2] fm10k: don't initialize
 fm10k_workqueue at global level
In-Reply-To: <804857E1F29AAC47BF68C404FC60A1847EC76570@ORSMSX105.amr.corp.intel.com>
References: <1446579302-11494-1-git-send-email-jacob.e.keller@intel.com>
 <804857E1F29AAC47BF68C404FC60A1847EC762DE@ORSMSX105.amr.corp.intel.com>
 <1446591912.3990.28.camel@intel.com>
 <804857E1F29AAC47BF68C404FC60A1847EC76570@ORSMSX105.amr.corp.intel.com>
Message-ID: <1446592780.3990.33.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-11-03 at 23:15 +0000, Allan, Bruce W wrote:
> > -----Original Message-----
> > From: Keller, Jacob E
> > Sent: Tuesday, November 03, 2015 3:05 PM
> > To: Allan, Bruce W; intel-wired-lan at lists.osuosl.org
> > Subject: Re: [PATCH v2] fm10k: don't initialize fm10k_workqueue at
> > global
> > level
> > 
> > On Tue, 2015-11-03 at 22:40 +0000, Allan, Bruce W wrote:
> > > > -----Original Message-----
> > > > From: Keller, Jacob E
> > > > Sent: Tuesday, November 03, 2015 11:35 AM
> > > > To: Intel Wired LAN
> > > > Cc: Allan, Bruce W; Keller, Jacob E
> > > > Subject: [PATCH v2] fm10k: don't initialize fm10k_workqueue at
> > > > global level
> > > > 
> > > > From: Bruce Allan <bruce.w.allan@intel.com>
> > > > 
> > > > Cleans up checkpatch GLOBAL_INITIALIZERS error
> > > > 
> > > > Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> > > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > > > ---
> > > > -v2
> > > > * Fix title from checkpatch complaint
> > > 
> > > Out of curiosity, what was wrong with the original v1 patch title
> > > and
> > > what was the exact checkpatch complaint?
> > > 
> > 
> > checkpatch.pl results for patch "[PATCH] fm10k: fix checkpatch
> > GLOBAL_INITIALISERS error"
> > 
> > WARNING:EMAIL_SUBJECT: A patch subject line should describe the
> > change
> > not the tool that found it
> > #4:
> > Subject: [PATCH] fm10k: fix checkpatch GLOBAL_INITIALISERS error
> > 
> > total: 0 errors, 1 warnings, 0 checks, 24 lines checked
> > 
> > 
> > Regards,
> > Jake
> 
> Which version of checkpatch and options did you use?  I tried with
> the one in Jeff's tree and others but do not get the same.


The one in Jeff's tree did it for me, and has been since commit 

a2fe16b9d878 ("checkpatch: try to avoid poor patch subject lines")

I get: 


WARNING: A patch subject line should describe the change not the tool that found it
#4: 
Subject: [PATCH] fm10k: fix checkpatch GLOBAL_INITIALISERS error

total: 0 errors, 1 warnings, 0 checks, 24 lines checked

Your patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS. 


Regards,
Jake
