From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Jul 2015 21:24:46 +0000
Subject: [Intel-wired-lan] [next PATCH S9 13/15] i40e: warn on double
 free
In-Reply-To: <1437684884-222825-14-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-14-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE569@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, July 23, 2015 1:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S9 13/15] i40e: warn on double free
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Down was requesting queue disables, but then exited immediately without
> waiting for the queues to actually disable. This could allow any function called
> after i40evf_down to run immediately, including i40evf_up, and causes a
> memory leak.
> 
> This issue has been fixed in a recent refactor of the reset code, but add a
> couple WARN_ONs in the slow path to help us recognize if we reintroduce
> this issue or if we missed any cases.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I27b6b5c9a79c1892f0ba453129f116bc32647dd0
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Present in git log, code changes present in tree.
