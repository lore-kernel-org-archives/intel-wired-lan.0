From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Sun, 22 Mar 2020 13:36:06 +0200
Subject: [Intel-wired-lan] [PATCH v2] igc: add support to interrupt,
 eeprom, registers and link self-tests
In-Reply-To: <158465511927.38369.12297264423437326370@aarayaol-mobl.amr.corp.intel.com>
References: <20200318135446.10921-1-vitaly.lifshits@intel.com>
 <158465511927.38369.12297264423437326370@aarayaol-mobl.amr.corp.intel.com>
Message-ID: <a26c7977-4c99-cd4e-2e13-8a5a9bdab0a4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/19/2020 23:58, Andre Guedes wrote:
> Hi Vitaly,
> 
> Quoting Vitaly Lifshits (2020-03-18 06:54:46)
>> +static void igc_diag_test(struct net_device *netdev,
>> +                         struct ethtool_test *eth_test, u64 *data)
>> +{
>> +       struct igc_adapter *adapter = netdev_priv(netdev);
>> +       bool if_running = netif_running(netdev);
>> +
>> +       if (IGC_REMOVED(adapter->hw.hw_addr)) {
> 
> I'm not sure I follow how this check is expected to work. A quick grep shows
> IGC_REMOVED expands to 0 so this if-block is never executed. Could you please
> elaborate a bit on that?
Thanks Andre for catch this. IGC_REMOVED define has been introduced as a 
leftover from the previous device. i225 no support virtualization and 
this definition should be drop.
Also, we will send patch to clean IGC_REMOVE definition from igc driver.
> 
> Also, I noticed we have similar checks in functions from igc_diag.c that are
> called from igc_diag_test().
> 
>> +               dev_err(&adapter->pdev->dev,
>> +                       "Adapter removed - test blocked\n");
>> +               data[0] = 1;
>> +               data[1] = 1;
>> +               data[2] = 1;
>> +               data[3] = 1;
>> +               data[4] = 1;
>> +               eth_test->flags |= ETH_TEST_FL_FAILED;
>> +               return;
>> +       }
>> +       set_bit(__IGC_TESTING, &adapter->state);
>> +       if (eth_test->flags == ETH_TEST_FL_OFFLINE) {
>> +               /* Offline tests */
> 
> This comment is not really helpful and should be removed.
> 
>> +               dev_info(&adapter->pdev->dev,
>> +                        "offline testing starting\n");
> 
> Unnecessary line break here. I could spot the same issue in other places in
> this patch, BTW.
> 
>> +
>> +               /* Link test performed before hardware reset so autoneg doesn't
>> +                * interfere with test result
>> +                */
>> +               if (igc_link_test(adapter, &data[4]))
>> +                       eth_test->flags |= ETH_TEST_FL_FAILED;
>> +
>> +               if (if_running)
>> +                       /* indicate we're in test mode */
>> +                       igc_close(netdev);
> 
> This comment seems to be unrelated to the code below it.
> 
>> +               else
>> +                       igc_reset(adapter);
>> +
>> +               dev_info(&adapter->pdev->dev,
>> +                        "register testing starting\n");
>> +               if (igc_reg_test(adapter, &data[0]))
>> +                       eth_test->flags |= ETH_TEST_FL_FAILED;
>> +
>> +               igc_reset(adapter);
>> +
>> +               dev_info(&adapter->pdev->dev,
>> +                        "eeprom testing starting\n");
>> +               if (igc_eeprom_test(adapter, &data[1]))
>> +                       eth_test->flags |= ETH_TEST_FL_FAILED;
>> +
>> +               igc_reset(adapter);
>> +
>> +               dev_info(&adapter->pdev->dev,
>> +                        "interrupt testing starting\n");
>> +               if (igc_eeprom_test(adapter, &data[2]))
> 
> I think we want to call igc_intr_test() here instead.
> 
>> +                       eth_test->flags |= ETH_TEST_FL_FAILED;
>> +
>> +               igc_reset(adapter);
>> +
>> +               /* loopback test will be implemented in the future */
>> +               data[3] = 0;
>> +
>> +               clear_bit(__IGC_TESTING, &adapter->state);
>> +               if (if_running)
>> +                       igc_open(netdev);
>> +       } else {
>> +               dev_info(&adapter->pdev->dev,
>> +                        "online testing starting\n");
>> +
>> +               /* register, eeprom, intr and loopback tests not run online */
>> +               data[0] = 0;
>> +               data[1] = 0;
>> +               data[2] = 0;
>> +               data[3] = 0;
> 
> Instead of using hard coded numbers to index 'data', please use meaningful
> macros. See IGB driver as example.
> 
>> +
>> +               if (igc_link_test(adapter, &data[4]))
>> +                       eth_test->flags |= ETH_TEST_FL_FAILED;
> 
> I think we're missing clearing the __IGC_TESTING bit in this 'else' block. BTW,
> could we clear it after the if-else block instead?
> 
>> +       }
>> +
>> +       msleep_interruptible(4 * 1000);
>> +}
> 
> Regards,
> 
> Andre
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 

