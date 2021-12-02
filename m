From: Stefan Dietrich <roots@gmx.de>
Date: Thu, 02 Dec 2021 09:34:03 +0100
Subject: [Intel-wired-lan] [PATCH] igc: Avoid possible deadlock during
 suspend/resume
In-Reply-To: <20211201185731.236130-1-vinicius.gomes@intel.com>
References: <87r1awtdx3.fsf@intel.com>
 <20211201185731.236130-1-vinicius.gomes@intel.com>
Message-ID: <5a4b31d43d9bf32e518188f3ef84c433df3a18b1.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vinicius,

thanks for the patch - unfortunately it did not solve the issue and I
am still getting reboots/lockups.


Cheers,
Stefan

On Wed, 2021-12-01 at 10:57 -0800, Vinicius Costa Gomes wrote:
> Inspired by:
> https://bugzilla.kernel.org/show_bug.cgi?id=215129
>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
> Just to see if it's indeed the same problem as the bug report above.
>
>  drivers/net/ethernet/intel/igc/igc_main.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index 0e19b4d02e62..c58bf557a2a1 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6619,7 +6619,7 @@ static void igc_deliver_wake_packet(struct
> net_device *netdev)
>  	netif_rx(skb);
>  }
>
> -static int __maybe_unused igc_resume(struct device *dev)
> +static int __maybe_unused __igc_resume(struct device *dev, bool rpm)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct net_device *netdev = pci_get_drvdata(pdev);
> @@ -6661,20 +6661,27 @@ static int __maybe_unused igc_resume(struct
> device *dev)
>
>  	wr32(IGC_WUS, ~0);
>
> -	rtnl_lock();
> +	if (!rpm)
> +		rtnl_lock();
>  	if (!err && netif_running(netdev))
>  		err = __igc_open(netdev, true);
>
>  	if (!err)
>  		netif_device_attach(netdev);
> -	rtnl_unlock();
> +	if (!rpm)
> +		rtnl_unlock();
>
>  	return err;
>  }
>
>  static int __maybe_unused igc_runtime_resume(struct device *dev)
>  {
> -	return igc_resume(dev);
> +	return __igc_resume(dev, true);
> +}
> +
> +static int __maybe_unused igc_resume(struct device *dev)
> +{
> +	return __igc_resume(dev, false);
>  }
>
>  static int __maybe_unused igc_suspend(struct device *dev)
> @@ -6738,7 +6745,7 @@ static pci_ers_result_t
> igc_io_error_detected(struct pci_dev *pdev,
>   *  @pdev: Pointer to PCI device
>   *
>   *  Restart the card from scratch, as if from a cold-boot.
> Implementation
> - *  resembles the first-half of the igc_resume routine.
> + *  resembles the first-half of the __igc_resume routine.
>   **/
>  static pci_ers_result_t igc_io_slot_reset(struct pci_dev *pdev)
>  {
> @@ -6777,7 +6784,7 @@ static pci_ers_result_t
> igc_io_slot_reset(struct pci_dev *pdev)
>   *
>   *  This callback is called when the error recovery driver tells us
> that
>   *  its OK to resume normal operation. Implementation resembles the
> - *  second-half of the igc_resume routine.
> + *  second-half of the __igc_resume routine.
>   */
>  static void igc_io_resume(struct pci_dev *pdev)
>  {

