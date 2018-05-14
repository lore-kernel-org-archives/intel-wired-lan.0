From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 23:04:02 +0300
Subject: [Intel-wired-lan] [PATCH v4 1/1] drivers core: multi-threading
 device shutdown
In-Reply-To: <20180514194254.14748-2-pasha.tatashin@oracle.com>
References: <20180514194254.14748-1-pasha.tatashin@oracle.com>
 <20180514194254.14748-2-pasha.tatashin@oracle.com>
Message-ID: <CAHp75VeopFMFHq=rJCUcAw02kznJ5+0vLWr5500DsGtERiX6cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, May 14, 2018 at 10:42 PM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:

>  #include <linux/netdevice.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sysfs.h>
> +#include <linux/kthread.h>

Can we still preserve an order here? (Yes, even if the entire list is
not fully ordered)
In the context I see it would go before netdevice.h.

> +/**
> + * device_get_child_by_index - Return child using the provided index.
> + * @parent: parent struct device.
> + * @index:  Index of the child, where 0 is the first child in the children list,
> + * and so on.
> + *
> + * Returns child or NULL if child with this index is not present.
> + */
> +static struct device *
> +device_get_child_by_index(struct device *parent, int index)
> +{
> +       struct klist_iter i;
> +       struct device *dev = NULL, *d;
> +       int child_index = 0;
> +
> +       if (!parent->p || index < 0)
> +               return NULL;
> +
> +       klist_iter_init(&parent->p->klist_children, &i);
> +       while ((d = next_device(&i))) {
> +               if (child_index == index) {
> +                       dev = d;
> +                       break;
> +               }
> +               child_index++;
> +       }
> +       klist_iter_exit(&i);
> +
> +       return dev;
> +}

This can be implemented as a subfunction to device_find_child(), can't it be?

> +/**

Hmm... Why it's marked as kernel doc while it's just a plain comment?
Same applies to the rest of similar comments.

> + * Shutdown device tree with root started in dev. If dev has no children
> + * simply shutdown only this device. If dev has children recursively shutdown
> + * children first, and only then the parent. For performance reasons children
> + * are shutdown in parallel using kernel threads. because we lock dev its
> + * children cannot be removed while this functions is running.
> + */

> +static void device_shutdown_tree(struct device *dev)
> +{
> +       int children_count;
> +
> +       device_lock(dev);
> +       children_count = device_children_count(dev);
> +
> +       if (children_count) {
> +               struct device_shutdown_task_data tdata;
> +               int i;
> +
> +               init_completion(&tdata.complete);
> +               atomic_set(&tdata.child_next_index, 0);
> +               atomic_set(&tdata.tasks_running, children_count);
> +               tdata.parent = dev;
> +

> +               for (i = 0; i < children_count; i++) {
> +                       if (device_shutdown_serial) {
> +                               device_shutdown_child_task(&tdata);
> +                       } else {
> +                               kthread_run(device_shutdown_child_task,
> +                                           &tdata, "device_shutdown.%s",
> +                                           dev_name(dev));
> +                       }
> +               }

Can't we just use device_for_each_child() instead?

> +               wait_for_completion(&tdata.complete);
> +       }
> +       device_shutdown_one(dev);
> +       device_unlock(dev);
> +}

-- 
With Best Regards,
Andy Shevchenko
