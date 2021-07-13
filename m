From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Tue, 13 Jul 2021 10:02:52 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/3] e1000e: Add handshake with the
 CSME to support s0ix
In-Reply-To: <20210624081827.568657-1-sasha.neftin@intel.com>
References: <20210624081827.568657-1-sasha.neftin@intel.com>
Message-ID: <bfb206c4-162b-17fb-b5a8-04d5d7ef471c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/24/2021 11:18, Sasha Neftin wrote:
> On the corporate system, the driver will ask from the CSME
> (manageability engine) to perform device settings are required
> to allow s0ix residency.
> This patch provides initial support.
> 
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.h |   2 +
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 328 +++++++++++---------
>   2 files changed, 176 insertions(+), 154 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
