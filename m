From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 18 Oct 2021 18:50:45 +0000
Subject: [Intel-wired-lan] [PATCH net-next v6 1/3] iavf: Refactor iavf
 state machine tracking
In-Reply-To: <20210819084740.2449-1-mateusz.palczewski@intel.com>
References: <20210819084740.2449-1-mateusz.palczewski@intel.com>
Message-ID: <DM8PR11MB56210DDD2A6B9E76B2D60A87ABBC9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: czwartek, 19 sierpnia 2021 10:48
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>; Pawlak, Jakub
> <jakub.pawlak@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v6 1/3] iavf: Refactor iavf state
> machine tracking
> 
> Replace state changes of iavf state machine with a method that also tracks
> the previous state the machine was on.
> 
> This change is required for further work with refactoring init and watchdog
> state machines.
> 
> Tracking of previous state would help us recover iavf after failure has
> occured.
> 
> Fixes: bac8486116b0 ("iavf: Refactor the watchdog state machine")
> Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
> v6: Fixed that patch so that it applies on next-queue tree
> v5: Fixed the patch so that it applies on net-next tree
> v4: Removed unnecessary line
> v3: Added new file to patch series
> v2: Splitted the patch into 2 to make them smaller
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        | 10 +++++
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 37 ++++++++++---------
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  2 +-
>  3 files changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 21c9577..4f937cc 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -314,6 +314,7 @@ struct iavf_adapter {
>  	struct iavf_hw hw; /* defined in iavf_type.h */
> 
>  	enum iavf_state_t state;
> +	enum iavf_state_t last_state;
>  	unsigned long crit_section;
> 
>  	struct delayed_work watchdog_task;
> @@ -395,6 +396,15 @@ struct iavf_device {  extern char iavf_driver_name[];
> extern struct workqueue_struct *iavf_wq;
> 
> +static inline void iavf_change_state(struct iavf_adapter *adapter,
> +				     enum iavf_state_t state)
> +{
> +	if (adapter->state != state) {
> +		adapter->last_state = adapter->state;
> +		adapter->state = state;
> +	}
> +}
> +
>  int iavf_up(struct iavf_adapter *adapter);  void iavf_down(struct
> iavf_adapter *adapter);  int iavf_process_config(struct iavf_adapter
> *adapter); diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 80437ef..740e68b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -982,7 +982,7 @@ static void iavf_configure(struct iavf_adapter
> *adapter)
>   **/
>  static void iavf_up_complete(struct iavf_adapter *adapter)  {
> -	adapter->state = __IAVF_RUNNING;
> +	iavf_change_state(adapter, __IAVF_RUNNING);
>  	clear_bit(__IAVF_VSI_DOWN, adapter->vsi.state);
> 
>  	iavf_napi_enable_all(adapter);
> @@ -1750,7 +1750,7 @@ static int iavf_startup(struct iavf_adapter *adapter)
>  		iavf_shutdown_adminq(hw);
>  		goto err;
>  	}
> -	adapter->state = __IAVF_INIT_VERSION_CHECK;
> +	iavf_change_state(adapter, __IAVF_INIT_VERSION_CHECK);
>  err:
>  	return err;
>  }
> @@ -1774,7 +1774,7 @@ static int iavf_init_version_check(struct
> iavf_adapter *adapter)
>  	if (!iavf_asq_done(hw)) {
>  		dev_err(&pdev->dev, "Admin queue command never
> completed\n");
>  		iavf_shutdown_adminq(hw);
> -		adapter->state = __IAVF_STARTUP;
> +		iavf_change_state(adapter, __IAVF_STARTUP);
>  		goto err;
>  	}
> 
> @@ -1797,8 +1797,7 @@ static int iavf_init_version_check(struct
> iavf_adapter *adapter)
>  			err);
>  		goto err;
>  	}
> -	adapter->state = __IAVF_INIT_GET_RESOURCES;
> -
> +	iavf_change_state(adapter, __IAVF_INIT_GET_RESOURCES);
>  err:
>  	return err;
>  }
> @@ -1914,7 +1913,7 @@ static int iavf_init_get_resources(struct
> iavf_adapter *adapter)
>  	if (netdev->features & NETIF_F_GRO)
>  		dev_info(&pdev->dev, "GRO is enabled\n");
> 
> -	adapter->state = __IAVF_DOWN;
> +	iavf_change_state(adapter, __IAVF_DOWN);
>  	set_bit(__IAVF_VSI_DOWN, adapter->vsi.state);
>  	rtnl_unlock();
> 
> @@ -1962,7 +1961,7 @@ static void iavf_watchdog_task(struct work_struct
> *work)
>  		goto restart_watchdog;
> 
>  	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
> -		adapter->state = __IAVF_COMM_FAILED;
> +		iavf_change_state(adapter, __IAVF_COMM_FAILED);
> 
>  	switch (adapter->state) {
>  	case __IAVF_COMM_FAILED:
> @@ -1973,7 +1972,7 @@ static void iavf_watchdog_task(struct work_struct
> *work)
>  			/* A chance for redemption! */
>  			dev_err(&adapter->pdev->dev,
>  				"Hardware came out of reset. Attempting
> reinit.\n");
> -			adapter->state = __IAVF_STARTUP;
> +			iavf_change_state(adapter, __IAVF_STARTUP);
>  			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
>  			queue_delayed_work(iavf_wq, &adapter->init_task,
> 10);
>  			mutex_unlock(&adapter->crit_lock);
> @@ -2021,9 +2020,10 @@ static void iavf_watchdog_task(struct work_struct
> *work)
>  		goto restart_watchdog;
>  	}
> 
> -		/* check for hw reset */
> +	/* check for hw reset */
>  	reg_val = rd32(hw, IAVF_VF_ARQLEN1) &
> IAVF_VF_ARQLEN1_ARQENABLE_MASK;
>  	if (!reg_val) {
> +		iavf_change_state(adapter, __IAVF_RESETTING);
>  		adapter->flags |= IAVF_FLAG_RESET_PENDING;
>  		adapter->aq_required = 0;
>  		adapter->current_op = VIRTCHNL_OP_UNKNOWN; @@ -
> 2103,7 +2103,7 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
>  	adapter->netdev->flags &= ~IFF_UP;
>  	mutex_unlock(&adapter->crit_lock);
>  	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
> -	adapter->state = __IAVF_DOWN;
> +	iavf_change_state(adapter, __IAVF_DOWN);
>  	wake_up(&adapter->down_waitqueue);
>  	dev_info(&adapter->pdev->dev, "Reset task did not complete, VF
> disabled\n");  } @@ -2214,7 +2214,7 @@ static void iavf_reset_task(struct
> work_struct *work)
>  	}
>  	iavf_irq_disable(adapter);
> 
> -	adapter->state = __IAVF_RESETTING;
> +	iavf_change_state(adapter, __IAVF_RESETTING);
>  	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
> 
>  	/* free the Tx/Rx rings and descriptors, might be better to just @@ -
> 2314,11 +2314,14 @@ static void iavf_reset_task(struct work_struct *work)
> 
>  		iavf_configure(adapter);
> 
> +		/* iavf_up_complete() will switch device back
> +		 * to __IAVF_RUNNING
> +		 */
>  		iavf_up_complete(adapter);
> 
>  		iavf_irq_enable(adapter, true);
>  	} else {
> -		adapter->state = __IAVF_DOWN;
> +		iavf_change_state(adapter, __IAVF_DOWN);
>  		wake_up(&adapter->down_waitqueue);
>  	}
>  	mutex_unlock(&adapter->client_lock);
> @@ -3325,7 +3328,7 @@ static int iavf_close(struct net_device *netdev)
>  		adapter->flags |= IAVF_FLAG_CLIENT_NEEDS_CLOSE;
> 
>  	iavf_down(adapter);
> -	adapter->state = __IAVF_DOWN_PENDING;
> +	iavf_change_state(adapter, __IAVF_DOWN_PENDING);
>  	iavf_free_traffic_irqs(adapter);
> 
>  	mutex_unlock(&adapter->crit_lock);
> @@ -3710,7 +3713,7 @@ static void iavf_init_task(struct work_struct *work)
>  			"Failed to communicate with PF; waiting before
> retry\n");
>  		adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
>  		iavf_shutdown_adminq(hw);
> -		adapter->state = __IAVF_STARTUP;
> +		iavf_change_state(adapter, __IAVF_STARTUP);
>  		queue_delayed_work(iavf_wq, &adapter->init_task, HZ * 5);
>  		goto out;
>  	}
> @@ -3736,7 +3739,7 @@ static void iavf_shutdown(struct pci_dev *pdev)
>  	if (iavf_lock_timeout(&adapter->crit_lock, 5000))
>  		dev_warn(&adapter->pdev->dev, "failed to acquire crit_lock
> in %s\n", __FUNCTION__);
>  	/* Prevent the watchdog from running. */
> -	adapter->state = __IAVF_REMOVE;
> +	iavf_change_state(adapter, __IAVF_REMOVE);
>  	adapter->aq_required = 0;
>  	mutex_unlock(&adapter->crit_lock);
> 
> @@ -3809,7 +3812,7 @@ static int iavf_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
>  	hw->back = adapter;
> 
>  	adapter->msg_enable = BIT(DEFAULT_DEBUG_LEVEL_SHIFT) - 1;
> -	adapter->state = __IAVF_STARTUP;
> +	iavf_change_state(adapter, __IAVF_STARTUP);
> 
>  	/* Call save state here because it relies on the adapter struct. */
>  	pci_save_state(pdev);
> @@ -3986,7 +3989,7 @@ static void iavf_remove(struct pci_dev *pdev)
> 
>  	dev_info(&adapter->pdev->dev, "Removing device\n");
>  	/* Shut down all the garbage mashers on the detention level */
> -	adapter->state = __IAVF_REMOVE;
> +	iavf_change_state(adapter, __IAVF_REMOVE);
>  	adapter->aq_required = 0;
>  	adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
>  	iavf_free_all_tx_resources(adapter);
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index 9c12846..e01b112 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -1743,7 +1743,7 @@ void iavf_virtchnl_completion(struct iavf_adapter
> *adapter,
>  		iavf_free_all_tx_resources(adapter);
>  		iavf_free_all_rx_resources(adapter);
>  		if (adapter->state == __IAVF_DOWN_PENDING) {
> -			adapter->state = __IAVF_DOWN;
> +			iavf_change_state(adapter, __IAVF_DOWN);
>  			wake_up(&adapter->down_waitqueue);
>  		}
>  		break;
> --
> 2.17.1
> 
Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
