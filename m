From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Jan 2020 00:02:41 +0000
Subject: [Intel-wired-lan] [next-queue v6] virtual-bus: Implementation
 of Virtual Bus
In-Reply-To: <20200122174152.5962-1-jeffrey.t.kirsher@intel.com>
References: <20200122174152.5962-1-jeffrey.t.kirsher@intel.com>
Message-ID: <524f74a3cac1446cbe29f4b34cd0dbfd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, January 22, 2020 9:42 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v6] virtual-bus: Implementation of
> Virtual Bus
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> This is the initial implementation of the Virtual Bus, virtbus_device and
> virtbus_driver.  The virtual bus is a software based bus intended to support
> registering virtbus_devices and virtbus_drivers and provide matching
> between them and probing of the registered drivers.
> 
> The bus will support probe/remove shutdown and suspend/resume
> callbacks.
> 
> Kconfig and Makefile alterations are included
> 
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
>  create mode 100644 drivers/bus/virtual_bus.c  create mode 100644
> include/linux/virtual_bus.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


