From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Tue, 13 Jul 2021 10:03:27 +0300
Subject: [Intel-wired-lan] [PATCH v1 2/3] e1000e: Add polling mechanism
 to indicate CSME DPG exit
In-Reply-To: <20210624081846.568707-1-sasha.neftin@intel.com>
References: <20210624081846.568707-1-sasha.neftin@intel.com>
Message-ID: <8742cb49-3815-88f9-9f74-badd66cef160@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/24/2021 11:18, Sasha Neftin wrote:
> Per guidance from the CSME architecture team, it may take
> up to 1 second for unconfiguring dynamic power gating mode.
> Practically it can take more time. Wait up to 2.5 seconds to indicate
> dynamic power gating exit from the s0ix configuration. Detect
> scenarios that take more than 1 second but less than 2.5 seconds
> will emit warning message.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.h |  1 +
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 24 +++++++++++++++++++++
>   drivers/net/ethernet/intel/e1000e/regs.h    |  1 +
>   3 files changed, 26 insertions(+)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
