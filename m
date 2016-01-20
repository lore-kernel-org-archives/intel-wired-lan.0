From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jan 2016 23:58:51 +0000
Subject: [Intel-wired-lan] [next PATCH S28 11/15] i40e: better
	error	reporting for nvmupdate
In-Reply-To: <1452897202-15204-12-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
 <1452897202-15204-12-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F989D66@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S28 11/15] i40e: better error reporting
> for nvmupdate
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Make sure we return EBUSY while finishing up a reset, and add a few bits for
> better debug messages.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I23f6c28a8d96d7aa171abcc265737cec7826c292
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 39 +++++++++++++---------
> ----
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  5 +++-
>  2 files changed, 24 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, errors updated as expected
