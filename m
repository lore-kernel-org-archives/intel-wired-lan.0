From: Young, James M <james.m.young@intel.com>
Date: Thu, 2 Jul 2015 23:09:08 +0000
Subject: [Intel-wired-lan] [net-next S4 v2 11/15] i40e/i40evf:
	Update	Flex-10 related device/function capabilities
In-Reply-To: <1429745646-183026-2-git-send-email-catherine.sullivan@intel.com>
References: <1429745646-183026-1-git-send-email-catherine.sullivan@intel.com>
 <1429745646-183026-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1C57C@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, April 22, 2015 4:34 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Abodunrin, Akeem G; Orlowski, Pawel
> Subject: [Intel-wired-lan] [net-next S4 v2 11/15] i40e/i40evf: Update Flex-10
> related device/function capabilities
> 
> From: Pawel Orlowski <pawel.orlowski@intel.com>
> 
> The Flex10 device/function capability has been upgraded to include
> information needed to support Flex-10 configurations. This patch adds new
> fields to the i40e_hw_capabilities structure and updates
> i40e_parse_discover_capabilities functions to extract them from the AQ
> response. Naming convention has changed to use flex10 mode instead of
> existing mfp_mode_1.
> 
> Signed-off-by: Pawel Orlowski <pawel.orlowski@intel.com>
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I305dd888866985a30293acb3fb14fa43ca6b79ea
> ---
> v2: Change the order of variable declarations so it is in reverse pyramid
>     format
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 24
> +++++++++++++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 12 +++++++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_type.h | 12 +++++++++++-
>  4 files changed, 42 insertions(+), 8 deletions(-)
> 
Tested-By: Jim Young <james.m.young@intel.com>
Flex 10 is not currently testable but this patch doesn't break anything either.
Will re-test Flex 10 when we have the hardware support. 

