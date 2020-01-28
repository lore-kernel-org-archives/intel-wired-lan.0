From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Tue, 28 Jan 2020 09:31:13 +0200
Subject: [Intel-wired-lan] [PATCH v1] igc: Add pcie error handler support
In-Reply-To: <5a057e0a-c746-ce58-8dbe-9a31ab883c4f@molgen.mpg.de>
References: <20200127115831.18047-1-sasha.neftin@intel.com>
 <5a057e0a-c746-ce58-8dbe-9a31ab883c4f@molgen.mpg.de>
Message-ID: <94dad75b-4f03-de9f-a36b-a87384bbafcc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/27/2020 16:53, Paul Menzel wrote:
> Dear Sasha,
> 
> 
> Thank you for your patch set.
> 
> 
> On 2020-01-27 12:58, Sasha Neftin wrote:
>> Add pcie error detection, slot reset and resume capability
> 
> Tested how?
> 
Tested on the platform with error-prone PCIe slot and system has been 
recovered. To more testing, I would recommend using peripheral 
equipment. Lecroy's PCIe test board could be a good option.
>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_main.c | 105 ++++++++++++++++++++++++++++++
>>   1 file changed, 105 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>> index fa72460e255a..b0656ae2fcb3 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -5076,6 +5076,110 @@ static void igc_shutdown(struct pci_dev *pdev)
>>   	}
>>   }
>>   
>> +/**
>> + *  igc_io_error_detected - called when PCI error is detected
>> + *  @pdev: Pointer to PCI device
>> + *  @state: The current pci connection state
> 
> PCI
> 
good. I will change.
>> + *
>> + *  This function is called after a PCI bus error affecting
>> + *  this device has been detected.
> 
> Document the two possible return codes?
> 
I will elaborate on the comment.
>> + **/
>> +static pci_ers_result_t igc_io_error_detected(struct pci_dev *pdev,
>> +					      pci_channel_state_t state)
>> +{
>> +	struct net_device *netdev = pci_get_drvdata(pdev);
>> +	struct igc_adapter *adapter = netdev_priv(netdev);
>> +
>> +	netif_device_detach(netdev);
>> +
>> +	if (state == pci_channel_io_perm_failure)
>> +		return PCI_ERS_RESULT_DISCONNECT;
>> +
>> +	if (netif_running(netdev))
>> +		igc_down(adapter);
>> +	pci_disable_device(pdev);
>> +
>> +	/* Request a slot slot reset. */
> 
> One slot?
> 
yes, typo.
>> +	return PCI_ERS_RESULT_NEED_RESET;
>> +}
>> +
>> +/**
>> + *  igc_io_slot_reset - called after the pci bus has been reset.
> 
> PCI
> 
ok.
>> + *  @pdev: Pointer to PCI device
>> + *
>> + *  Restart the card from scratch, as if from a cold-boot. Implementation
>> + *  resembles the first-half of the igc_resume routine.
> 
> Shouldn?t the common code be factored out then?
> 
I prefer stay align with our legacy code in other drivers.
>> + **/
>> +static pci_ers_result_t igc_io_slot_reset(struct pci_dev *pdev)
>> +{
>> +	struct net_device *netdev = pci_get_drvdata(pdev);
>> +	struct igc_adapter *adapter = netdev_priv(netdev);
>> +	struct igc_hw *hw = &adapter->hw;
>> +	pci_ers_result_t result;
>> +
>> +	if (pci_enable_device_mem(pdev)) {
>> +		dev_err(&pdev->dev,
>> +			"Cannot re-enable PCI device after reset.\n");
> 
> *Could not*, so it?s clear, it was tried, and not a policy decision.
> 
ok.
>> +		result = PCI_ERS_RESULT_DISCONNECT;
>> +	} else {
>> +		pci_set_master(pdev);
>> +		pci_restore_state(pdev);
>> +		pci_save_state(pdev);
>> +
>> +		pci_enable_wake(pdev, PCI_D3hot, 0);
>> +		pci_enable_wake(pdev, PCI_D3cold, 0);
>> +
>> +		/* In case of PCI error, adapter lose its HW address
> 
> lose*s*
> 
ok.
>> +		 * so we should re-assign it here.
>> +		 */
>> +		hw->hw_addr = adapter->io_addr;
>> +
>> +		igc_reset(adapter);
>> +		wr32(IGC_WUS, ~0);
>> +		result = PCI_ERS_RESULT_RECOVERED;
>> +	}
>> +
>> +	return result;
> 
> You can get rid of the if-else statement, by returning in the if branch,
> and use the else branch as the follow-on(?). Then you can return the
> result directly too, and even remove the variable `result`.
> 
I prefer stay with a legacy code to align with other ours drivers.
>> +}
>> +
>> +/**
>> + *  igc_io_resume - called when traffic can start flowing again.
> 
> start to flow
> 
ok, thanks.
>> + *  @pdev: Pointer to PCI device
>> + *
>> + *  This callback is called when the error recovery driver tells us that
>> + *  its OK to resume normal operation. Implementation resembles the
>> + *  second-half of the igc_resume routine.
>> + */
>> +static void igc_io_resume(struct pci_dev *pdev)
>> +{
>> +	struct net_device *netdev = pci_get_drvdata(pdev);
>> +	struct igc_adapter *adapter = netdev_priv(netdev);
>> +	u32 err = 0;
>> +
>> +	rtnl_lock();
>> +	if (netif_running(netdev)) {
>> +		err = igc_open(netdev);
>> +		if (err) {
> 
> Use `if (igc_open(netdev)) {`, and remove variable `err`?
> 
good idea. thanks
>> +			dev_err(&pdev->dev, "igic_open failed after reset\n");
>> +			return;
>> +		}
>> +	}
>> +
>> +	netif_device_attach(netdev);
>> +
>> +	/* let the f/w know that the h/w is now under the control of the
>> +	 * driver.
>> +	 */
>> +	igc_get_hw_control(adapter);
>> +	rtnl_unlock();
>> +}
>> +
>> +static const struct pci_error_handlers igc_err_handler = {
>> +	.error_detected = igc_io_error_detected,
>> +	.slot_reset = igc_io_slot_reset,
>> +	.resume = igc_io_resume,
>> +};
>> +
>>   #ifdef CONFIG_PM
>>   static const struct dev_pm_ops igc_pm_ops = {
>>   	SET_SYSTEM_SLEEP_PM_OPS(igc_suspend, igc_resume)
>> @@ -5093,6 +5197,7 @@ static struct pci_driver igc_driver = {
>>   	.driver.pm = &igc_pm_ops,
>>   #endif
>>   	.shutdown = igc_shutdown,
>> +	.err_handler = &igc_err_handler,
>>   };
>>   
>>   /**
>>
> 
Paul, thanks for your feedback - I will submit v2 and address your comments.
