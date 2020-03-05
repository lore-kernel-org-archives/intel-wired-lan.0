From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 5 Mar 2020 01:47:13 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix double definition
In-Reply-To: <20200228175007.31144-1-sasha.neftin@intel.com>
References: <20200228175007.31144-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B972014C4@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Friday, February 28, 2020 9:50 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix double definition
> 
> IGC_START_ITR has beed defined twice
> This patch come to fix it
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
