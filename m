From: naamax.meir <naamax.meir@linux.intel.com>
Date: Sun, 1 May 2022 11:25:33 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused phy_type
 enum
In-Reply-To: <20220413053317.3297670-1-sasha.neftin@intel.com>
References: <20220413053317.3297670-1-sasha.neftin@intel.com>
Message-ID: <4e3935cd-085f-cfe5-4c59-19d251ac3b24@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/13/2022 08:33, Sasha Neftin wrote:
> Complete to commit 8e153faf5827 ("igc: Remove unused phy type")
> i225 parts have only one phy. There is no point to use phy_type enum.
> Clean up the code accordingly, and get rid of the unused enum lines.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_base.c |  2 --
>   drivers/net/ethernet/intel/igc/igc_hw.h   |  7 -------
>   drivers/net/ethernet/intel/igc/igc_phy.c  | 10 +++-------
>   3 files changed, 3 insertions(+), 16 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
