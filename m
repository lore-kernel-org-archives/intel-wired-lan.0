From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Aug 2017 20:54:34 +0000
Subject: [Intel-wired-lan] [next PATCH S78-V8 12/12] i40e: Stop
	dropping	802.1ad tags (eth proto 0x88a8
In-Reply-To: <20170822105754.29486-13-alice.michael@intel.com>
References: <20170822105754.29486-1-alice.michael@intel.com>
 <20170822105754.29486-13-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E9F398@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 22, 2017 3:58 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S78-V8 12/12] i40e: Stop dropping
> 802.1ad tags (eth proto 0x88a8
> 
> From: Scott Peterson <scott.d.peterson@intel.com>
> 
> Enable i40e to pass traffic with VLAN tags using the 802.1ad ethernet protocol
> ID (0x88a8).
> 
> This requires NIC firmware providing version 1.7 of the API. With older NIC
> firmware 802.1ad tagged packets will continue to be dropped.
> 
> No VLAN offloads nor RSS are supported for 802.1ad VLANs.
> 
> Signed-off-by: Scott Peterson <scott.d.peterson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c       |  6 ++++++
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 17
> ++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_common.c       |  6 +++++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c         |  7 +++++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h         |  6 ++++++
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 17
> ++++++++++++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_type.h       |  6 ++++++
>  7 files changed, 62 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


