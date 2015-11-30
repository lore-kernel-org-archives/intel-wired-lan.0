From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Nov 2015 19:20:15 +0000
Subject: [Intel-wired-lan] [V3: next PATCH S22 10/12] i40e: clean whole
 mac	filter list
In-Reply-To: <1447961665-12344-11-git-send-email-deepthi.kavalur@intel.com>
References: <1447961665-12344-1-git-send-email-deepthi.kavalur@intel.com>
 <1447961665-12344-11-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F966BF1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Thursday, November 19, 2015 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [V3: next PATCH S22 10/12] i40e: clean whole mac
> filter list
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Clean the whole mac filter list when resetting after an intermediate add or
> delete push to the firmware.  The code had evolved from using a list from
> the stack to a heap allocation, but the memset() didn't follow the change
> correctly.  This now cleans the whole list rather that just part of the first
> element.
> 
> Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I4cd03d5a103b7407dd8556a3a231e800f2d6f2d5
> ---
> Testing Hints :
> Compile and run the driver with basic ping tests. Also add and remove
> additional address filters and make sure they work as expected.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, adding/removing MAC filters works properly.
