From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Nov 2015 21:28:10 +0000
Subject: [Intel-wired-lan] [PATCH v4 3/6] i40e: Generalize the flow for
 udp	based tunnels
In-Reply-To: <1447178205-99510-3-git-send-email-anjali.singhai@intel.com>
References: <1447178205-99510-1-git-send-email-anjali.singhai@intel.com>
 <1447178205-99510-3-git-send-email-anjali.singhai@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E1FBB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Anjali Singhai Jain
> Sent: Tuesday, November 10, 2015 9:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4 3/6] i40e: Generalize the flow for udp
> based tunnels
> 
> This patch generalizes the driver flow to make room for more than just
> VXLAN tunnel by defining a common data structure with tunnel type.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 11 ++++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 54 ++++++++++++++++-------
> ------  drivers/net/ethernet/intel/i40e/i40e_txrx.c |  6 ++--
> drivers/net/ethernet/intel/i40e/i40e_txrx.h |  2 +-
>  4 files changed, 41 insertions(+), 32 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
