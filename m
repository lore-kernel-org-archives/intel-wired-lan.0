From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 Nov 2019 19:44:29 +0000
Subject: [Intel-wired-lan] virtual-bus[v4]: Implementation of Virtual Bus
In-Reply-To: <2B0E3F215D1AB84DA946C8BEE234CCC97B3014A3@ORSMSX101.amr.corp.intel.com>
References: <2B0E3F215D1AB84DA946C8BEE234CCC97B3014A3@ORSMSX101.amr.corp.intel.com>
Message-ID: <0362d5f99b4948409239baf1571b2655@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Ertman, David M
> Sent: Monday, November 18, 2019 8:07 PM
> To: 'intel-wired-lan at lists.osuosl.org' <intel-wired-lan@lists.osuosl.org>;
> Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Patil, Kiran
> <kiran.patil@intel.com>
> Subject: [Intel-wired-lan] virtual-bus[v4]: Implementation of Virtual Bus
> 
> virtual-bus[v4]: Implementation of Virtual Bus
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> This is the initial implementation of the virtual bus, virtbus_device and
> virtbus_driver.  The virtual bus is a software based bus intended to support
> registering virtbus_devices and virtbus_drivers and provide matching
> between them and probing of the registered drivers.
> 
> The primary purpose of the virtual bus is to provide matching services to
> allow the use of a container_of to get access to a piece of desired data.  This
> will allow two separate kernel objects to match up and start communication.
> 
> The bus will support probe/remove shutdown and suspend/resume
> callbacks.
> 
> Kconfig and Makefile alterations are included
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> ---
>  .../selftests/virtual_bus/virtual_bus_dev/Makefile |    7 +
>  .../virtual_bus/virtual_bus_dev/virtual_bus_dev.c  |   60 ++++++++++
>  .../selftests/virtual_bus/virtual_bus_drv/Makefile |    7 +
>  .../virtual_bus/virtual_bus_drv/virtual_bus_drv.c  |  115
> ++++++++++++++++++++
>  4 files changed, 189 insertions(+)
>  create mode 100644
> tools/testing/selftests/virtual_bus/virtual_bus_dev/Makefile
>  create mode 100644
> tools/testing/selftests/virtual_bus/virtual_bus_dev/virtual_bus_dev.c
>  create mode 100644
> tools/testing/selftests/virtual_bus/virtual_bus_drv/Makefile
>  create mode 100644
> tools/testing/selftests/virtual_bus/virtual_bus_drv/virtual_bus_drv.c

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


