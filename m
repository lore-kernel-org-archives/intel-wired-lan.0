From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Aug 2015 22:55:00 +0000
Subject: [Intel-wired-lan] [PATCH 4/4] i40e: geneve tunnel offload
 support
In-Reply-To: <1440096383-8915-4-git-send-email-anjali.singhai@intel.com>
References: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
 <1440096383-8915-4-git-send-email-anjali.singhai@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016CEF5D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Anjali Singhai Jain
> Sent: Thursday, August 20, 2015 11:46 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 4/4] i40e: geneve tunnel offload support
> 
> This patch adds driver hooks to implement ndo_ops to add/del udp port in
> the HW to identify GENEVE tunnels.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 89
> ++++++++++++++++++++++++++++-
> drivers/net/ethernet/intel/i40e/i40e_txrx.c |  2 +-
>  3 files changed, 89 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Present in GIT log, code changes present in tree, does not break base driver
