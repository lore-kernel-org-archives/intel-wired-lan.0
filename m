From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 3 Dec 2015 23:36:20 +0000
Subject: [Intel-wired-lan] [PATCH] igb: fix NULL derefs due to
	skipped	SR-IOV enabling
In-Reply-To: <5624E0C102000078000AC476@prv-mh.provo.novell.com>
References: <5624E0C102000078000AC476@prv-mh.provo.novell.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E277D0@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Jan Beulich [JBeulich at suse.com]
> Sent: Monday, October 19, 2015 3:23 AM
> To: Kirsher, Jeffrey T
> Cc: sassmann at kpanic.de; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igb: fix NULL derefs due to skipped  SR-IOV enabling
> 
> The combined effect of commits 6423fc3416 ("igb: do not re-init SR-IOV
> during probe") and ceee3450b3 ("igb: make sure SR-IOV init uses the
> right number of queues") causes VFs no longer getting set up, leading
> to NULL pointer dereferences due to the adapter's ->vf_data being NULL
> while ->vfs_allocated_count is non-zero. The first commit not only
> neglected the side effect of igb_sriov_reinit() that the second commit
> tried to account for, but also that of setting IGB_FLAG_HAS_MSIX,
> without which igb_enable_sriov() is effectively a no-op. Calling
> igb_{,re}set_interrupt_capability() as done here seems to address this,
> but I'm not sure whether this is better than sinply reverting the other
> two commits.

> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: Stefan Assmann <sassmann@kpanic.de>
> Cc: Todd Fujinaka <todd.fujinaka@intel.com>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Shannon Nelson <shannon.nelson@intel.com>
> Cc: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Cc: Don Skidmore <donald.c.skidmore@intel.com>
> Cc: Matthew Vick <matthew.vick@intel.com>
> Cc: John Ronciak <john.ronciak@intel.com>
> Cc: Mitch Williams <mitch.a.williams@intel.com>
> ---
> As a side note, while looking at all the interactions here it seems
> suspicious to me that igb_request_msix() failure does not lead to
> SR-IOV being disabled on the device, despite IGB_FLAG_HAS_MSIX being
> set being a prereq to it as explained above.
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |    8 ++++++++
>  1 file changed, 8 insertions(+)

Checkpatch complains about using an empty /* line starting the comment:
---------------------------------------------------------------------------------------------------------------
WARNING: networking block comments don't use an empty /* line, use /* Comment...
#32: FILE: drivers/net/ethernet/intel/igb/igb_main.c:2862:
+       /*
+        * Of the below we really only want the effect of getting

total: 0 errors, 1 warnings, 0 checks, 14 lines checked
---------------------------------------------------------------------------------------------------------------

But otherwise this seems fine.  Given other comments in the file also abuse the style warning I will not hold the patch up for that, but feel free to change it and I'll get to the testing much quicker next time.

Tested-by: Aaron Brown <aaron.f.brown@intel.com>


