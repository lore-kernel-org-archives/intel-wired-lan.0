From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 17 Sep 2016 02:23:31 +0000
Subject: [Intel-wired-lan] [PATCH] igb: restore PPS signal on
 igb_ptp_reset
In-Reply-To: <20160909161051.8954-1-jacob.e.keller@intel.com>
References: <20160909161051.8954-1-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F90DF2@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Friday, September 9, 2016 9:11 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH] igb: restore PPS signal on igb_ptp_reset
> 
> When a reset occurs, the PPS SYS_WRAP interrupt was not re-enabled which
> resulted in disabling of the PPS signaling. Fix this by recording when
> the interrupt is on and ensuring that we re-enable it every time we
> reset.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h     | 1 +
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
