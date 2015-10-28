From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Oct 2015 21:25:39 +0000
Subject: [Intel-wired-lan] [next PATCH S20 08/15] i40evf: add new fields
 to	store user configuration of RSS
In-Reply-To: <1445903081-155893-9-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
 <1445903081-155893-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D484C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, October 26, 2015 4:45 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Helin
> Subject: [Intel-wired-lan] [next PATCH S20 08/15] i40evf: add new fields to
> store user configuration of RSS
> 
> From: Helin Zhang <helin.zhang@intel.com>
> 
> This patch adds new fields to i40e_vsi to store user configured RSS config
> data and code to use it.
> 
> Signed-off-by: Helin Zhang <helin.zhang@intel.com>
> Change-ID: Ic5d3db8d9df52182b560248f8cdca9c5c7546879
> 
> ---
> Testing-hints: Test ethtool -x and ethtool -X work correctly on VF.
> After VF reset, user configured settings via ethtool -X should be restored.
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  2 ++
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 31 ++++++++++--------
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 37
> ++++++++++++++++++++--
>  3 files changed, 54 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, ethtool -x and -X work on VF, settings persist across reset.
