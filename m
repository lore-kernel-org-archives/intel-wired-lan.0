From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Thu, 4 Nov 2021 11:05:45 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused _I_PHY_ID
 define
In-Reply-To: <20211013061926.464744-1-sasha.neftin@intel.com>
References: <20211013061926.464744-1-sasha.neftin@intel.com>
Message-ID: <56cf525d-5abe-6b4d-80d8-ae3fae2c5097@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/13/2021 09:19, Sasha Neftin wrote:
> _I_PHY_ID not in use. Clean up the code accordingly,
> and get rid of the unused define
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index fad27a4fea78..910ad1a0d375 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -605,9 +605,6 @@
>   #define PHY_1000T_CTRL		0x09 /* 1000Base-T Control Reg */
>   #define PHY_1000T_STATUS	0x0A /* 1000Base-T Status Reg */
>   
> -/* Bit definitions for valid PHY IDs. I = Integrated E = External */
> -#define I225_I_PHY_ID		0x67C9DC00
> -
>   /* MDI Control */
>   #define IGC_MDIC_DATA_MASK	0x0000FFFF
>   #define IGC_MDIC_REG_MASK	0x001F0000
> 
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>
