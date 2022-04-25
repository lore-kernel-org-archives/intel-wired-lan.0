From: Ertman, David M <david.m.ertman@intel.com>
Date: Mon, 25 Apr 2022 15:58:55 +0000
Subject: [Intel-wired-lan] [PATCH net v4] ice: Fix race during aux
 device (un)plugging
In-Reply-To: <20220423102021.4056946-1-ivecera@redhat.com>
References: <20220423102021.4056946-1-ivecera@redhat.com>
Message-ID: <MW5PR11MB5811DF21387703272C67E9B6DDF89@MW5PR11MB5811.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Ivan Vecera <ivecera@redhat.com>
> Sent: Saturday, April 23, 2022 3:20 AM
> To: netdev at vger.kernel.org
> Cc: poros <poros@redhat.com>; mschmidt <mschmidt@redhat.com>; Leon
> Romanovsky <leonro@nvidia.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> Saleem, Shiraz <shiraz.saleem@intel.com>; Ertman, David M
> <david.m.ertman@intel.com>; moderated list:INTEL ETHERNET DRIVERS
> <intel-wired-lan@lists.osuosl.org>; open list <linux-kernel@vger.kernel.org>
> Subject: [PATCH net v4] ice: Fix race during aux device (un)plugging
> 
> Function ice_plug_aux_dev() assigns pf->adev field too early prior
> aux device initialization and on other side ice_unplug_aux_dev()
> starts aux device deinit and at the end assigns NULL to pf->adev.
> This is wrong because pf->adev should always be non-NULL only when
> aux device is fully initialized and ready. This wrong order causes
> a crash when ice_send_event_to_aux() call occurs because that function
> depends on non-NULL value of pf->adev and does not assume that
> aux device is half-initialized or half-destroyed.
> After order correction the race window is tiny but it is still there,
> as Leon mentioned and manipulation with pf->adev needs to be protected
> by mutex.
> 
> Fix (un-)plugging functions so pf->adev field is set after aux device
> init and prior aux device destroy and protect pf->adev assignment by
> new mutex. This mutex is also held during ice_send_event_to_aux()
> call to ensure that aux device is valid during that call.
> Note that device lock used ice_send_event_to_aux() needs to be kept
> to avoid race with aux drv unload.
> 
> Reproducer:
> cycle=1
> while :;do
>         echo "#### Cycle: $cycle"
> 
>         ip link set ens7f0 mtu 9000
>         ip link add bond0 type bond mode 1 miimon 100
>         ip link set bond0 up
>         ifenslave bond0 ens7f0
>         ip link set bond0 mtu 9000
>         ethtool -L ens7f0 combined 1
>         ip link del bond0
>         ip link set ens7f0 mtu 1500
>         sleep 1
> 
>         let cycle++
> done
> 
> In short when the device is added/removed to/from bond the aux device
> is unplugged/plugged. When MTU of the device is changed an event is
> sent to aux device asynchronously. This can race with (un)plugging
> operation and because pf->adev is set too early (plug) or too late
> (unplug) the function ice_send_event_to_aux() can touch uninitialized
> or destroyed fields. In the case of crash below pf->adev->dev.mutex.

--SNIP--

> Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  1 +
>  drivers/net/ethernet/intel/ice/ice_idc.c  | 25 +++++++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_main.c |  2 ++
>  3 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index 8ed3c9ab7ff7..a895e3a8e988 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -540,6 +540,7 @@ struct ice_pf {
>  	struct mutex avail_q_mutex;	/* protects access to avail_[rx|tx]qs
> */
>  	struct mutex sw_mutex;		/* lock for protecting VSI alloc
> flow */
>  	struct mutex tc_mutex;		/* lock to protect TC changes
> */
> +	struct mutex adev_mutex;	/* lock to protect aux device access
> */
>  	u32 msg_enable;
>  	struct ice_ptp ptp;
>  	struct tty_driver *ice_gnss_tty_driver;
> diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c
> b/drivers/net/ethernet/intel/ice/ice_idc.c
> index 25a436d342c2..3e3b2ed4cd5d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_idc.c
> +++ b/drivers/net/ethernet/intel/ice/ice_idc.c
> @@ -37,14 +37,17 @@ void ice_send_event_to_aux(struct ice_pf *pf, struct
> iidc_event *event)
>  	if (WARN_ON_ONCE(!in_task()))
>  		return;
> 
> +	mutex_lock(&pf->adev_mutex);
>  	if (!pf->adev)
> -		return;
> +		goto finish;
> 
>  	device_lock(&pf->adev->dev);
>  	iadrv = ice_get_auxiliary_drv(pf);
>  	if (iadrv && iadrv->event_handler)
>  		iadrv->event_handler(pf, event);
>  	device_unlock(&pf->adev->dev);
> +finish:
> +	mutex_unlock(&pf->adev_mutex);
>  }
> 
>  /**
> @@ -290,7 +293,6 @@ int ice_plug_aux_dev(struct ice_pf *pf)
>  		return -ENOMEM;
> 
>  	adev = &iadev->adev;
> -	pf->adev = adev;
>  	iadev->pf = pf;
> 
>  	adev->id = pf->aux_idx;
> @@ -300,18 +302,20 @@ int ice_plug_aux_dev(struct ice_pf *pf)
> 
>  	ret = auxiliary_device_init(adev);
>  	if (ret) {
> -		pf->adev = NULL;
>  		kfree(iadev);
>  		return ret;
>  	}
> 
>  	ret = auxiliary_device_add(adev);
>  	if (ret) {
> -		pf->adev = NULL;
>  		auxiliary_device_uninit(adev);
>  		return ret;
>  	}
> 
> +	mutex_lock(&pf->adev_mutex);
> +	pf->adev = adev;
> +	mutex_unlock(&pf->adev_mutex);
> +
>  	return 0;
>  }
> 
> @@ -320,12 +324,17 @@ int ice_plug_aux_dev(struct ice_pf *pf)
>   */
>  void ice_unplug_aux_dev(struct ice_pf *pf)
>  {
> -	if (!pf->adev)
> -		return;
> +	struct auxiliary_device *adev;
> 
> -	auxiliary_device_delete(pf->adev);
> -	auxiliary_device_uninit(pf->adev);
> +	mutex_lock(&pf->adev_mutex);
> +	adev = pf->adev;
>  	pf->adev = NULL;
> +	mutex_unlock(&pf->adev_mutex);
> +
> +	if (adev) {
> +		auxiliary_device_delete(adev);
> +		auxiliary_device_uninit(adev);
> +	}
>  }
> 
>  /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 5b1198859da7..2cbbf7abefc4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3769,6 +3769,7 @@ u16 ice_get_avail_rxq_count(struct ice_pf *pf)
>  static void ice_deinit_pf(struct ice_pf *pf)
>  {
>  	ice_service_task_stop(pf);
> +	mutex_destroy(&pf->adev_mutex);
>  	mutex_destroy(&pf->sw_mutex);
>  	mutex_destroy(&pf->tc_mutex);
>  	mutex_destroy(&pf->avail_q_mutex);
> @@ -3847,6 +3848,7 @@ static int ice_init_pf(struct ice_pf *pf)
> 
>  	mutex_init(&pf->sw_mutex);
>  	mutex_init(&pf->tc_mutex);
> +	mutex_init(&pf->adev_mutex);
> 
>  	INIT_HLIST_HEAD(&pf->aq_wait_list);
>  	spin_lock_init(&pf->aq_wait_lock);
> --
> 2.35.1

Reviewed-by: Dave Ertman <david.m.ertman@intel.com>
