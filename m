From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 18 Jun 2021 21:42:04 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Add trace while
 removing device
In-Reply-To: <20210618084730.20524-1-jedrzej.jagielski@intel.com>
References: <20210618084730.20524-1-jedrzej.jagielski@intel.com>
Message-ID: <57f776bcb6fbce788ea1528f0d967ff35d1f5ac8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-06-18 at 08:47 +0000, J?drzej Jagielski wrote:
> Add kernel trace that device was removed.
> Currently there is no such information.
> I.e. Host admin removes a PCI device from a VM,
> than on VM shall be info about the event.
> 
> This patch adds info log to iavf_remove function.
> 
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Are you using the correct tree? Rebasing before you send? This patch
doesn't apply.

Also, can you change either your From or Signed-off-by to match?

WARNING: From:/Signed-off-by: email name mismatch: 'From: "J?drzej
Jagielski" <jedrzej.jagielski@intel.com>' != 'Signed-off-by: Jedrzej
Jagielski <jedrzej.jagielski@intel.com>'
> 
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 4fead5903..b2a5fcb52 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -3973,6 +3973,7 @@ static void iavf_remove(struct pci_dev *pdev)
>  				 err);
>  	}
>  
> +	dev_info(&adapter->pdev->dev, "Removing device\n");
>  	/* Shut down all the garbage mashers on the detention level */
>  	adapter->state = __IAVF_REMOVE;
>  	adapter->aq_required = 0;
