From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 22 Jul 2019 19:18:01 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Check if transceiver implements
 DDM before access
In-Reply-To: <20190718175202.14909-1-maurosr@linux.vnet.ibm.com>
References: <20190718175202.14909-1-maurosr@linux.vnet.ibm.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40C549@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Mauro S. M. Rodrigues
> Sent: Thursday, July 18, 2019 10:52 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: wangyugui at e16-tech.com
> Subject: [Intel-wired-lan] [PATCH] i40e: Check if transceiver implements
> DDM before access
> 
> Similar to the ixgbe issue fixed in:
> 655c91414579 ("ixgbe: Check DDM existence in transceiver before access)
> 
> i40e has the same issue when reading eeprom from SFP's module that
> comply with SFF-8472 but not implement the Digital Diagnostic Monitoring
> (DDM) interface described in it. The existence of such area is specified by bit
> 6 of byte 92, set to 1 if implemented.
> 
> Without this patch, due to not checking this bit i40e fails to read SFP module's
> eeprom with the follow message:
> 
> ethtool -m enP51p1s0f0
> Cannot get Module EEPROM data: Input/output error
> 
> Because it fails to read the additional 256 bytes in which it was assumed to
> exist the DDM data.
> 
> Signed-off-by: "Mauro S. M. Rodrigues" <maurosr@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 ++++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h    | 1 +
>  2 files changed, 7 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


