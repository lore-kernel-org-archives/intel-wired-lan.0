From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Mar 2018 21:15:23 +0000
Subject: [Intel-wired-lan] [net-next PATCH] ixgbevf: fix unused variable
 warning
In-Reply-To: <20180228231745.366681-1-arnd@arndb.de>
References: <20180228231745.366681-1-arnd@arndb.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94AFD1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Arnd Bergmann
> Sent: Wednesday, February 28, 2018 3:18 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [net-next PATCH] ixgbevf: fix unused variable
> warning
> 
> The new ixgbevf_set_rx_buffer_len() function causes a harmless warnings in
> configurations with large page size:
> 
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function
> 'ixgbevf_set_rx_buffer_len':
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:1758:15: error: unused
> variable 'max_frame' [-Werror=unused-variable]
> 
> This rephrases the code so that the compiler can see the use of that variable,
> making it slightly easier to read in the process.
> 
> Fixes: f15c5ba5b6cd ("ixgbevf: add support for using order 1 pages to receive
> large frames")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


