From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 6 Dec 2021 12:19:46 +0000
Subject: [Intel-wired-lan] [PATCH net-next] iavf: Fix asynchronous tasks
 during driver remove
In-Reply-To: <20210121160605.86278-1-eryk.roch.rybak@intel.com>
References: <20210121160605.86278-1-eryk.roch.rybak@intel.com>
Message-ID: <DM8PR11MB56216E06D1F2A3F43E744BDFAB6D9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Eryk Rybak
> Sent: czwartek, 21 stycznia 2021 17:06
> To: intel-wired-lan at lists.osuosl.org
> Cc: Rybak, Eryk Roch <eryk.roch.rybak@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next] iavf: Fix asynchronous tasks
> during driver remove
> 
> Although rare, is possible for unexpected driver watchdog or Admin Queue
> tasks to run during the execution of iavf_remove function.
> Then, is not possible to obtain the standard __IAVF_IN_CRITICAL_TASK lock
> and difficult to ensure that the driver state stays consistent during the full
> removal process.
> 
> Fully stops all asynchronous tasks in the beginning of iavf_remove, and uses
> a single-threaded flow to shut down the driver.
> 
> Fixes: fdd4044ffdc8("iavf: Remove timer for work triggering, use delaying
> work instead")
> Signed-off-by: Nick Nunley <nicholas.d.nunley@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Eryk Rybak <eryk.roch.rybak@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 29 ++++++++++++++++-----
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 21a354e..84430a3 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
