From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 5 Mar 2020 22:37:09 +0000
Subject: [Intel-wired-lan] [next-queue v7] Implementation of Virtual Bus
In-Reply-To: <20200302213023.1326468-1-jeffrey.t.kirsher@intel.com>
References: <20200302213023.1326468-1-jeffrey.t.kirsher@intel.com>
Message-ID: <a848ffbdf7e6488298de878611de69ab@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Monday, March 2, 2020 1:30 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v7] Implementation of Virtual Bus
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
>  Documentation/driver-api/virtual_bus.rst |  62 ++++++
>  drivers/bus/Kconfig                      |  10 +
>  drivers/bus/Makefile                     |   1 +
>  drivers/bus/virtual_bus.c                | 270 +++++++++++++++++++++++
>  include/linux/mod_devicetable.h          |   8 +
>  include/linux/virtual_bus.h              |  53 +++++
>  scripts/mod/devicetable-offsets.c        |   3 +
>  scripts/mod/file2alias.c                 |   8 +
>  8 files changed, 415 insertions(+)
>  create mode 100644 Documentation/driver-api/virtual_bus.rst
>  create mode 100644 drivers/bus/virtual_bus.c  create mode 100644
> include/linux/virtual_bus.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


