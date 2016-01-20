From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jan 2016 19:31:38 +0000
Subject: [Intel-wired-lan] [next PATCH S28 02/15] i40e: drop unused
 debugfs	file "dump"
In-Reply-To: <1452897202-15204-3-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
 <1452897202-15204-3-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F988BCE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, January 15, 2016 2:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S28 02/15] i40e: drop unused debugfs
> file "dump"
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> There was a completely unused file "dump" in debugfs that never panned
> out to be useful.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I12bb9e37b5a83299725dda815a8746157baf6562
> ---
> Testing Hints: check debugfs, dump entry should be gone.
> 
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 250 -------------------------
>  1 file changed, 250 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, no file dump option in debugfs
