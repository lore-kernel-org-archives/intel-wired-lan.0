From: naamax.meir <naamax.meir@linux.intel.com>
Date: Wed, 4 May 2022 11:25:14 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Change type of the
 'igc_check_downshift' method
In-Reply-To: <20220423165502.838143-1-sasha.neftin@intel.com>
References: <20220423165502.838143-1-sasha.neftin@intel.com>
Message-ID: <cb18dcef-08da-f932-bfed-72048babc396@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/23/2022 19:55, Sasha Neftin wrote:
> The 'igc_check_downshift' method always return 0 value. There is no point
> return value. Change the return type of this method to void.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_phy.c | 6 +-----
>   drivers/net/ethernet/intel/igc/igc_phy.h | 2 +-
>   2 files changed, 2 insertions(+), 6 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
