From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 5 May 2015 23:26:21 +0000
Subject: [Intel-wired-lan] [PATCH 5/8] igb: only report generic filters
 in	get_ts_info
In-Reply-To: <1429738837-25158-5-git-send-email-jacob.e.keller@intel.com>
References: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
 <1429738837-25158-5-git-send-email-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DBECF7@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Wednesday, April 22, 2015 2:41 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 5/8] igb: only report generic filters in
> get_ts_info
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ----
>  1 file changed, 4 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
