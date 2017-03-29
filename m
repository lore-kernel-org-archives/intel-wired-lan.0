From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 29 Mar 2017 23:05:04 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] igb: improve MAC filter handling
In-Reply-To: <1488874826-5978-2-git-send-email-yury.kylulin@intel.com>
References: <1488874826-5978-1-git-send-email-yury.kylulin@intel.com>
 <1488874826-5978-2-git-send-email-yury.kylulin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5E39E8@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yury Kylulin
> Sent: Tuesday, March 7, 2017 12:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/2] igb: improve MAC filter handling
> 
> Using the work which was done for ixgbe driver by Jacob Keller
> commit 5d7daa35b9eb ("ixgbe: improve mac filter handling") and Alexander
> Duyck commit 0f079d22834a ("ixgbe: Use __dev_uc_sync and
> __dev_uc_unsync
> for unicast addresses") and out-of-tree igb driver add functionality to
> manage (add and delete) MAC filters.
> 
> Signed-off-by: Yury Kylulin <yury.kylulin@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |  11 ++
>  drivers/net/ethernet/intel/igb/igb_main.c | 246
> ++++++++++++++++++++++--------
>  2 files changed, 192 insertions(+), 65 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
