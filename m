From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 16 Dec 2016 22:47:44 +0000
Subject: [Intel-wired-lan] [next PATCH S57 10/11] i40e: Error handling
 for	link event
In-Reply-To: <1481586257-28872-11-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
 <1481586257-28872-11-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA49A0E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, December 12, 2016 3:44 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S57 10/11] i40e: Error handling for link
> event
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> There exists an intermittent bug which causes the 'Link Detected'
> field reported by the 'ethtool <iface>' command to be 'Yes' when in fact,
> there is no link. This patch fixes the problem by enabling temporary link
> polling when i40e_get_link_status returns an error. This causes the driver to
> remember that an admin queue command failed and polls, until the function
> returns with a success.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> Change-Id: I64c69b008db4017b8729f3fc27b8f65c8fe2eaa0
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


