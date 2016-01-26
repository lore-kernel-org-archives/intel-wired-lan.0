From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 Jan 2016 01:11:48 +0000
Subject: [Intel-wired-lan] [next PATCH S28 13/15] i40e: clean
	event	descriptor before use
In-Reply-To: <1452897202-15204-14-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
 <1452897202-15204-14-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C568@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S28 13/15] i40e: clean event
> descriptor before use
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> In one obscure corner case, it was possible to clear the NVM update wait flag
> when no update_done message was actually received.  This patch cleans the
> event descriptor before use, and moves the opcode check to where it won't
> get done if there was no event to clean.
> 
> Also update copyright year in file headers.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I68bbc41965e93f4adf07cbe98b9dfd63d41509a4
> ---
> Testing Hints:
> Do an NVM update on that specific customer's platform.
> 
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c   | 20 +++++++++++---------
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.c |  5 ++++-
>  2 files changed, 15 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, updated successfully
