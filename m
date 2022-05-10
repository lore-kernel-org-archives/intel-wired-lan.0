From: naamax.meir <naamax.meir@linux.intel.com>
Date: Tue, 10 May 2022 07:47:22 +0300
Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Remove unused phy_type
 enum
In-Reply-To: <20220423165321.838055-1-sasha.neftin@intel.com>
References: <20220423165321.838055-1-sasha.neftin@intel.com>
Message-ID: <77c9df0a-f5d6-b653-201f-2bc57e5ceeae@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/23/2022 19:53, Sasha Neftin wrote:
> Complete to commit 8e153faf5827 ("igc: Remove unused phy type")
> i225 parts have only one phy. There is no point to use phy_type enum.
> Clean up the code accordingly, and get rid of the unused enum lines.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
> v2: ret_val isn't needed since it's always returning 0
>   drivers/net/ethernet/intel/igc/igc_base.c |  2 --
>   drivers/net/ethernet/intel/igc/igc_hw.h   |  7 -------
>   drivers/net/ethernet/intel/igc/igc_phy.c  | 12 +++---------
>   3 files changed, 3 insertions(+), 18 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
