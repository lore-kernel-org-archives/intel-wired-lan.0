From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 23 Oct 2015 23:28:20 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k:Fix error handling in the
 function fm10k_probe
In-Reply-To: <1445024551-21281-1-git-send-email-xerofoify@gmail.com>
References: <1445024551-21281-1-git-send-email-xerofoify@gmail.com>
Message-ID: <562B2504.1030409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/16/2015 12:42 PM, Nicholas Krause wrote:
> This fixes error handling in the function fm10k_probe to properly
> if the call to the function fm10k_iov_configure has failed by
> returning a error code before jumping to a new goto label,
> fm10k_iov_configure to clean up previously allocated resources
> between this goto label and the previous goto label before finally
> returning the error code to the callers of the function fm10k_probe
>
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>   drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> index ce53ff2..3d7374e 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> @@ -1844,13 +1844,17 @@ static int fm10k_probe(struct pci_dev *pdev,
>   	fm10k_slot_warn(interface);
>   
>   	/* enable SR-IOV after registering netdev to enforce PF/VF ordering */
> -	fm10k_iov_configure(pdev, 0);
> +	err = fm10k_iov_configure(pdev, 0);
> +	if (err)
> +		goto err_iov_configure;
>   
>   	/* clear the service task disable bit to allow service task to start */
>   	clear_bit(__FM10K_SERVICE_DISABLE, &interface->state);
>   
>   	return 0;
> -
> +err_iov_configure:
> +	fm10k_ptp_unregister(interface);
> +	unregister_netdev(netdev);
>   err_register:
>   	fm10k_mbx_free_irq(interface);
>   err_mbx_interrupt:

Failing to enable SR-IOV is not grounds for not brining up the 
interface.  The NIC is still usable, it just cannot do SR-IOV.

The only reason fm10k_iov_configure has a return value is because it is 
also passed through the PCI interface to allow the sysfs control.  If it 
returns an error there then it is much more important as the user 
actually requested it be enabled.

If you would like you could display a message there but this shouldn't 
be a hard error.

- Alex


