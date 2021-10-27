From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 27 Oct 2021 08:56:07 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Add helper function
 to go from pci_dev to adapter
In-Reply-To: <20210915064123.69945-1-karen.sornek@intel.com>
References: <20210915064123.69945-1-karen.sornek@intel.com>
Message-ID: <DM8PR11MB5621D240B634033A5BB9B029AB859@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Karen Sornek
> Sent: ?roda, 15 wrze?nia 2021 08:41
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sornek, Karen <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Add helper function to go
> from pci_dev to adapter
> 
> Add helper function to go from pci_dev to adapter to make work simple - to
> go from a pci_dev to the adapter structure and make netdev assigment
> instead of having to go to the net_device then the adapter.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 24 +++++++++++++++------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 80437ef26..39620fe6c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -51,6 +51,15 @@ MODULE_LICENSE("GPL v2");  static const struct
> net_device_ops iavf_netdev_ops;  struct workqueue_struct *iavf_wq;
> 

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
