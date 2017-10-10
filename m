From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Oct 2017 17:43:07 +0000
Subject: [Intel-wired-lan] [PATCH v3 09/14 net-next] i40e: Add new phy
 types	for 25G AOC and ACC support
In-Reply-To: <20171005215344.2886-10-alan.brady@intel.com>
References: <20171005215344.2886-1-alan.brady@intel.com>
 <20171005215344.2886-10-alan.brady@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAC2C2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alan Brady
> Sent: Thursday, October 5, 2017 2:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Malek, Krzysztof <krzysztof.malek@intel.com>
> Subject: [Intel-wired-lan] [PATCH v3 09/14 net-next] i40e: Add new phy
> types for 25G AOC and ACC support
> 
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> This patch adds support for 25G Active Optical Cables (AOC) and Active
> Copper Cables (ACC) phy types.
> 
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> Signed-off-by: Krzysztof Malek <krzysztof.malek@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 4 ++++
>  drivers/net/ethernet/intel/i40e/i40e_common.c       | 2 ++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c      | 2 ++
>  drivers/net/ethernet/intel/i40e/i40e_type.h         | 4 ++++
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 4 ++++
>  5 files changed, 16 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


