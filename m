From: Aaron Sierra <asierra@xes-inc.com>
Date: Wed, 2 Dec 2015 14:42:42 -0600 (CST)
Subject: [Intel-wired-lan] [PATCH 5/5] igb: Add I210 cable fault
	detection to self test
In-Reply-To: <1448401741.3154.9.camel@intel.com>
References: <1327466653.305871.1446575860238.JavaMail.zimbra@xes-inc.com>
 <1448401741.3154.9.camel@intel.com>
Message-ID: <1639917347.80701.1449088962946.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

----- Original Message -----
> From: "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>
> To: "Aaron Sierra" <asierra@xes-inc.com>, intel-wired-lan at lists.osuosl.org
> Cc: "Carolyn Wyborny" <carolyn.wyborny@intel.com>, "Joe Schultz" <jschultz@xes-inc.com>
> Sent: Tuesday, November 24, 2015 3:49:01 PM
> Subject: Re: [PATCH 5/5] igb: Add I210 cable fault detection to self test
> 
> On Tue, 2015-11-03 at 12:37 -0600, Aaron Sierra wrote:
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
> > ?drivers/net/ethernet/intel/igb/e1000_defines.h |? 13 +-
> > ?drivers/net/ethernet/intel/igb/igb_ethtool.c?? | 192
> > ++++++++++++++++++++++++-
> > ?2 files changed, 199 insertions(+), 6 deletions(-)
> 
> This patch does not apply cleanly due to changes to igb_ethtool.c.
> ?Please update this patch with my current next-queue tree (dev-queue
> branch) and resubmit just this patch.

Jeff,
Sorry, I was out of the office last week. I'll look into getting you an
updated version of this patch soon.

-Aaron S.
