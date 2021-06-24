From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 24 Jun 2021 16:31:21 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Check the PCIm state
In-Reply-To: <20210607061912.2356057-1-sasha.neftin@intel.com>
References: <20210607061912.2356057-1-sasha.neftin@intel.com>
Message-ID: <62bee0c4-6349-9cdd-c95e-6d8ded864f1c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/7/2021 09:19, Sasha Neftin wrote:
> Complete to commit def4ec6dce393e ("e1000e: PCIm function state support")
> Check the PCIm state only on CSME systems. There is no point to do this
> check on none CSME systems.
> This patch fixes a generation a false-positive warning:
> "Error in exiting dmoff"
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 24 ++++++++++++----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
