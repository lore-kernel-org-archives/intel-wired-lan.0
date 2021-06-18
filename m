From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 18 Jun 2021 21:44:30 +0000
Subject: [Intel-wired-lan] [PATCH net v3 1/3] iavf: Refactor iavf state
 machine tracking
In-Reply-To: <20210618090355.12519-1-mateusz.palczewski@intel.com>
References: <20210618090355.12519-1-mateusz.palczewski@intel.com>
Message-ID: <9567f07de3eb43920b03fe19ff3a2da6c63acb80.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-06-18 at 11:03 +0200, Mateusz Palczewski wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> Replace state changes of iavf state machine
> with a method that also tracks the previous
> state the machine was on.
> 
> This change is required for further work with
> refactoring init and watchdog state machines.
> 
> Tracking of previous state would help us
> recover iavf after failure has occured.
> 
> Fixes: bac8486116b0 ("iavf: Refactor the watchdog state machine")
> Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>

<snip>

> @@ -2095,6 +2095,7 @@ static void iavf_disable_vf(struct iavf_adapter
> *adapter)
>  	adapter->netdev->flags &= ~IFF_UP;
>  	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
>  	adapter->state = __IAVF_DOWN;

Should the above line be removed?

> +	iavf_change_state(adapter, __IAVF_DOWN);
>  	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
>  	wake_up(&adapter->down_waitqueue);
>  	dev_info(&adapter->pdev->dev, "Reset task did not complete, VF
> disabled\n");

