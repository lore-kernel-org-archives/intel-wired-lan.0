From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 20 May 2021 09:50:33 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused MDICNFG
 register
In-Reply-To: <20210502105708.3016965-1-sasha.neftin@intel.com>
References: <20210502105708.3016965-1-sasha.neftin@intel.com>
Message-ID: <aab8a72e-93a5-04a9-2c77-53944f681f21@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 02/05/2021 13:57, Sasha Neftin wrote:
> The MDICNFG register from igc registers is not used so remove it.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_regs.h | 1 -
>   1 file changed, 1 deletion(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
