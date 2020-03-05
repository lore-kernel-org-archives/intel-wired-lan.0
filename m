From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 5 Mar 2020 01:42:34 +0000
Subject: [Intel-wired-lan] [PATCH] igc: Fix overwrites when dumping
 registers
In-Reply-To: <20200228081957.61782-1-andre.guedes@intel.com>
References: <20200228081957.61782-1-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B972014AE@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, February 28, 2020 12:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igc: Fix overwrites when dumping
> registers
> 
> This patch fixes some register overwriting when dumping registers via
> ethtool.
> 
> We have a total of 16 RAL registers, starting at offset 139. So RAH
> offset should be 139 + 16 = 155, not 145. As result some RAL registers
> are overwritten. Likewise, RAH registers are also overwritten by TDBAL,
> TDBAH, TDLEN, and TDH registers.
> 
> To fix this bug while preserving the ABI, this patch re-writes RAL and
> RAH registers at the end of 'regs_buff' and bumps regs->version. It also
> removes some pointless comments in the middle of igc_set_regs().
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
