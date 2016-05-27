From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 27 May 2016 22:23:40 +0000
Subject: [Intel-wired-lan] [PATCH v4 1/5] igb: introduce ptp_flags
 variable	and use it to replace IGB_FLAG_PTP
In-Reply-To: <20160524205631.21225-1-jacob.e.keller@intel.com>
References: <20160524205631.21225-1-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F10873@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Tuesday, May 24, 2016 1:56 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v4 1/5] igb: introduce ptp_flags variable
> and use it to replace IGB_FLAG_PTP
> 
> Upcoming patches will introduce new PTP specific flags. To avoid
> cluttering the normal flags variable, introduce PTP specific "ptp_flags"
> variable for this purpose, and move IGB_FLAG_PTP to become
> IGB_PTP_ENABLED.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h     | 5 ++++-
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 7 ++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
