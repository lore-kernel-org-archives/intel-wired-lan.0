From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 3 May 2019 01:11:47 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add flow control support
In-Reply-To: <20190418071108.35151-1-sasha.neftin@intel.com>
References: <20190418071108.35151-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9703FA67@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Thursday, April 18, 2019 12:11 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add flow control support
> 
> This change adds flow control settings. This is required to
> enable the legacy flow control support.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h |  3 +++
>  drivers/net/ethernet/intel/igc/igc_main.c    | 22
> ++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
