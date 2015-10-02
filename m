From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 2 Oct 2015 21:54:48 +0000
Subject: [Intel-wired-lan] [next PATCH S17 10/11] i40e: Move error
 message	to debug level
In-Reply-To: <1443464220-148318-11-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
 <1443464220-148318-11-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2EF4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:17 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S17 10/11] i40e: Move error message
> to debug level
> 
> There is an error coming back from get_phy_capabilities that does not seem
> to have any functional implications. We will continue looking into why this
> error message is occurring, but in the meantime, we will move it to debug to
> avoid confusion.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I9091754bf62c066ddedeb249923d85606e2d68ed
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
