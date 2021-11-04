From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Thu, 4 Nov 2021 11:08:23 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove obsolete nvm type
In-Reply-To: <20211031104556.2312804-1-sasha.neftin@intel.com>
References: <20211031104556.2312804-1-sasha.neftin@intel.com>
Message-ID: <b74fd42f-f911-d3e3-3152-bbe29e9d78d3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/31/2021 12:45, Sasha Neftin wrote:
> i225 devices use only spi nvm type. This patch comes to tidy up
> obsolete nvm types.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_hw.h   | 2 --
>   drivers/net/ethernet/intel/igc/igc_i225.c | 2 --
>   2 files changed, 4 deletions(-)
> 
> Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>
