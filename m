From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 20 Mar 2017 19:43:08 +0000
Subject: [Intel-wired-lan] [PART2 PATCH 7/9] i40e: implement support
	for	flexible word payload
In-Reply-To: <20170206223852.31177-8-jacob.e.keller@intel.com>
References: <20170206223852.31177-1-jacob.e.keller@intel.com>
 <20170206223852.31177-8-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040656E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, February 6, 2017 2:39 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PART2 PATCH 7/9] i40e: implement support for
> flexible word payload
> 
> Add support for flexible payloads passed via ethtool user-def field.
> This support is somewhat limited due to hardware design. The input set can
> only be programmed once per filter type, and the flexible offset is part of
> this filter input set. This means that the user cannot program both a regular
> and a flexible filter at the same time for a given flow type. Additionally, the
> user may not program two flexible filters of the same flow type with
> different offsets, although they are allowed to configure different values at
> that offset location.
> 
> We support a single flexible word (2byte) value per protocol type, and we
> handle the FLX_PIT register using a list of flexible entries so that each flow
> type may be configured separately.
> 
> Due to hardware implementation, the flexible data is offset from the start of
> the packet payload, and thus may not be in part of the header data. For this
> reason, the offset provided by the user defined data is interpreted as a byte
> offset from the start of the matching payload.
> Previous implementations have tried to represent the offset as from the
> start of the frame, but this is not feasible because header sizes may change
> due to options.
> 
> Testing-hints:
>   Need to ensure that multiple filters with same flex offset behave
>   correctly, and ensure that different L4 protocols inter-operate
>   correctly. README changes for this will be forth-coming.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: 36ed27995e97de63f9aea5ade5778ff038d6f811
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  83 +++++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 494
> ++++++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  16 +
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    |  27 ++
>  4 files changed, 608 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


