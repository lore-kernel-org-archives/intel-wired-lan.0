From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 14 Feb 2019 23:59:27 +0000
Subject: [Intel-wired-lan] [PATCH S11 08/16] ice: fix numeric overflow
 warning
In-Reply-To: <20190208205043.11975-9-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-9-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D366272@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S11 08/16] ice: fix numeric overflow
> warning
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> When compiling and analyzing the driver on newer kernels, a static analyzer
> warns about the following "numeric overflow" issues:
> 
>   "The result of expression: 'budget-1' generates 4-byte type while casting
>    to a bigger size of 8-byte".
> 
>   "The result of expression: '*words-words_read' generates 4-byte type
>    while casting to a bigger size of 8-byte".
> 
> Fix them both.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> squashed
> commits] [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> rewrote commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_nvm.c  | 7 ++++---
> drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


