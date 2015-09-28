From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 28 Sep 2015 16:20:48 -0700
Subject: [Intel-wired-lan] [net PATCH v1] i40e: fix recursive rtnl lock
In-Reply-To: <20150925154552.00003ec5@intel.com>
References: <1443122442-21345-1-git-send-email-jesse.brandeburg@intel.com>
 <20150925154552.00003ec5@intel.com>
Message-ID: <20150928162048.00006d6f@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 25 Sep 2015 15:45:52 -0700
Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:

> On Thu, 24 Sep 2015 12:20:42 -0700
> Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:
> 
> > From: Anjali Singhai Jain <anjali.singhai@intel.com>
> > 
> > The sync_vsi_filters function can be called directly under RTNL
> > or through the timer subtask without one.  This was causing
> > a deadlock.
> 
> This patch was briefly tested, and does actually fix the bug it was
> meant to fix, but this patch may cause bugs, one we thought of today was
> if another thread grabs the RTNL, this patch will act as if it has it.
> 
> Another possible bug is that if another thread had the RTNL, it may
> release it while this patch's thread is not completed all the way.
> 
> We are working on a further patch/refinement.

Please drop this patch.
