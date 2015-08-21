From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Aug 2015 22:54:12 +0000
Subject: [Intel-wired-lan] [PATCH 3/4] i40e: Generalize the UDP
	tunnel	offload flow
In-Reply-To: <1440096383-8915-3-git-send-email-anjali.singhai@intel.com>
References: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
 <1440096383-8915-3-git-send-email-anjali.singhai@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016CEF4C@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 3/4] i40e: Generalize the UDP tunnel
> offload flow
> 
> This patch generalizes the implementation for UDP based tunnel offloads so
> that VXLAN and any other UDP based tunnel protocols such as Geneve can
> utilize it.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 11 +++++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 50 ++++++++++++++----------
> -----  drivers/net/ethernet/intel/i40e/i40e_txrx.c |  6 ++--
> drivers/net/ethernet/intel/i40e/i40e_txrx.h |  2 +-
>  4 files changed, 37 insertions(+), 32 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

Present in GIT log, code changes present in tree, does not break base driver
