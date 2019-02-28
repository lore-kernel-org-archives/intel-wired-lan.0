From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 22:57:42 +0000
Subject: [Intel-wired-lan] [PATCH S14 02/15] ice: Pull out page reuse
 checks onto separate function
In-Reply-To: <20190213185115.25877-3-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
 <20190213185115.25877-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3670D8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, February 13, 2019 10:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S14 02/15] ice: Pull out page reuse checks
> onto separate function
> 
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Introduce ice_can_reuse_rx_page which will verify whether the page can be
> reused and return the boolean result to caller.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 80 +++++++++++++++++----------
> ----
>  1 file changed, 45 insertions(+), 35 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


