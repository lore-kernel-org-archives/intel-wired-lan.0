From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 8 Jul 2021 14:37:41 +0300
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/5] igc: Allow for Flex
 Filters to be installed
In-Reply-To: <20210629044332.3491232-4-vinicius.gomes@intel.com>
References: <20210629044332.3491232-1-vinicius.gomes@intel.com>
 <20210629044332.3491232-4-vinicius.gomes@intel.com>
Message-ID: <daea1976-d970-f4a8-7f77-64b37cc7ded7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/29/2021 07:43, Vinicius Costa Gomes wrote:
> Allows Flex Filters to be installed.
> 
> The previous restriction to the types of filters that can be installed
> can now be lifted.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
