From: naamax.meir <naamax.meir@linux.intel.com>
Date: Tue, 5 Apr 2022 11:17:52 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove igc_set_spd_dplx
 method
In-Reply-To: <20220321060510.1862932-1-sasha.neftin@intel.com>
References: <20220321060510.1862932-1-sasha.neftin@intel.com>
Message-ID: <d5806c62-5bf4-49ea-9c83-6d9c49c11b05@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/21/2022 08:05, Sasha Neftin wrote:
> igc_set_spd_dplx method not in use. This patch comes to tidy up
> the driver code.
> 
> Reported-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  1 -
>   drivers/net/ethernet/intel/igc/igc_main.c | 50 -----------------------
>   2 files changed, 51 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
