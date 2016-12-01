From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Dec 2016 18:26:16 +0000
Subject: [Intel-wired-lan] [next PATCH S55 01/14] i40e: Disabling
	ntuple	filters cleans Cloud Filters up
In-Reply-To: <1480377971-23412-2-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
 <1480377971-23412-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38ED0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 28, 2016 4:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sadowski, Filip <filip.sadowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S55 01/14] i40e: Disabling ntuple filters
> cleans Cloud Filters up
> 
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> This patch resolves the issue with Cloud Filters not being flushed from driver
> memory and HW when ntuple filters get disabled. Additionally it was possible
> to add Cloud Filters with ntuple mechanism off. Now Cloud Filters can be
> added only with ntuple enabled. Error code is returned otherwise.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> Change-ID: I7bbc43ead41ead59be89ae2ca440a5c77fef2086
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         | 39
> ++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  3 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 21 ++++++++++++++
>  3 files changed, 63 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


