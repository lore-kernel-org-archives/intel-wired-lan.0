From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Oct 2018 19:17:24 +0000
Subject: [Intel-wired-lan] [next S97 v2 6/6] i40e: Allow disabling FW
 LLDP on X722 devices
In-Reply-To: <20181030175047.18874-6-jeffrey.t.kirsher@intel.com>
References: <20181030175047.18874-1-jeffrey.t.kirsher@intel.com>
 <20181030175047.18874-6-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D329057@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, October 30, 2018 10:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Patryk Ma?ek <patryk.malek@intel.com>
> Subject: [Intel-wired-lan] [next S97 v2 6/6] i40e: Allow disabling FW LLDP on
> X722 devices
> 
> From: Patryk Ma?ek <patryk.malek@intel.com>
> 
> This patch allows disabling FW LLDP agent on X722 devices.
> It also changes a source of information for this feature from
> pf->hw_features to pf->hw.flags which are set in i40e_init_adminq.
> 
> Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  1 -
>  drivers/net/ethernet/intel/i40e/i40e_common.c  |  3 +++
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 13 +++++++------
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 15 +++++++--------
>  4 files changed, 17 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


