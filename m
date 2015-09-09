From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 21:06:12 +0000
Subject: [Intel-wired-lan] [next PATCH S12 13/15] i40e/i40evf:
 Explicitly	assign enum index for VSI type
In-Reply-To: <1440690163-128213-14-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
 <1440690163-128213-14-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5E3C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, August 27, 2015 8:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Kong, Serey
> Subject: [Intel-wired-lan] [next PATCH S12 13/15] i40e/i40evf: Explicitly assign
> enum index for VSI type
> 
> From: Serey Kong <serey.kong@intel.com>
> 
> Ran into an issue where PF's VSI type list was different from VF's, which was
> resulted in different enum index. The VSI type list can be different
> depending on what build flag is used for PF and VF.
> 
> The change is to explicitly assign enum index for each VSI type so that PF and
> VF always reference to the same VSI type event if the enum lists are
> different.
> 
> Signed-off-by: Serey Kong <serey.kong@intel.com>
> Change-ID: I8c0e5fdb515f324f7964df863a458073cf467e57
> ---
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 16 ++++++++--------
>  drivers/net/ethernet/intel/i40evf/i40e_type.h | 16 ++++++++--------
>  2 files changed, 16 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
