From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 3 Jun 2015 02:39:08 +0000
Subject: [Intel-wired-lan] [PATCH v2 3/5] e1000e: fix systim issues
In-Reply-To: <0a640614d95d2eb2a279c3d9d0c3fd7121bd499f.1433253642.git.yanirx.lubetkin@intel.com>
References: <5c0f5ad24e5ae3adfede0279b6fdfea4312e32da.1433253642.git.yanirx.lubetkin@intel.com>
 <0a640614d95d2eb2a279c3d9d0c3fd7121bd499f.1433253642.git.yanirx.lubetkin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DDE387@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yanir Lubetkin
> Sent: Tuesday, June 02, 2015 7:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 3/5] e1000e: fix systim issues
> 
> Two issues involving systim were reported.
> 1. clock is not running in the correct fequency
> 2. in some situations, systim values were not incremented linearly
> This patch fixes the hardware clock configuration and the spurious non-
> linear increment.
> 
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/e1000.h  |  4 ++++
>  drivers/net/ethernet/intel/e1000e/netdev.c | 37 +++++++++++++++++++++----
> -----
>  2 files changed, 30 insertions(+), 11 deletions(-)

Description spells "frequency" as "fequency", otherwise...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
