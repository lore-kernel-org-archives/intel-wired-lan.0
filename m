From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 10 Apr 2019 02:17:57 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix double definitions
In-Reply-To: <20190403135804.9229-1-sasha.neftin@intel.com>
References: <20190403135804.9229-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B97032A51@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Wednesday, April 3, 2019 6:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix double definitions
> 
> Collision threshold and threshold's shift has been defined twice.
> This patch comes to fix that.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
