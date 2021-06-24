From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 24 Jun 2021 16:34:18 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Add support for the
 next LOM generation
In-Reply-To: <20210612170220.3930002-1-sasha.neftin@intel.com>
References: <20210612170220.3930002-1-sasha.neftin@intel.com>
Message-ID: <77b99082-c855-889f-d62c-3241eb40b1ca@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/12/2021 20:02, Sasha Neftin wrote:
> Add devices IDs for the next LOM generations that will be
> available on the next Intel Client platforms
> This patch provides the initial support for these devices
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/hw.h     | 4 ++++
>   drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++++
>   2 files changed, 8 insertions(+)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
