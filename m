From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 27 May 2016 22:24:55 +0000
Subject: [Intel-wired-lan] [PATCH v4 4/5] igb: implement igb_ptp_suspend
In-Reply-To: <20160524205631.21225-4-jacob.e.keller@intel.com>
References: <20160524205631.21225-1-jacob.e.keller@intel.com>
 <20160524205631.21225-4-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F108AF@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Tuesday, May 24, 2016 1:57 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v4 4/5] igb: implement igb_ptp_suspend
> 
> Make igb_ptp_stop take advantage of this new function to reduce code
> duplication.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h     |  1 +
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 22 +++++++++++++++++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
