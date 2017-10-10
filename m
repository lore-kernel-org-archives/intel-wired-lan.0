From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Oct 2017 17:32:16 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: mark PM functions as
 __maybe_unused
In-Reply-To: <20171010081847.4090496-1-arnd@arndb.de>
References: <20171010081847.4090496-1-arnd@arndb.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAC218@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Arnd Bergmann
> Sent: Tuesday, October 10, 2017 1:18 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; netdev at vger.kernel.org; Williams,
> Mitch A <mitch.a.williams@intel.com>; linux-kernel at vger.kernel.org; intel-
> wired-lan at lists.osuosl.org; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH] i40e: mark PM functions as
> __maybe_unused
> 
> A cleanup of the PM code left an incorrect #ifdef in place, leading to a
> harmless build warning:
> 
> drivers/net/ethernet/intel/i40e/i40e_main.c:12223:12: error: 'i40e_resume'
> defined but not used [-Werror=unused-function]
> drivers/net/ethernet/intel/i40e/i40e_main.c:12185:12: error: 'i40e_suspend'
> defined but not used [-Werror=unused-function]
> 
> It's easier to use __maybe_unused attributes here, since you can't pick the
> wrong one.
> 
> Fixes: 0e5d3da40055 ("i40e: use newer generic PM support instead of legacy
> PM callbacks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


