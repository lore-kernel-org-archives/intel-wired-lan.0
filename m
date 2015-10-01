From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Oct 2015 16:50:28 +0000
Subject: [Intel-wired-lan] [next PATCH S16 03/15] i40e: remove
 read/write	failed messages from nvmupdate
In-Reply-To: <1443463964-148204-4-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
 <1443463964-148204-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2BDC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S16 03/15] i40e: remove read/write
> failed messages from nvmupdate
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Allow the nvmupdate application to decide when a read or write error should
> be exposed to the user.  Since the application needs to use write probes to
> find the ReadOnly sections on a potentially unknown NVM version in the HW
> and read probes to check the status of the last write, some error messages
> are expected, but need not be shown to the users.
> The driver doesn't know which are ignorable from real errors, so needs to let
> the application make the decision.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I78fca8ab672bede11c10c820b83c26adfd536d03
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree

