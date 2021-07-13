From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Tue, 13 Jul 2021 10:04:00 +0300
Subject: [Intel-wired-lan] [PATCH v1 3/3] e1000e: Additional PHY power
 saving in s0ix
In-Reply-To: <20210624081908.568757-1-sasha.neftin@intel.com>
References: <20210624081908.568757-1-sasha.neftin@intel.com>
Message-ID: <f1c4b6cb-a32c-1c06-a135-c4415ed69533@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/24/2021 11:19, Sasha Neftin wrote:
> After transferring the MAC-PHY interface to the SMBus the PHY
> will save power in S0ix low power idle mode.
> 
> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
