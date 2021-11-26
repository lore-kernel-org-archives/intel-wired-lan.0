From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 26 Nov 2021 14:09:32 +0000
Subject: [Intel-wired-lan] [PATCH net v1] igb: Fix removal of unicast
 MAC filters of VFs
In-Reply-To: <20210831111635.16161-1-karen.sornek@intel.com>
References: <20210831111635.16161-1-karen.sornek@intel.com>
Message-ID: <DM8PR11MB56214858F2D5243A4E60E3FBAB639@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Karen Sornek
> Sent: wtorek, 31 sierpnia 2021 13:17
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sornek, Karen <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] igb: Fix removal of unicast MAC
> filters of VFs
> 
> Move checking condition of VF MAC filter before clearing or adding MAC
> filter to VF to prevent potential blackout caused by removal of neccessary
> and working VF's MAC filer.
> 
> Fixes: 1b8b062a99dc ("igb: add VF trust infrastructure")
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 28 +++++++++++------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index 842b50cc9..98e977fe5 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
