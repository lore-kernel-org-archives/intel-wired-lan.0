From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Mon, 21 Jun 2021 15:32:34 +0300
Subject: [Intel-wired-lan] [PATCH next-queue v1 3/5] igc: Allow for Flex
 Filters to be installed
In-Reply-To: <20210611003924.492853-4-vinicius.gomes@intel.com>
References: <20210611003924.492853-1-vinicius.gomes@intel.com>
 <20210611003924.492853-4-vinicius.gomes@intel.com>
Message-ID: <cc6c5ca1-4180-fd71-f677-0c0b0a413086@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/11/2021 03:39, Vinicius Costa Gomes wrote:
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
