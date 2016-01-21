From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 21 Jan 2016 17:31:08 +0000
Subject: [Intel-wired-lan] [PATCH] net: i40e: shut up uninitialized
 variable	warnings
In-Reply-To: <1453348397-79917-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1453348397-79917-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98BEB1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, January 20, 2016 7:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Subject: [Intel-wired-lan] [PATCH] net: i40e: shut up uninitialized variable
> warnings
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> intel/i40e/i40e_txrx.c: In function 'i40e_xmit_frame_ring':
> intel/i40e/i40e_txrx.c:2367:20: error: 'oiph' may be used uninitialized in this
> function [-Werror=maybe-uninitialized]
> intel/i40e/i40e_txrx.c:2317:16: note: 'oiph' was declared here
> intel/i40e/i40e_txrx.c:2367:17: error: 'oudph' may be used uninitialized in this
> function [-Werror=maybe-uninitialized]
> intel/i40e/i40e_txrx.c:2316:17: note: 'oudph' was declared here
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, no build warnings
