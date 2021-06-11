From: Stefan Assmann <sassmann@redhat.com>
Date: Fri, 11 Jun 2021 14:58:40 +0200
Subject: [Intel-wired-lan] [PATCH net v2 2/2] iavf: Fix init and
 watchdog state machines
In-Reply-To: <20210611095946.5219-1-mateusz.palczewski@intel.com>
References: <20210611095946.5219-1-mateusz.palczewski@intel.com>
Message-ID: <20210611125840.hbxc6h6u5urjhzog@p50>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2021-06-11 11:59, Mateusz Palczewski wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> Use single state machine for driver initialization
> and for service initialized driver. The init state
> machine implemented in init_task() is merged
> into the watchdog_task(). The init_task() function
> is removed.

This still lacks lots of explanations for all the changes being made.
Why is the init_task functionality merged into the watchdog?

> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
> index e13d2d1..5967db9 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -176,6 +176,7 @@ enum iavf_state_t {
>  	__IAVF_INIT_VERSION_CHECK,	/* aq msg sent, awaiting reply */
>  	__IAVF_INIT_GET_RESOURCES,	/* aq msg sent, awaiting reply */
>  	__IAVF_INIT_SW,		/* got resources, setting up structs */
> +	__IAVF_INIT_FAILED,	/* init failed, restarting procedure */

New flag, why do we need this?

>  	__IAVF_RESETTING,		/* in reset */
>  	__IAVF_COMM_FAILED,		/* communication with PF failed */
>  	/* Below here, watchdog is running */
> @@ -231,7 +232,6 @@ struct iavf_adapter {
>  	struct work_struct reset_task;
>  	struct work_struct adminq_task;
>  	struct delayed_work client_task;
> -	struct delayed_work init_task;
>  	wait_queue_head_t down_waitqueue;
>  	struct iavf_q_vector *q_vectors;
>  	struct list_head vlan_filter_list;
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 7c264e4..58536e1 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -14,7 +14,7 @@
>  static int iavf_setup_all_tx_resources(struct iavf_adapter *adapter);
>  static int iavf_setup_all_rx_resources(struct iavf_adapter *adapter);
>  static int iavf_close(struct net_device *netdev);
> -static int iavf_init_get_resources(struct iavf_adapter *adapter);
> +static void iavf_init_get_resources(struct iavf_adapter *adapter);

Changing return type, why?

> @@ -1931,7 +1933,49 @@ static void iavf_watchdog_task(struct work_struct *work)
>  	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
>  		iavf_change_state(adapter, __IAVF_COMM_FAILED);
>  
> +	if (adapter->flags & IAVF_FLAG_RESET_NEEDED &&
> +	    adapter->state != __IAVF_RESETTING) {
> +		iavf_change_state(adapter, __IAVF_RESETTING);
> +		adapter->aq_required = 0;
> +		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
> +	}

Lacks explanation.

>  	switch (adapter->state) {
> +	case __IAVF_STARTUP:
> +		iavf_startup(adapter);
> +		clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
> +		queue_delayed_work(iavf_wq, &adapter->watchdog_task,
> +				   msecs_to_jiffies(30));

Why 30ms?

> +		return;
> +	case __IAVF_INIT_VERSION_CHECK:
> +		iavf_init_version_check(adapter);
> +		clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
> +		queue_delayed_work(iavf_wq, &adapter->watchdog_task,
> +				   msecs_to_jiffies(30));
> +		return;
> +	case __IAVF_INIT_GET_RESOURCES:
> +		iavf_init_get_resources(adapter);
> +		clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
> +		queue_delayed_work(iavf_wq, &adapter->watchdog_task,
> +				   msecs_to_jiffies(1));

Why 1ms?

> +		return;
> +	case __IAVF_INIT_FAILED:
> +		if (++adapter->aq_wait_count > IAVF_AQ_MAX_ERR) {
> +			dev_err(&adapter->pdev->dev,
> +				"Failed to communicate with PF; waiting before retry\n");
> +			adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
> +			iavf_shutdown_adminq(hw);
> +			clear_bit(__IAVF_IN_CRITICAL_TASK,
> +				  &adapter->crit_section);
> +			queue_delayed_work(iavf_wq,
> +					   &adapter->watchdog_task, (5 * HZ));

Why all the different delays, I see HZ, 2 * HZ, 5 * HZ?

> +			return;
> +		}
> +		/* Try again from failed step*/
> +		iavf_change_state(adapter, adapter->last_state);
> +		clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
> +		queue_delayed_work(iavf_wq, &adapter->watchdog_task, HZ);
> +		return;
>  	case __IAVF_COMM_FAILED:
>  		reg_val = rd32(hw, IAVF_VFGEN_RSTAT) &
>  			  IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
> @@ -1940,17 +1984,12 @@ static void iavf_watchdog_task(struct work_struct *work)
>  			/* A chance for redemption! */
>  			dev_err(&adapter->pdev->dev,
>  				"Hardware came out of reset. Attempting reinit.\n");
> -			iavf_change_state(adapter, __IAVF_STARTUP);
> -			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
> -			queue_delayed_work(iavf_wq, &adapter->init_task, 10);
> -			clear_bit(__IAVF_IN_CRITICAL_TASK,
> -				  &adapter->crit_section);
> -			/* Don't reschedule the watchdog, since we've restarted
> -			 * the init task. When init_task contacts the PF and
> +			/* When init task contacts the PF and

Wait, didn't you just remove the init task functionality?

>  			 * gets everything set up again, it'll restart the
>  			 * watchdog for us. Down, boy. Sit. Stay. Woof.
>  			 */
> -			return;
> +			iavf_change_state(adapter, __IAVF_STARTUP);
> +			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
>  		}
>  		adapter->aq_required = 0;
>  		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
> @@ -1959,7 +1998,7 @@ static void iavf_watchdog_task(struct work_struct *work)
>  		queue_delayed_work(iavf_wq,
>  				   &adapter->watchdog_task,
>  				   msecs_to_jiffies(10));
> -		goto watchdog_done;
> +		return;
>  	case __IAVF_RESETTING:
>  		clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
>  		queue_delayed_work(iavf_wq, &adapter->watchdog_task, HZ * 2);
> @@ -1982,12 +2021,14 @@ static void iavf_watchdog_task(struct work_struct *work)
>  			    adapter->state == __IAVF_RUNNING)
>  				iavf_request_stats(adapter);
>  		}
> +		if (adapter->state == __IAVF_RUNNING)
> +			iavf_detect_recover_hung(&adapter->vsi);

Lacks explanation.

>  		break;
>  	case __IAVF_REMOVE:
>  		clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
>  		return;
>  	default:
> -		goto restart_watchdog;
> +		return;
>  	}
>  	/* check for hw reset */
> @@ -1999,22 +2040,22 @@ static void iavf_watchdog_task(struct work_struct *work)
>  		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
>  		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
>  		queue_work(iavf_wq, &adapter->reset_task);
> -		goto watchdog_done;
> +		clear_bit(__IAVF_IN_CRITICAL_TASK,
> +			  &adapter->crit_section);
> +		queue_delayed_work(iavf_wq,
> +				   &adapter->watchdog_task, HZ * 2);
> +		return;
>  	}

Lacks explanation.

>  	schedule_delayed_work(&adapter->client_task, msecs_to_jiffies(5));
> -watchdog_done:
> -	if (adapter->state == __IAVF_RUNNING ||
> -	    adapter->state == __IAVF_COMM_FAILED)
> -		iavf_detect_recover_hung(&adapter->vsi);
>  	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
>  restart_watchdog:
> +	queue_work(iavf_wq, &adapter->adminq_task);
>  	if (adapter->aq_required)
>  		queue_delayed_work(iavf_wq, &adapter->watchdog_task,
>  				   msecs_to_jiffies(20));
>  	else
>  		queue_delayed_work(iavf_wq, &adapter->watchdog_task, HZ * 2);
> -	queue_work(iavf_wq, &adapter->adminq_task);
>  }

Lacks explanation.

>  
>  static void iavf_disable_vf(struct iavf_adapter *adapter)
> @@ -2287,6 +2328,8 @@ continue_reset:
>  
>  	return;
>  reset_err:
> +	if (running)
> +		iavf_change_state(adapter, __IAVF_RUNNING);

Lacks explanation.

>  	clear_bit(__IAVF_IN_CLIENT_TASK, &adapter->crit_section);
>  	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
>  	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
> @@ -3627,58 +3670,6 @@ int iavf_process_config(struct iavf_adapter *adapter)
>  	return 0;
>  }
>  
> -/**
> - * iavf_init_task - worker thread to perform delayed initialization
> - * @work: pointer to work_struct containing our data
> - *
> - * This task completes the work that was begun in probe. Due to the nature
> - * of VF-PF communications, we may need to wait tens of milliseconds to get
> - * responses back from the PF. Rather than busy-wait in probe and bog down the
> - * whole system, we'll do it in a task so we can sleep.
> - * This task only runs during driver init. Once we've established
> - * communications with the PF driver and set up our netdev, the watchdog
> - * takes over.
> - **/
> -static void iavf_init_task(struct work_struct *work)
> -{
> -	struct iavf_adapter *adapter = container_of(work,
> -						    struct iavf_adapter,
> -						    init_task.work);
> -	struct iavf_hw *hw = &adapter->hw;
> -
> -	switch (adapter->state) {
> -	case __IAVF_STARTUP:
> -		if (iavf_startup(adapter) < 0)
> -			goto init_failed;
> -		break;
> -	case __IAVF_INIT_VERSION_CHECK:
> -		if (iavf_init_version_check(adapter) < 0)
> -			goto init_failed;
> -		break;
> -	case __IAVF_INIT_GET_RESOURCES:
> -		if (iavf_init_get_resources(adapter) < 0)
> -			goto init_failed;
> -		return;
> -	default:
> -		goto init_failed;
> -	}
> -
> -	queue_delayed_work(iavf_wq, &adapter->init_task,
> -			   msecs_to_jiffies(30));
> -	return;
> -init_failed:
> -	if (++adapter->aq_wait_count > IAVF_AQ_MAX_ERR) {
> -		dev_err(&adapter->pdev->dev,
> -			"Failed to communicate with PF; waiting before retry\n");
> -		adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
> -		iavf_shutdown_adminq(hw);
> -		iavf_change_state(adapter, __IAVF_STARTUP);
> -		queue_delayed_work(iavf_wq, &adapter->init_task, HZ * 5);
> -		return;
> -	}
> -	queue_delayed_work(iavf_wq, &adapter->init_task, HZ);
> -}
> -
>  /**
>   * iavf_shutdown - Shutdown the device in preparation for a reboot
>   * @pdev: pci device structure
> @@ -3807,8 +3798,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	INIT_WORK(&adapter->adminq_task, iavf_adminq_task);
>  	INIT_DELAYED_WORK(&adapter->watchdog_task, iavf_watchdog_task);
>  	INIT_DELAYED_WORK(&adapter->client_task, iavf_client_task);
> -	INIT_DELAYED_WORK(&adapter->init_task, iavf_init_task);
> -	queue_delayed_work(iavf_wq, &adapter->init_task,
> +	queue_delayed_work(iavf_wq, &adapter->watchdog_task,
>  			   msecs_to_jiffies(5 * (pdev->devfn & 0x07)));

What is this magic ?

  Stefan

