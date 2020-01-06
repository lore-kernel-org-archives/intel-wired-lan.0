From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 6 Jan 2020 20:17:17 +0000
Subject: [Intel-wired-lan] virtual-bus[v5]: Implementation of Virtual Bus
In-Reply-To: <2B0E3F215D1AB84DA946C8BEE234CCC97B33B5D6@ORSMSX101.amr.corp.intel.com>
References: <2B0E3F215D1AB84DA946C8BEE234CCC97B33B5D6@ORSMSX101.amr.corp.intel.com>
Message-ID: <8c819821ba07416a95189db2c57e8648@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Ertman, David M
> Sent: Thursday, December 19, 2019 4:19 PM
> To: 'intel-wired-lan at lists.osuosl.org' <intel-wired-lan@lists.osuosl.org>; Patil,
> Kiran <kiran.patil@intel.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] virtual-bus[v5]: Implementation of Virtual Bus
> 
> virtual-bus[v5]: Implementation of Virtual Bus
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
>  Documentation/driver-api/virtual_bus.rst |   59 +++++++
>  drivers/bus/Kconfig                      |   11 +
>  drivers/bus/Makefile                     |    1
>  drivers/bus/virtual_bus.c                |  267
> ++++++++++++++++++++++++++++++
>  include/linux/mod_devicetable.h          |    8 +
>  include/linux/virtual_bus.h              |   57 ++++++
>  scripts/mod/devicetable-offsets.c        |    3
>  scripts/mod/file2alias.c                 |    8 +
>  8 files changed, 414 insertions(+)
>  create mode 100644 Documentation/driver-api/virtual_bus.rst
>  create mode 100644 drivers/bus/virtual_bus.c  create mode 100644
> include/linux/virtual_bus.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


