From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Oct 2016 22:28:01 +0000
Subject: [Intel-wired-lan] [next PATCH S51-V2 8/8] i40e: Add protocols
 over	MCTP to i40e_aq_discover_capabilities
In-Reply-To: <1477436933-13679-9-git-send-email-bimmy.pujari@intel.com>
References: <1477436933-13679-1-git-send-email-bimmy.pujari@intel.com>
 <1477436933-13679-9-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA292E3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, October 25, 2016 4:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Raczynski, Piotr <piotr.raczynski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S51-V2 8/8] i40e: Add protocols over
> MCTP to i40e_aq_discover_capabilities
> 
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> Add logical_id to I40E_AQ_CAP_ID_MNG_MODE capability starting from
> major version 2.
> 
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Change-ID: Idb29214b172ea5c70cbd45a99e6745c0215af7e4
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 8 ++++++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 4 ++++
>  drivers/net/ethernet/intel/i40evf/i40e_type.h | 4 ++++
>  3 files changed, 16 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


