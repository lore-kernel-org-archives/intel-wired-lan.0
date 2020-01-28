From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 28 Jan 2020 12:24:32 +0100
Subject: [Intel-wired-lan] [next-queue v6] virtual-bus: Implementation
 of Virtual Bus
In-Reply-To: <20200122174152.5962-1-jeffrey.t.kirsher@intel.com>
References: <20200122174152.5962-1-jeffrey.t.kirsher@intel.com>
Message-ID: <2e19c1f8-49e4-ac9a-cb2c-817f3cc0a344@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jeff, dear Dave,


Thank you. I have a few more style issues and nitpicks.


On 2020-01-22 18:41, Jeff Kirsher wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> This is the initial implementation of the Virtual Bus,
> virtbus_device and virtbus_driver.  The virtual bus is
> a software based bus intended to support registering
> virtbus_devices and virtbus_drivers and provide matching
> between them and probing of the registered drivers.
> 
> The bus will support probe/remove shutdown and
> suspend/resume callbacks.
> 
> Kconfig and Makefile alterations are included

Nit: Dot/period at the end?

Are tests available, or examples how to use it?

> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> ---
> v6: Fix the order of put_device() and device_del() in
>     virtbus_dev_unregister()
> 
>  Documentation/driver-api/virtual_bus.rst |  59 +++++
>  drivers/bus/Kconfig                      |  11 +
>  drivers/bus/Makefile                     |   1 +
>  drivers/bus/virtual_bus.c                | 267 +++++++++++++++++++++++
>  include/linux/mod_devicetable.h          |   8 +
>  include/linux/virtual_bus.h              |  57 +++++
>  scripts/mod/devicetable-offsets.c        |   3 +
>  scripts/mod/file2alias.c                 |   8 +
>  8 files changed, 414 insertions(+)
>  create mode 100644 Documentation/driver-api/virtual_bus.rst
>  create mode 100644 drivers/bus/virtual_bus.c
>  create mode 100644 include/linux/virtual_bus.h
> 
> diff --git a/Documentation/driver-api/virtual_bus.rst b/Documentation/driver-api/virtual_bus.rst
> new file mode 100644
> index 000000000000..5f35c19171d7
> --- /dev/null
> +++ b/Documentation/driver-api/virtual_bus.rst
> @@ -0,0 +1,59 @@
> +===============================
> +Virtual Bus Devices and Drivers
> +===============================
> +
> +See <linux/virtual_bus.h> for the models for virtbus_device and virtbus_driver.

Mark up ``virtbus_device`` and ``virtbus_driver``?

> +This bus is meant to be a lightweight software based bus to attach generic
> +devices and drivers to so that a chunk of data can be passed between them.
> +
> +One use case example is an rdma driver needing to connect with several
> +different types of PCI LAN devices to be able to request resources from
> +them (queue sets).  Each LAN driver that supports rdma will register a
> +virtbus_device on the virtual bus for each physical function.  The rdma
> +driver will register as a virtbus_driver on the virtual bus to be
> +matched up with multiple virtbus_devices and receive a pointer to a
> +struct containing the callbacks that the PCI LAN drivers support for
> +registering with them.

Ditto. (Also in the rest of the file.)

> +
> +Sections in this document:
> +        Virtbus devices
> +        Virtbus drivers
> +        Device Enumeration
> +        Device naming and driver binding
> +        Virtual Bus API entry points
> +
> +Virtbus devices
> +~~~~~~~~~~~~~~~
> +Virtbus_devices support the minimal device functionality.  Devices will

Virtbus devices ?

> +accept a name, and then, when added to the virtual bus, an automatically
> +generated index is concatenated onto it for the virtbus_device->name.
> +
> +Virtbus drivers
> +~~~~~~~~~~~~~~~
> +Virtbus drivers register with the virtual bus to be matched with virtbus
> +devices.  They expect to be registered with a probe and remove callback,
> +and also support shutdown, suspend, and resume callbacks.  They otherwise
> +follow the standard driver behavior of having discovery and enumeration
> +handled in the bus infrastructure.
> +
> +Virtbus drivers register themselves with the API entry point virtbus_drv_reg
> +and unregister with virtbus_drv_unreg.
> +
> +Device Enumeration
> +~~~~~~~~~~~~~~~~~~
> +Enumeration is handled automatically by the bus infrastructure via the
> +ida_simple methods.
> +
> +Device naming and driver binding
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +The virtbus_device.dev.name is the canonical name for the device. It is
> +built from two other parts:
> +
> +        - virtbus_device.name (also used for matching).
> +        - virtbus_device.id (generated automatically from ida_simple calls)
> +
> +Virtbus device IDs are always in "<name>.<instance>" format.  Instances are

``<name>.<instance>``

> +automatically selected through an ida_simple_get so are positive integers.
> +Names are taken from the device name field.  Driver IDs are simple <name>.
> +Need to extract the name from the Virtual Device compare to name of the
> +driver.

The last sentence sounds incomplete to me.

> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 50200d1c06ea..43e9f108d690 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -203,4 +203,15 @@ config DA8XX_MSTPRI
>  
>  source "drivers/bus/fsl-mc/Kconfig"
>  
> +config VIRTUAL_BUS
> +       tristate "Software based Virtual Bus"
> +       help
> +         Provides a software bus for virtbus_devices to be added to it
> +         and virtbus_drivers to be registered on it.  Will create a match
> +         between the driver and device, then call the driver's probe with
> +         the virtbus_device's struct.
> +         One example is the irdma driver needing to connect with various

Above only rdma was written.

> +         PCI LAN drivers to request resources (queues) to be able to perform
> +         its function.
> +
>  endmenu
> diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
> index 1320bcf9fa9d..6721c77dc71b 100644
> --- a/drivers/bus/Makefile
> +++ b/drivers/bus/Makefile
> @@ -34,3 +34,4 @@ obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
>  obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
>  
>  obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
> +obj-$(CONFIG_VIRTUAL_BUS)	+= virtual_bus.o
> diff --git a/drivers/bus/virtual_bus.c b/drivers/bus/virtual_bus.c
> new file mode 100644
> index 000000000000..85d2dbfa3376
> --- /dev/null
> +++ b/drivers/bus/virtual_bus.c
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * virtual_bus.c - lightweight software based bus for virtual devices
> + *
> + * Copyright (c) 2019-20 Intel Corporation
> + *
> + * Please see Documentation/driver-api/virtual_bus.rst for
> + * more information

At least *more* fits on the line above. Below it?s on one line.

> + */
> +
> +#include <linux/string.h>
> +#include <linux/virtual_bus.h>
> +#include <linux/of_irq.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm_domain.h>
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Lightweight Virtual Bus");
> +MODULE_AUTHOR("David Ertman <david.m.ertman@intel.com>");
> +MODULE_AUTHOR("Kiran Patil <kiran.patil@intel.com>");
> +
> +static DEFINE_IDA(virtbus_dev_ida);
> +
> +static const
> +struct virtbus_dev_id *virtbus_match_id(const struct virtbus_dev_id *id,
> +					struct virtbus_device *vdev)
> +{
> +	while (id->name[0]) {
> +		if (!strcmp(vdev->name, id->name)) {

Use strncmp with `VIRTBUS_NAME_SIZE`?

> +			vdev->matched_element = id;
> +			return id;
> +		}
> +		id++;
> +	}
> +	return NULL;
> +}
> +
> +static int virtbus_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct virtbus_driver *vdrv = to_virtbus_drv(drv);
> +	struct virtbus_device *vdev = to_virtbus_dev(dev);
> +
> +	return virtbus_match_id(vdrv->id_table, vdev) != NULL;
> +}
> +
> +static int virtbus_probe(struct device *dev)
> +{
> +	return dev->driver->probe(dev);
> +}
> +
> +static int virtbus_remove(struct device *dev)
> +{
> +	return dev->driver->remove(dev);
> +}
> +
> +static void virtbus_shutdown(struct device *dev)
> +{
> +	dev->driver->shutdown(dev);
> +}
> +
> +static int virtbus_suspend(struct device *dev, pm_message_t state)
> +{
> +	if (dev->driver->suspend)
> +		return dev->driver->suspend(dev, state);
> +
> +	return 0;
> +}
> +
> +static int virtbus_resume(struct device *dev)
> +{
> +	if (dev->driver->resume)
> +		return dev->driver->resume(dev);
> +
> +	return 0;
> +}
> +
> +struct bus_type virtual_bus_type = {
> +	.name = "virtbus",
> +	.match = virtbus_match,
> +	.probe = virtbus_probe,
> +	.remove = virtbus_remove,
> +	.shutdown = virtbus_shutdown,
> +	.suspend = virtbus_suspend,
> +	.resume = virtbus_resume,
> +};
> +
> +/**
> + * virtbus_dev_release - Destroy a virtbus device
> + * @vdev: virtual device to release
> + */
> +static void virtbus_dev_release(struct device *_dev)
> +{
> +	struct virtbus_device *vdev = to_virtbus_dev(_dev);
> +
> +	ida_simple_remove(&virtbus_dev_ida, vdev->id);
> +	vdev->release(vdev);
> +}
> +
> +/**
> + * virtbus_dev_register - add a virtual bus device
> + * @vdev: virtual bus device to add
> + */
> +int virtbus_dev_register(struct virtbus_device *vdev)
> +{
> +	int ret;
> +
> +	if (!vdev->release) {
> +		dev_err(&vdev->dev, "virtbus_device .release callback NULL\n");
> +		return -EINVAL;
> +	}
> +
> +	device_initialize(&vdev->dev);
> +
> +	vdev->dev.bus = &virtual_bus_type;
> +	vdev->dev.release = virtbus_dev_release;
> +	/* All device IDs are automatically allocated */
> +	ret = ida_simple_get(&virtbus_dev_ida, 0, 0, GFP_KERNEL);
> +	if (ret < 0) {
> +		dev_err(&vdev->dev, "get IDA idx for virtbus device failed!\n");
> +		put_device(&vdev->dev);
> +		return ret;
> +	}
> +
> +	vdev->id = ret;
> +	dev_set_name(&vdev->dev, "%s.%d", vdev->name, vdev->id);
> +
> +	dev_dbg(&vdev->dev, "Registering virtbus device '%s'\n",
> +		dev_name(&vdev->dev));
> +
> +	ret = device_add(&vdev->dev);
> +	if (ret)
> +		goto device_add_err;
> +
> +	return 0;
> +
> +device_add_err:
> +	dev_err(&vdev->dev, "Add device to virtbus failed!\n");
> +	put_device(&vdev->dev);
> +	ida_simple_remove(&virtbus_dev_ida, vdev->id);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(virtbus_dev_register);
> +
> +/**
> + * virtbus_dev_unregister - remove a virtual bus device
> + * vdev: virtual bus device we are removing
> + */
> +void virtbus_dev_unregister(struct virtbus_device *vdev)
> +{
> +	device_del(&vdev->dev);
> +	put_device(&vdev->dev);
> +}
> +EXPORT_SYMBOL_GPL(virtbus_dev_unregister);
> +
> +static int virtbus_drv_probe(struct device *_dev)
> +{
> +	struct virtbus_driver *vdrv = to_virtbus_drv(_dev->driver);
> +	struct virtbus_device *vdev = to_virtbus_dev(_dev);
> +	int ret;
> +
> +	ret = dev_pm_domain_attach(_dev, true);
> +	if (ret) {
> +		dev_warn(_dev, "Failed to attatch to PM Domain : %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = vdrv->probe(vdev);
> +	if (ret) {
> +		dev_err(&vdev->dev, "Probe returned error\n");

Print out the error value?

> +		dev_pm_domain_detach(_dev, true);
> +	}
> +
> +	return ret;
> +}
> +

[?]


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200128/028c7d5f/attachment.p7s>
