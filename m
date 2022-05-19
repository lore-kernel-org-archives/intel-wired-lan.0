From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 19 May 2022 10:28:52 +0200
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix call trace in
 setup_tx_descriptors
In-Reply-To: <20220519080246.1906390-1-aleksandr.loktionov@intel.com>
References: <20220519080246.1906390-1-aleksandr.loktionov@intel.com>
Message-ID: <a814caad-5e32-90fb-547d-4e211d60d848@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Aleksandr,


Am 19.05.22 um 10:02 schrieb Loktionov, Aleksandr:
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> After pf reset and ethtool -t there was call trace is dmesg
> sometimes providing to panic. When there was some time, around 5

?sometimes providing to panic? sounds strange. Can you please clarify, 
and rephrase for v2?

> seconds, between reset and test there was no errors.
> 
> Problem was that pf reset calls i40e_vsi_close in prep_for_reset
> and ethtool -t calls i40e_vsi_close in diag_test. If there was not
> enough time between those commands the second i40e_vsi_close starts
> before previous i40e_vsi_close was done which leads to crash.
> 
> Add check to diag_test if pf is in reset and don't start offline
> tests if it is true.

Maybe also mention the new log message:

     netif_info(pf, drv, netdev, "testing failed\n");

> Fixes: e17bc411aea8 ("i40e: Disable offline diagnostics if VFs are enabled")
> Signed-off-by: Michal Jaron <michalx.jaron@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   .../net/ethernet/intel/i40e/i40e_ethtool.c    | 25 +++++++++++++------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index e484996..06c05a6 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -2584,15 +2584,16 @@ static void i40e_diag_test(struct net_device *netdev,
>   
>   		set_bit(__I40E_TESTING, pf->state);
>   
> +		if (test_bit(__I40E_RESET_RECOVERY_PENDING, pf->state) ||
> +		    test_bit(__I40E_RESET_INTR_RECEIVED, pf->state)) {
> +			dev_warn(&pf->pdev->dev,
> +				 "Cannot start offline testing when PF is in reset state.\n");
> +			goto skip_ol_tests;
> +		}
> +
>   		if (i40e_active_vfs(pf) || i40e_active_vmdqs(pf)) {
>   			dev_warn(&pf->pdev->dev,
>   				 "Please take active VFs and Netqueues offline and restart the adapter before running NIC diagnostics\n");
> -			data[I40E_ETH_TEST_REG]		= 1;
> -			data[I40E_ETH_TEST_EEPROM]	= 1;
> -			data[I40E_ETH_TEST_INTR]	= 1;
> -			data[I40E_ETH_TEST_LINK]	= 1;
> -			eth_test->flags |= ETH_TEST_FL_FAILED;
> -			clear_bit(__I40E_TESTING, pf->state);
>   			goto skip_ol_tests;
>   		}
>   
> @@ -2639,9 +2640,17 @@ static void i40e_diag_test(struct net_device *netdev,
>   		data[I40E_ETH_TEST_INTR] = 0;
>   	}
>   
> -skip_ol_tests:
> -
>   	netif_info(pf, drv, netdev, "testing finished\n");
> +	return;
> +
> +skip_ol_tests:
> +	data[I40E_ETH_TEST_REG]		= 1;
> +	data[I40E_ETH_TEST_EEPROM]	= 1;
> +	data[I40E_ETH_TEST_INTR]	= 1;
> +	data[I40E_ETH_TEST_LINK]	= 1;
> +	eth_test->flags |= ETH_TEST_FL_FAILED;
> +	clear_bit(__I40E_TESTING, pf->state);
> +	netif_info(pf, drv, netdev, "testing failed\n");
>   }
>   
>   static void i40e_get_wol(struct net_device *netdev,


Kind regards,

Paul
