From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 27 May 2016 22:24:35 +0000
Subject: [Intel-wired-lan] [PATCH v4 3/5] igb: re-use igb_ptp_reset
	in	igb_ptp_init
In-Reply-To: <20160524205631.21225-3-jacob.e.keller@intel.com>
References: <20160524205631.21225-1-jacob.e.keller@intel.com>
 <20160524205631.21225-3-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F10898@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Tuesday, May 24, 2016 1:56 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v4 3/5] igb: re-use igb_ptp_reset in
> igb_ptp_init
> 
> Modify igb_ptp_init to take advantage of igb_ptp_reset, and remove
> duplicated work that was occurring in both igb_ptp_reset and
> igb_ptp_init.
> 
> In total, resetting the TSAUXC register, and resetting the system time
> both happen in igb_ptp_reset already. igb_ptp_reset now also takes care
> of starting the delayed work item for overflow checks, as well.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |  3 +-
>  drivers/net/ethernet/intel/igb/igb_ptp.c  | 48 +++++++++++--------------------
>  2 files changed, 18 insertions(+), 33 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
