From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Wed, 4 Aug 2021 15:08:33 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove media type
 checking on the PHY initialization
In-Reply-To: <20210718094209.3692993-1-sasha.neftin@intel.com>
References: <20210718094209.3692993-1-sasha.neftin@intel.com>
Message-ID: <0e60a6cb-bee3-13d6-f454-b5b24b98caa7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/18/2021 12:42, Sasha Neftin wrote:
> i225 devices have only copper phy media type. There is no point in checking
> phy media type during the phy initialization.
> This patch comes to clean up these pointless checkings.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_base.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
