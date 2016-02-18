From: Brandeburg, Jesse <jesse.brandeburg@intel.com>
Date: Thu, 18 Feb 2016 00:35:39 +0000
Subject: [Intel-wired-lan] [next PATCH S29 08/14] i40e: Fix PSOD's when
 npar	enabled
In-Reply-To: <1455754344-6372-9-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-9-git-send-email-avinash.dayanand@intel.com>
Message-ID: <253CF818969A9240AB2054BF91F2C2BC377343E7@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The title of this patch must be fixed.

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Avinash Dayanand
Sent: Wednesday, February 17, 2016 4:12 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [next PATCH S29 08/14] i40e: Fix PSOD's when npar enabled

From: John Underwood <johnx.underwood@intel.com>

Return from i40e_vsi_reinit_setup() if vsi param is NULL.
This makes this code consistent with all the other code that
checks for NULL before using one of the VSI pointers accessed
with an indexed variable. (Indexed VSI pointers are
intentionally set to NULL in i40e_vsi_clear() and
i40e_remove().

Signed-off-by: John Underwood <johnx.underwood@intel.com>
Change-ID: I3bc8b909c70fd2439334eeae994d151f61480985
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
