From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 13 Jun 2019 21:27:07 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Check DDM existence in
 transceiver before access
In-Reply-To: <20190523191112.14572-1-maurosr@linux.vnet.ibm.com>
References: <20190523191112.14572-1-maurosr@linux.vnet.ibm.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3ED67D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Mauro S. M. Rodrigues
> Sent: Thursday, May 23, 2019 12:11 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: gromero at linux.vnet.ibm.com
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Check DDM existence in transceiver
> before access
> 
> Some transceivers may comply with SFF-8472 but not implement the Digital
> Diagnostic Monitoring (DDM) interface described in it. The existence of such
> area is specified by bit 6 of byte 92, set to 1 if implemented.
> 
> Currently, due to not checking this bit ixgbe fails trying to read sfp module's
> eeprom with the follow message:
> 
> ethtool -m enP51p1s0f0
> Cannot get Module EEPROM data: Input/output error
> 
> Because it fails to read the additional 256 bytes in which it was assumed to
> exist the DDM data.
> 
> This issue was noticed using a Mellanox Passive DAC PN 01FT738. The
> eeprom data was confirmed by Mellanox as correct and present in other
> Passive DACs in from other manufacturers.
> 
> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 3 ++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h     | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


