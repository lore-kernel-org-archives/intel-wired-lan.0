From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 23 May 2019 14:20:17 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Check DDM existence in
 transceiver before access
In-Reply-To: <20190523191112.14572-1-maurosr@linux.vnet.ibm.com>
References: <20190523191112.14572-1-maurosr@linux.vnet.ibm.com>
Message-ID: <20190523142017.00005c59@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 23 May 2019 16:11:12 -0300 Mauro wrote:
> Some transceivers may comply with SFF-8472 but not implement the Digital
> Diagnostic Monitoring (DDM) interface described in it. The existence of
> such area is specified by bit 6 of byte 92, set to 1 if implemented.
> 
> Currently, due to not checking this bit ixgbe fails trying to read sfp
> module's eeprom with the follow message:
> 
> ethtool -m enP51p1s0f0
> Cannot get Module EEPROM data: Input/output error
> 
> Because it fails to read the additional 256 bytes in which it was assumed
> to exist the DDM data.
> 
> This issue was noticed using a Mellanox Passive DAC PN 01FT738. The eeprom
> data was confirmed by Mellanox as correct and present in other Passive
> DACs in from other manufacturers.
> 
> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>

Looks reasonable, thanks for the patch!

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
