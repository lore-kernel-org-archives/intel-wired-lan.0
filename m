From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Aug 2017 18:05:41 +0000
Subject: [Intel-wired-lan] [next PATCH S78-V6 02/12] i40e: Add support
 for	'ethtool -m'
In-Reply-To: <20170807142839.60975-3-alice.michael@intel.com>
References: <20170807142839.60975-1-alice.michael@intel.com>
 <20170807142839.60975-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E8FC77@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 7, 2017 7:28 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Sadowski, Filip <filip.sadowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S78-V6 02/12] i40e: Add support for
> 'ethtool -m'
> 
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> This patch adds support for 'ethtool -m' command which displays information
> about (Q)SFP+ module plugged into NIC's cage.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  18 +++
>  drivers/net/ethernet/intel/i40e/i40e_common.c      |  69 +++++++++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 154
> +++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   9 ++
>  drivers/net/ethernet/intel/i40e/i40e_type.h        |  12 ++
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  18 +++
>  drivers/net/ethernet/intel/i40evf/i40e_common.c    |  69 +++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_prototype.h |   9 ++
>  drivers/net/ethernet/intel/i40evf/i40e_type.h      |  12 ++
>  9 files changed, 370 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


