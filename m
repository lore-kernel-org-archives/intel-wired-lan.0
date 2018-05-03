From: Tobin C. Harding <tobin@apporbit.com>
Date: Thu, 3 May 2018 15:54:07 +1000
Subject: [Intel-wired-lan] [PATCH 2/2] drivers core: multi-threading
 device shutdown
In-Reply-To: <20180503035931.22439-3-pasha.tatashin@oracle.com>
References: <20180503035931.22439-1-pasha.tatashin@oracle.com>
 <20180503035931.22439-3-pasha.tatashin@oracle.com>
Message-ID: <20180503055407.GN3791@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This code was a pleasure to read, super clean.

On Wed, May 02, 2018 at 11:59:31PM -0400, Pavel Tatashin wrote:
> When system is rebooted, halted or kexeced device_shutdown() is
> called.
> 
> This function shuts down every single device by calling either:
> 	dev->bus->shutdown(dev)
> 	dev->driver->shutdown(dev)
> 
> Even on a machine just with a moderate amount of devices, device_shutdown()
> may take multiple seconds to complete. Because many devices require a
> specific delays to perform this operation.
> 
> Here is sample analysis of time it takes to call device_shutdown() on
> two socket Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz machine.
> 
> device_shutdown		2.95s
>  mlx4_shutdown		1.14s
>  megasas_shutdown	0.24s
>  ixgbe_shutdown		0.37s x 4 (four ixgbe devices on my machine).
>  the rest		0.09s
> 
> In mlx4 we spent the most time, but that is because there is a 1 second
> sleep:
> mlx4_shutdown
>  mlx4_unload_one
>   mlx4_free_ownership
>    msleep(1000)
> 
> With megasas we spend quoter of second, but sometimes longer (up-to 0.5s)
> in this path:
> 
>     megasas_shutdown
>       megasas_flush_cache
>         megasas_issue_blocked_cmd
>           wait_event_timeout
> 
> Finally, with ixgbe_shutdown() it takes 0.37 for each device, but that time
> is spread all over the place, with bigger offenders:
> 
>     ixgbe_shutdown
>       __ixgbe_shutdown
>         ixgbe_close_suspend
>           ixgbe_down
>             ixgbe_init_hw_generic
>               ixgbe_reset_hw_X540
>                 msleep(100);                        0.104483472
>                 ixgbe_get_san_mac_addr_generic      0.048414851
>                 ixgbe_get_wwn_prefix_generic        0.048409893
>               ixgbe_start_hw_X540
>                 ixgbe_start_hw_generic
>                   ixgbe_clear_hw_cntrs_generic      0.048581502
>                   ixgbe_setup_fc_generic            0.024225800
> 
>     All the ixgbe_*generic functions end-up calling:
>     ixgbe_read_eerd_X540()
>       ixgbe_acquire_swfw_sync_X540
>         usleep_range(5000, 6000);
>       ixgbe_release_swfw_sync_X540
>         usleep_range(5000, 6000);
> 
> While these are short sleeps, they end-up calling them over 24 times!
> 24 * 0.0055s = 0.132s. Adding-up to 0.528s for four devices.
> 
> While we should keep optimizing the individual device drivers, in some
> cases this is simply a hardware property that forces a specific delay, and
> we must wait.
> 
> So, the solution for this problem is to shutdown devices in parallel.
> However, we must shutdown children before shutting down parents, so parent
> device must wait for its children to finish.
> 
> With this patch, on the same machine devices_shutdown() takes 1.142s, and
> without mlx4 one second delay only 0.38s
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  drivers/base/core.c | 238 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 189 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b610816eb887..f370369a303b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -25,6 +25,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sysfs.h>
> +#include <linux/kthread.h>
>  
>  #include "base.h"
>  #include "power/power.h"
> @@ -2102,6 +2103,59 @@ const char *device_get_devnode(struct device *dev,
>  	return *tmp = s;
>  }
>  
> +/**
> + * device_children_count - device children count
> + * @parent: parent struct device.
> + *
> + * Returns number of children for this device or 0 if nonde.
> + */
> +static int device_children_count(struct device *parent)
> +{
> +	struct klist_iter i;
> +	int children = 0;
> +
> +	if (!parent->p)
> +		return 0;
> +
> +	klist_iter_init(&parent->p->klist_children, &i);
> +	while (next_device(&i))
> +		children++;
> +	klist_iter_exit(&i);
> +
> +	return children;
> +}
> +
> +/**
> + * device_get_child_by_index - Return child using the provide index.
> + * @parent: parent struct device.
> + * @index:  Index of the child, where 0 is the first child in the children list,
> + * and so on.
> + *
> + * Returns child or NULL if child with this index is not present.
> + */
> +static struct device *
> +device_get_child_by_index(struct device *parent, int index)
> +{
> +	struct klist_iter i;
> +	struct device *dev = NULL, *d;
> +	int child_index = 0;
> +
> +	if (!parent->p || index < 0)
> +		return NULL;
> +
> +	klist_iter_init(&parent->p->klist_children, &i);
> +	while ((d = next_device(&i)) != NULL) {

perhaps:
	while ((d = next_device(&i))) {

> +		if (child_index == index) {
> +			dev = d;
> +			break;
> +		}
> +		child_index++;
> +	}
> +	klist_iter_exit(&i);
> +
> +	return dev;
> +}
> +
>  /**
>   * device_for_each_child - device child iterator.
>   * @parent: parent struct device.
> @@ -2765,71 +2819,157 @@ int device_move(struct device *dev, struct device *new_parent,
>  }
>  EXPORT_SYMBOL_GPL(device_move);
>  
> +/*
> + * device_shutdown_one - call ->shutdown() for the device passed as
> + * argument.
> + */
> +static void device_shutdown_one(struct device *dev)
> +{
> +	/* Don't allow any more runtime suspends */
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_barrier(dev);
> +
> +	if (dev->class && dev->class->shutdown_pre) {
> +		if (initcall_debug)
> +			dev_info(dev, "shutdown_pre\n");
> +		dev->class->shutdown_pre(dev);
> +	}
> +	if (dev->bus && dev->bus->shutdown) {
> +		if (initcall_debug)
> +			dev_info(dev, "shutdown\n");
> +		dev->bus->shutdown(dev);
> +	} else if (dev->driver && dev->driver->shutdown) {
> +		if (initcall_debug)
> +			dev_info(dev, "shutdown\n");
> +		dev->driver->shutdown(dev);
> +	}
> +
> +	/* Release device lock, and decrement the reference counter */
> +	device_unlock(dev);
> +	put_device(dev);
> +}
> +
> +static DECLARE_COMPLETION(device_root_tasks_complete);
> +static void device_shutdown_tree(struct device *dev);
> +static atomic_t device_root_tasks;
> +
> +/*
> + * Passed as an argument to to device_shutdown_task().
> + * child_next_index	the next available child index.
> + * tasks_running	number of tasks still running. Each tasks decrements it
> + *			when job is finished and the last tasks signals that the
> + *			job is complete.
> + * complete		Used to signal job competition.
> + * parent		Parent device.
> + */
> +struct device_shutdown_task_data {
> +	atomic_t		child_next_index;
> +	atomic_t		tasks_running;
> +	struct completion	complete;
> +	struct device		*parent;
> +};
> +
> +static int device_shutdown_task(void *data)
> +{
> +	struct device_shutdown_task_data *tdata =
> +		(struct device_shutdown_task_data *)data;

perhaps:
	struct device_shutdown_task_data *tdata = data;

> +	int child_idx = atomic_inc_return(&tdata->child_next_index) - 1;
> +	struct device *dev = device_get_child_by_index(tdata->parent,
> +						       child_idx);

perhaps:
	struct device *dev = device_get_child_by_index(tdata->parent, child_idx);

This is over the 80 character limit but only by one character :)

> +
> +	if (dev)
> +		device_shutdown_tree(dev);
> +	if (atomic_dec_return(&tdata->tasks_running) == 0)
> +		complete(&tdata->complete);
> +	return 0;
> +}
> +
> +/*
> + * Shutdown device tree with root started in dev. If dev has no children
> + * simply shutdown only this device. If dev has children recursively shutdown
> + * children first, and only then the parent. For performance reasons children
> + * are shutdown in parallel using kernel threads.
> + */
> +static void device_shutdown_tree(struct device *dev)
> +{
> +	int children_count = device_children_count(dev);
> +
> +	if (children_count) {
> +		struct device_shutdown_task_data tdata;
> +		int i;
> +
> +		init_completion(&tdata.complete);
> +		atomic_set(&tdata.child_next_index, 0);
> +		atomic_set(&tdata.tasks_running, children_count);
> +		tdata.parent = dev;
> +
> +		for (i = 0; i < children_count; i++) {
> +			kthread_run(device_shutdown_task,
> +				    &tdata, "device_shutdown.%s",
> +				    dev_name(dev));
> +		}
> +		wait_for_completion(&tdata.complete);
> +	}
> +	device_shutdown_one(dev);
> +}
> +
> +/*
> + * On shutdown each root device (the one that does not have a parent) goes
> + * through this function.
> + */
> +static int
> +device_shutdown_root_task(void *data)
> +{
> +	struct device *dev = (struct device *)data;
> +
> +	device_shutdown_tree(dev);
> +	if (atomic_dec_return(&device_root_tasks) == 0)
> +		complete(&device_root_tasks_complete);
> +	return 0;
> +}
> +
>  /**
>   * device_shutdown - call ->shutdown() on each device to shutdown.
>   */
>  void device_shutdown(void)
>  {
> -	struct device *dev, *parent;
> +	struct list_head *pos, *next;
> +	int root_devices = 0;
> +	struct device *dev;
>  
>  	spin_lock(&devices_kset->list_lock);
>  	/*
> -	 * Walk the devices list backward, shutting down each in turn.
> -	 * Beware that device unplug events may also start pulling
> -	 * devices offline, even as the system is shutting down.
> +	 * Prepare devices for shutdown: lock, and increment references in every
> +	 * devices. Remove child devices from the list, and count number of root

         * Prepare devices for shutdown: lock, and increment reference in each
         * device. Remove child devices from the list, and count number of root


Hope this helps,
Tobin.
