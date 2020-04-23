From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Apr 2020 19:41:09 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused registers
In-Reply-To: <20200412142158.32900-1-sasha.neftin@intel.com>
References: <20200412142158.32900-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB28901AC9A1CE83E3FC9B8D70BCD30@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Sunday, April 12, 2020 7:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused registers
> 
> Tx data FIFO Head/Tail, Saved and Packet Count registers
> not applicable for i225 LAN controller.
> This patch comes to clean up these registers.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_dump.c | 4 ----
>  drivers/net/ethernet/intel/igc/igc_regs.h | 5 -----
>  2 files changed, 9 deletions(-)
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
