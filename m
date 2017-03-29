From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 29 Mar 2017 23:04:21 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] igb/igbvf: Add VF MAC filter
 request	capabilities
In-Reply-To: <1488874826-5978-3-git-send-email-yury.kylulin@intel.com>
References: <1488874826-5978-1-git-send-email-yury.kylulin@intel.com>
 <1488874826-5978-3-git-send-email-yury.kylulin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5E39D4@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yury Kylulin
> Sent: Tuesday, March 7, 2017 12:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/2] igb/igbvf: Add VF MAC filter request
> capabilities
> 
> Add functionality for the VF to request up to 3 additional MAC filters.
> This is done using existing E1000_VF_SET_MAC_ADDR message, but with
> additional message info - E1000_VF_MAC_FILTER_CLR to clear all unicast
> MAC filters previously set for this VF and E1000_VF_MAC_FILTER_ADD to
> add MAC filter.
> 
> Additional filters can be added only in case if administrator did not
> set VF MAC explicitly and allowed to change default MAC to the VF.
> 
> Due to the limmited number of RAR entries reserve at least 3 MAC filters
> for the PF.
> 
> If SRIOV is supported by the NIC after this change RAR entries starting
> from 1 to (RAR MAX ENTRIES - NUM SRIOV VFS) will be used for PF and VF
> MAC filters.
> 
> Signed-off-by: Yury Kylulin <yury.kylulin@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_mbx.h |   4 +
>  drivers/net/ethernet/intel/igb/igb.h       |  12 +++
>  drivers/net/ethernet/intel/igb/igb_main.c  | 147
> ++++++++++++++++++++++++++---
>  drivers/net/ethernet/intel/igbvf/igbvf.h   |   2 +
>  drivers/net/ethernet/intel/igbvf/mbx.h     |   4 +
>  drivers/net/ethernet/intel/igbvf/netdev.c  |  44 ++++++++-
>  drivers/net/ethernet/intel/igbvf/vf.c      |  42 +++++++++
>  drivers/net/ethernet/intel/igbvf/vf.h      |   1 +
>  8 files changed, 241 insertions(+), 15 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
