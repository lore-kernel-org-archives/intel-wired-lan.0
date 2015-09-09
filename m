From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 17:40:15 +0000
Subject: [Intel-wired-lan] [next PATCH S12 02/15] i40e: Additional
 checks	for CEE APP priority validity
In-Reply-To: <1440690163-128213-3-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
 <1440690163-128213-3-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5D37@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S12 02/15] i40e: Additional checks for
> CEE APP priority validity
> 
> From: Neerav Parikh <neerav.parikh@intel.com>
> 
> The firmware has added additional status information to allow software to
> determine if the APP priority for FCoE/iSCSI/FIP is valid or not in CEE DCBX
> mode.
> 
> This patch adds to support those additional checks and will only add
> applications to the software table that have oper and sync bits set without
> any error.
> 
> Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
> Change-ID: I0a76c52427dadf97d4dba4538a3068d05e4eb56b
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c | 48 ++++++++++++++++++++--
> --------
>  1 file changed, 33 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree

