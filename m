From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 2 Nov 2021 11:59:45 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3] iavf: Add trace while
 removing device
In-Reply-To: <20210622134348.342191-1-jedrzej.jagielski@intel.com>
References: <20210622134348.342191-1-jedrzej.jagielski@intel.com>
Message-ID: <DM8PR11MB5621AB3CC7DE3C2BC6BBC3FEAB8B9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: wtorek, 22 czerwca 2021 15:44
> To: intel-wired-lan at lists.osuosl.org
> Cc: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v3] iavf: Add trace while removing
> device
> 
> From: =  Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> 
> Add kernel trace that device was removed.
> Currently there is no such information.
> I.e. Host admin removes a PCI device from a VM, than on VM shall be info
> about the event.
> 
> This patch adds info log to iavf_remove function.
> 
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index d64e2567e16e..60f08a5276b2 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
