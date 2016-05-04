From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 May 2016 15:38:50 +0000
Subject: [Intel-wired-lan] [next PATCH S36 02/12] i40e: Add allmulti
 support	for the VF
In-Reply-To: <1462313600-3123-3-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
 <1462313600-3123-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D5964@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, May 03, 2016 3:13 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S36 02/12] i40e: Add allmulti support
> for the VF
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> This patch enables a feature to enable/disable all multicast for a trusted VF.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-Id: I926eba7f8850c8d40f8ad7e08bbe4056bbd3985f
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h          |  3 +++
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c     | 15 ++++++++++++++-
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 15 +++++++++++++--
>  3 files changed, 30 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver correctly reports multicast promiscuous mode when enabled
