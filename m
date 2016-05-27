From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 27 May 2016 22:24:01 +0000
Subject: [Intel-wired-lan] [PATCH v4 2/5] igb:
	introduce	IGB_PTP_OVERFLOW_CHECK flag
In-Reply-To: <20160524205631.21225-2-jacob.e.keller@intel.com>
References: <20160524205631.21225-1-jacob.e.keller@intel.com>
 <20160524205631.21225-2-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F10880@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Tuesday, May 24, 2016 1:56 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v4 2/5] igb: introduce
> IGB_PTP_OVERFLOW_CHECK flag
> 
> Don't continue to use complex MAC type checks for handling various cases
> where we have overflow check code. Make this code more obvious by
> introducing a flag which is enabled for hardware that needs these
> checks.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h     |  1 +
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 21 ++++++++-------------
>  2 files changed, 9 insertions(+), 13 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
