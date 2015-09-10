From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Sep 2015 22:38:11 +0000
Subject: [Intel-wired-lan] [next PATCH S15 03/15] i40e: Change some
 messages	from info to debug only
In-Reply-To: <1441315142-173025-4-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
 <1441315142-173025-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A6306@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, September 03, 2015 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S15 03/15] i40e: Change some
> messages from info to debug only
> 
> From: Neerav Parikh <neerav.parikh@intel.com>
> 
> There are several error messages that have been printing when there is no
> functional issue. These messages should be available at debug message level
> only.
> 
> Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Id91e47bf942c483563995f30d8705fa53acd5aa3
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  7 +++----
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.c   |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 21 +++++++++++++--------
>  3 files changed, 17 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
