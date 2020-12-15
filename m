From: Shen, Yijun <Yijun.Shen@dell.com>
Date: Tue, 15 Dec 2020 14:46:59 +0000
Subject: [Intel-wired-lan] [PATCH v5 1/4] e1000e: Only run S0ix flows if
 shutdown succeeded
In-Reply-To: <20201214192935.895174-2-mario.limonciello@dell.com>
References: <20201214192935.895174-1-mario.limonciello@dell.com>
 <20201214192935.895174-2-mario.limonciello@dell.com>
Message-ID: <SJ0PR19MB4463871A880C165310ED8ABA9AC60@SJ0PR19MB4463.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Sent: Tuesday, December 15, 2020 3:30 AM
> To: Jeff Kirsher; Tony Nguyen; intel-wired-lan at lists.osuosl.org
> Cc: linux-kernel at vger.kernel.org; Netdev; Alexander Duyck; Jakub Kicinski;
> Sasha Netfin; Aaron Brown; Stefan Assmann; David Miller;
> darcari at redhat.com; Shen, Yijun; Yuan, Perry;
> anthony.wong at canonical.com; Hans de Goede; Limonciello, Mario
> Subject: [PATCH v5 1/4] e1000e: Only run S0ix flows if shutdown succeeded
> 
> If the shutdown failed, the part will be thawed and running S0ix flows will
> put it into an undefined state.
> 
> Reported-by: Alexander Duyck <alexander.duyck@gmail.com>
> Reviewed-by: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

Verified this series patch on Dell Systems.

Tested-By: Yijun Shen <Yijun.shen@dell.com>

> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 128ab6898070..6588f5d4a2be 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -6970,13 +6970,14 @@ static __maybe_unused int
> e1000e_pm_suspend(struct device *dev)
>  	e1000e_pm_freeze(dev);
> 
>  	rc = __e1000_shutdown(pdev, false);
> -	if (rc)
> +	if (rc) {
>  		e1000e_pm_thaw(dev);
> -
> -	/* Introduce S0ix implementation */
> -	if (hw->mac.type >= e1000_pch_cnp &&
> -	    !e1000e_check_me(hw->adapter->pdev->device))
> -		e1000e_s0ix_entry_flow(adapter);
> +	} else {
> +		/* Introduce S0ix implementation */
> +		if (hw->mac.type >= e1000_pch_cnp &&
> +		    !e1000e_check_me(hw->adapter->pdev->device))
> +			e1000e_s0ix_entry_flow(adapter);
> +	}
> 
>  	return rc;
>  }
> --
> 2.25.1

