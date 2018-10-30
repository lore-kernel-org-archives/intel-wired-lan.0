From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 22:20:55 +0000
Subject: [Intel-wired-lan] [PATCH S9 05/15] ice: Remove
 ICE_MAX_TXQ_PER_TXQG check when configuring Tx queue
In-Reply-To: <20181026184447.13547-6-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
 <20181026184447.13547-6-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328DD9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 11:45 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S9 05/15] ice: Remove
> ICE_MAX_TXQ_PER_TXQG check when configuring Tx queue
> 
> From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> 
> This patch removes the condition checking of VSI TX queue number to
> ICE_MAX_TXQ_PER_TXQG. This is an unnecessary check and causes a driver
> load error on hosts that have more than 128 cores.
> 
> Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 4 ----
>  1 file changed, 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


