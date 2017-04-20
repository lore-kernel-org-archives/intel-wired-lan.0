From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Apr 2017 23:05:10 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40evf: hide unused variable
In-Reply-To: <20170419173008.3648215-1-arnd@arndb.de>
References: <20170419173008.3648215-1-arnd@arndb.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA11B5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Arnd Bergmann
> Sent: Wednesday, April 19, 2017 10:30 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; linux-kernel at vger.kernel.org; Joe
> Perches <joe@perches.com>; netdev at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next] i40evf: hide unused variable
> 
> On architectures with larger pages, we get a warning about an unused
> variable:
> 
> drivers/net/ethernet/intel/i40evf/i40evf_main.c: In function
> 'i40evf_configure_rx':
> drivers/net/ethernet/intel/i40evf/i40evf_main.c:690:21: error: unused
> variable 'netdev' [-Werror=unused-variable]
> 
> This moves the declaration into the #ifdef to avoid the warning.
> 
> Fixes: dab86afdbbd1 ("i40e/i40evf: Change the way we limit the maximum
> frame size for Rx")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


