From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 4 Sep 2015 22:02:13 +0000
Subject: [Intel-wired-lan] [next PATCH S11 07/15] i40e:
	make	i40e_init_pf_fcoe to void
In-Reply-To: <1440616461-110869-8-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
 <1440616461-110869-8-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A591E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, August 26, 2015 12:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S11 07/15] i40e: make
> i40e_init_pf_fcoe to void
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> i40e_init_pf_fcoe() didn't return anything except 0, it prints enough error
> info already, and no driver logic depends on the return value, so this can be
> void.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Ie6afad849857d87a7064c42c3cce14c74c2f29d8
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.c | 10 ++++------
> drivers/net/ethernet/intel/i40e/i40e_main.c |  8 ++------
>  3 files changed, 7 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
