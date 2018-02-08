From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 7 Feb 2018 16:37:04 -0800
Subject: [Intel-wired-lan] [net-next] Documentation: Update Intel wired
 LAN docs
In-Reply-To: <20180206210029.27875-1-jeffrey.t.kirsher@intel.com>
References: <20180206210029.27875-1-jeffrey.t.kirsher@intel.com>
Message-ID: <c1c68750-fc0d-8e75-4535-78fb4c8048b9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/6/2018 1:00 PM, Jeff Kirsher wrote:
> Updated the kernel documentation on e1000e, fm10k, i40e/vf, igb/vf and
> ixgbe/vf.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

I didn't really read this for details, but I saw a few things that 
jumped out at me and noted them below.  In general, it would be nice to 
have someone go through them and do proper updates to make these files 
look consistent so they look like they came from the same company.  I 
know there are differences in the individual drivers, but there are a 
lot of similarities and these files should not all look so different. 
There's also still a lot of out-dated information here that doesn't do 
your customer any good.

Also, with so many things changed in each file, it would be much easier 
to review if each was a separate patch rather than having to page 
through a few thousand lines in a single email.  You'd be much more 
likely to have someone who knows about a particular driver review at 
least that one file.

sln

> ---
>   Documentation/networking/e1000e.txt  |  436 ++++++++--------
>   Documentation/networking/fm10k.txt   |  389 +++++++++++++++
>   Documentation/networking/i40e.txt    |  906 +++++++++++++++++++++++++++++-----
>   Documentation/networking/i40evf.txt  |  354 ++++++++++++-
>   Documentation/networking/igb.txt     |  282 ++++++++---
>   Documentation/networking/igbvf.txt   |   82 +--
>   Documentation/networking/ixgbe.txt   |  614 ++++++++++++++---------
>   Documentation/networking/ixgbevf.txt |   63 ++
>   8 files changed, 2378 insertions(+), 748 deletions(-)
>   create mode 100644 Documentation/networking/fm10k.txt
> 
> diff --git a/Documentation/networking/e1000e.txt b/Documentation/networking/e1000e.txt
> index 12089547baed..98681a56ab1d 100644
> --- a/Documentation/networking/e1000e.txt
> +++ b/Documentation/networking/e1000e.txt
> @@ -2,7 +2,7 @@ Linux* Driver for Intel(R) Ethernet Network Connection
>   ======================================================
>   
>   Intel Gigabit Linux driver.
> -Copyright(c) 1999 - 2013 Intel Corporation.
> +Copyright(c) 2014-2016 Intel Corporation.

Should this be 2018 now?

>   
>   Contents
>   ========
> @@ -13,300 +13,310 @@ Contents
>   - Support
>   
>   Identifying Your Adapter
> -========================
> +------------------------
> +For information on how to identify your adapter, and for the latest Intel
> +network drivers, refer to the Intel Support website:
> +http://www.intel.com/support
>   
> -The e1000e driver supports all PCI Express Intel(R) Gigabit Network
> -Connections, except those that are 82575, 82576 and 82580-based*.
> -
> -* NOTE: The Intel(R) PRO/1000 P Dual Port Server Adapter is supported by
> -  the e1000 driver, not the e1000e driver due to the 82546 part being used
> -  behind a PCI Express bridge.
> -
> -For more information on how to identify your adapter, go to the Adapter &
> -Driver ID Guide at:
> -
> -    http://support.intel.com/support/go/network/adapter/idguide.htm
> -
> -For the latest Intel network drivers for Linux, refer to the following
> -website.  In the search field, enter your adapter name or type, or use the
> -networking link on the left to search for your adapter:
> -
> -    http://support.intel.com/support/go/network/adapter/home.htm
>   
>   Command Line Parameters
> -=======================
> -
> +-----------------------
> +If the driver is built as a module, the following optional parameters are used
> +by entering them on the command line with the modprobe command using this
> +syntax:
> +modprobe e1000e [<option>=<VAL1>,<VAL2>,...]
> +
> +There needs to be a <VAL#> for each network port in the system supported by
> +this driver. The values will be applied to each instance, in function order.
> +For example:
> +modprobe e1000e InterruptThrottleRate=16000,16000
> +
> +In this case, there are two network ports supported by e1000e in the system.
>   The default value for each parameter is generally the recommended setting,
>   unless otherwise noted.
>   
> -NOTES:  For more information about the InterruptThrottleRate,
> -        RxIntDelay, TxIntDelay, RxAbsIntDelay, and TxAbsIntDelay
> -        parameters, see the application note at:
> -        http://www.intel.com/design/network/applnots/ap450.htm
> +NOTE: For more information about the command line parameters, see the
> +application note at: http://www.intel.com/design/network/applnots/ap450.htm.
> +
> +NOTE: A descriptor describes a data buffer and attributes related to the data
> +buffer. This information is accessed by the hardware.
> +
>   
>   InterruptThrottleRate
>   ---------------------
> -Valid Range:   0,1,3,4,100-100000 (0=off, 1=dynamic, 3=dynamic conservative,
> -                                   4=simplified balancing)
> -Default Value: 3
> -
> -The driver can limit the amount of interrupts per second that the adapter
> -will generate for incoming packets. It does this by writing a value to the
> -adapter that is based on the maximum amount of interrupts that the adapter
> -will generate per second.
> -
> -Setting InterruptThrottleRate to a value greater or equal to 100
> -will program the adapter to send out a maximum of that many interrupts
> -per second, even if more packets have come in. This reduces interrupt
> -load on the system and can lower CPU utilization under heavy load,
> -but will increase latency as packets are not processed as quickly.
> -
> -The default behaviour of the driver previously assumed a static
> -InterruptThrottleRate value of 8000, providing a good fallback value for
> -all traffic types, but lacking in small packet performance and latency.
> -The hardware can handle many more small packets per second however, and
> -for this reason an adaptive interrupt moderation algorithm was implemented.
> -
> -The driver has two adaptive modes (setting 1 or 3) in which
> -it dynamically adjusts the InterruptThrottleRate value based on the traffic
> -that it receives. After determining the type of incoming traffic in the last
> -timeframe, it will adjust the InterruptThrottleRate to an appropriate value
> -for that traffic.
> -
> -The algorithm classifies the incoming traffic every interval into
> -classes.  Once the class is determined, the InterruptThrottleRate value is
> -adjusted to suit that traffic type the best. There are three classes defined:
> -"Bulk traffic", for large amounts of packets of normal size; "Low latency",
> -for small amounts of traffic and/or a significant percentage of small
> -packets; and "Lowest latency", for almost completely small packets or
> -minimal traffic.
> -
> -In dynamic conservative mode, the InterruptThrottleRate value is set to 4000
> -for traffic that falls in class "Bulk traffic". If traffic falls in the "Low
> -latency" or "Lowest latency" class, the InterruptThrottleRate is increased
> -stepwise to 20000. This default mode is suitable for most applications.
> -
> -For situations where low latency is vital such as cluster or
> -grid computing, the algorithm can reduce latency even more when
> -InterruptThrottleRate is set to mode 1. In this mode, which operates
> -the same as mode 3, the InterruptThrottleRate will be increased stepwise to
> -70000 for traffic in class "Lowest latency".
> -
> -In simplified mode the interrupt rate is based on the ratio of TX and
> -RX traffic.  If the bytes per second rate is approximately equal, the
> -interrupt rate will drop as low as 2000 interrupts per second.  If the
> -traffic is mostly transmit or mostly receive, the interrupt rate could
> -be as high as 8000.
> -
> -Setting InterruptThrottleRate to 0 turns off any interrupt moderation
> -and may improve small packet latency, but is generally not suitable
> -for bulk throughput traffic.
> -
> -NOTE:  InterruptThrottleRate takes precedence over the TxAbsIntDelay and
> -       RxAbsIntDelay parameters.  In other words, minimizing the receive
> -       and/or transmit absolute delays does not force the controller to
> -       generate more interrupts than what the Interrupt Throttle Rate
> -       allows.
> -
> -NOTE:  When e1000e is loaded with default settings and multiple adapters
> -       are in use simultaneously, the CPU utilization may increase non-
> -       linearly.  In order to limit the CPU utilization without impacting
> -       the overall throughput, we recommend that you load the driver as
> -       follows:
> -
> -           modprobe e1000e InterruptThrottleRate=3000,3000,3000
> -
> -       This sets the InterruptThrottleRate to 3000 interrupts/sec for
> -       the first, second, and third instances of the driver.  The range
> -       of 2000 to 3000 interrupts per second works on a majority of
> -       systems and is a good starting point, but the optimal value will
> -       be platform-specific.  If CPU utilization is not a concern, use
> -       RX_POLLING (NAPI) and default driver settings.
> +Valid Range:
> +0=off
> +1=dynamic
> +4=simplified balancing
> +<min_ITR>-<max_ITR>
> +Interrupt Throttle Rate controls the number of interrupts each interrupt
> +vector can generate per second. Increasing ITR lowers latency at the cost of
> +increased CPU utilization, though it may help throughput in some circumstances.
> +0 = Setting InterruptThrottleRate to 0 turns off any interrupt moderation
> +  and may improve small packet latency. However, this is generally not
> +  suitable for bulk throughput traffic due to the increased CPU utilization
> +  of the higher interrupt rate.
> +  NOTES:
> +  - On 82599, and X540, and X550-based adapters, disabling InterruptThrottleRate
> +    will also result in the driver disabling HW RSC.
> +  - On 82598-based adapters, disabling InterruptThrottleRate will also
> +    result in disabling LRO (Large Receive Offloads).
> +1 = Setting InterruptThrottleRate to Dynamic mode attempts to moderate
> +  interrupts per vector while maintaining very low latency. This can
> +  sometimes cause extra CPU utilization. If planning on deploying e1000e
> +  in a latency sensitive environment, this parameter should be considered.
> +<min_ITR>-<max_ITR> =
> +  Setting InterruptThrottleRate to a value greater or equal to <min_ITR>
> +  will program the adapter to send at most that many interrupts
> +  per second, even if more packets have come in. This reduces interrupt load
> +  on the system and can lower CPU utilization under heavy load, but will
> +  increase latency as packets are not processed as quickly.
> +
> +NOTE:
> +- InterruptThrottleRate takes precedence over the TxAbsIntDelay and
> +  RxAbsIntDelay parameters. In other words, minimizing the receive and/or
> +  transmit absolute delays does not force the controller to generate more
> +  interrupts than what the Interrupt Throttle Rate allows.
> +
>   
>   RxIntDelay
>   ----------
> -Valid Range:   0-65535 (0=off)
> -Default Value: 0
> -
> +Valid Range: 0-65535 (0=off)
>   This value delays the generation of receive interrupts in units of 1.024
> -microseconds.  Receive interrupt reduction can improve CPU efficiency if
> -properly tuned for specific network traffic.  Increasing this value adds
> -extra latency to frame reception and can end up decreasing the throughput
> -of TCP traffic.  If the system is reporting dropped receives, this value
> -may be set too high, causing the driver to run out of available receive
> -descriptors.
> -
> -CAUTION:  When setting RxIntDelay to a value other than 0, adapters may
> -          hang (stop transmitting) under certain network conditions.  If
> -          this occurs a NETDEV WATCHDOG message is logged in the system
> -          event log.  In addition, the controller is automatically reset,
> -          restoring the network connection.  To eliminate the potential
> -          for the hang ensure that RxIntDelay is set to 0.
> +microseconds. Receive interrupt reduction can improve CPU efficiency if
> +properly tuned for specific network traffic. Increasing this value adds extra
> +latency to frame reception and can end up decreasing the throughput of TCP
> +traffic. If the system is reporting dropped receives, this value may be set
> +too high, causing the driver to run out of available receive descriptors.
> +CAUTION: When setting RxIntDelay to a value other than 0, adapters may hang
> +(stop transmitting) under certain network conditions. If this occurs a NETDEV
> +WATCHDOG message is logged in the system event log. In addition, the
> +controller is automatically reset, restoring the network connection. To
> +eliminate the potential for the hang ensure that RxIntDelay is set to 0.
>   
>   RxAbsIntDelay
>   -------------
> -Valid Range:   0-65535 (0=off)
> -Default Value: 8
> -
> +Valid Range: 0-65535 (0=off)
>   This value, in units of 1.024 microseconds, limits the delay in which a
> -receive interrupt is generated.  Useful only if RxIntDelay is non-zero,
> -this value ensures that an interrupt is generated after the initial
> -packet is received within the set amount of time.  Proper tuning,
> -along with RxIntDelay, may improve traffic throughput in specific network
> -conditions.
> +receive interrupt is generated. This value ensures that an interrupt is
> +generated after the initial packet is received within the set amount of time,
> +which is useful only if RxIntDelay is non-zero. Proper tuning, along with
> +RxIntDelay, may improve traffic throughput in specific network conditions.
> +
>   
>   TxIntDelay
>   ----------
> -Valid Range:   0-65535 (0=off)
> -Default Value: 8
> +Valid Range: 0-65535 (0=off)
> +This value delays the generation of transmit interrupts in units of 1.024
> +microseconds. Transmit interrupt reduction can improve CPU efficiency if
> +properly tuned for specific network traffic. If the system is reporting
> +dropped transmits, this value may be set too high causing the driver to run
> +out of available transmit descriptors.
>   
> -This value delays the generation of transmit interrupts in units of
> -1.024 microseconds.  Transmit interrupt reduction can improve CPU
> -efficiency if properly tuned for specific network traffic.  If the
> -system is reporting dropped transmits, this value may be set too high
> -causing the driver to run out of available transmit descriptors.
>   
>   TxAbsIntDelay
>   -------------
> -Valid Range:   0-65535 (0=off)
> -Default Value: 32
> -
> +Valid Range: 0-65535 (0=off)
>   This value, in units of 1.024 microseconds, limits the delay in which a
> -transmit interrupt is generated.  Useful only if TxIntDelay is non-zero,
> -this value ensures that an interrupt is generated after the initial
> -packet is sent on the wire within the set amount of time.  Proper tuning,
> -along with TxIntDelay, may improve traffic throughput in specific
> -network conditions.
> +transmit interrupt is generated. It is useful only if TxIntDelay is non-zero.
> +It ensures that an interrupt is generated after the initial Packet is sent on
> +the wire within the set amount of time. Proper tuning, along with TxIntDelay,
> +may improve traffic throughput in specific network conditions.
>   
> -Copybreak
> ----------
> -Valid Range:   0-xxxxxxx (0=off)
> -Default Value: 256
>   
> -Driver copies all packets below or equaling this size to a fresh RX
> +copybreak
> +---------
> +Valid Range: 0-xxxxxxx (0=off)
> +The driver copies all packets below or equaling this size to a fresh receive
>   buffer before handing it up the stack.
> +This parameter differs from other parameters because it is a single (not 1,1,1
> +etc.) parameter applied to all driver instances and it is also available
> +during runtime at /sys/module/e1000e/parameters/copybreak.
> +
> +To use copybreak, type
> +
> +  modprobe e1000e.ko copybreak=128
>   
> -This parameter is different than other parameters, in that it is a
> -single (not 1,1,1 etc.) parameter applied to all driver instances and
> -it is also available during runtime at
> -/sys/module/e1000e/parameters/copybreak
>   
>   SmartPowerDownEnable
>   --------------------
>   Valid Range: 0-1
> -Default Value:  0 (disabled)
> +Allows Phy to turn off in lower power states. The user can turn off this
> +parameter in supported chipsets.
>   
> -Allows PHY to turn off in lower power states. The user can set this parameter
> -in supported chipsets.
>   
>   KumeranLockLoss
>   ---------------
>   Valid Range: 0-1
> -Default Value: 1 (enabled)
> +This workaround skips resetting the Phy at shutdown for the initial silicon
> +releases of ICH8 systems.
>   
> -This workaround skips resetting the PHY at shutdown for the initial
> -silicon releases of ICH8 systems.
>   
>   IntMode
>   -------
> -Valid Range: 0-2 (0=legacy, 1=MSI, 2=MSI-X)
> -Default Value: 2
> +Valid Range: 0-2 (0 = Legacy Int, 1 = MSI and 2 = MSI-X)
> +IntMode controls allow load time control over the type of interrupt
> +registered for by the driver. MSI-X is required for multiple queue
> +support, and some kernels and combinations of kernel .config options
> +will force a lower level of interrupt support.
> +'cat /proc/interrupts' will show different values for each type of interrupt.
>   
> -Allows changing the interrupt mode at module load time, without requiring a
> -recompile. If the driver load fails to enable a specific interrupt mode, the
> -driver will try other interrupt modes, from least to most compatible.  The
> -interrupt order is MSI-X, MSI, Legacy.  If specifying MSI (IntMode=1)
> -interrupts, only MSI and Legacy will be attempted.
>   
>   CrcStripping
>   ------------
>   Valid Range: 0-1
> -Default Value: 1 (enabled)
> -
> -Strip the CRC from received packets before sending up the network stack.  If
> +Strip the CRC from received packets before sending up the network stack. If
>   you have a machine with a BMC enabled but cannot receive IPMI traffic after
>   loading or enabling the driver, try disabling this feature.
>   
> +
>   WriteProtectNVM
>   ---------------
> +
>   Valid Range: 0,1
> -Default Value: 1
>   
>   If set to 1, configure the hardware to ignore all write/erase cycles to the
>   GbE region in the ICHx NVM (in order to prevent accidental corruption of the
>   NVM). This feature can be disabled by setting the parameter to 0 during initial
>   driver load.
> +
>   NOTE: The machine must be power cycled (full off/on) when enabling NVM writes
>   via setting the parameter to zero. Once the NVM has been locked (via the
>   parameter at 1 when the driver loads) it cannot be unlocked except via power
>   cycle.
>   
> -Additional Configurations
> -=========================
>   
> -  Jumbo Frames
> -  ------------
> -  Jumbo Frames support is enabled by changing the MTU to a value larger than
> -  the default of 1500.  Use the ifconfig command to increase the MTU size.
> -  For example:
> +Additional Features and Configurations
> +-------------------------------------------
> +
>   
> -       ifconfig eth<x> mtu 9000 up
> +Jumbo Frames
> +------------
> +Jumbo Frames support is enabled by changing the Maximum Transmission Unit (MTU)
> +to a value larger than the default value of 1500.
> +
> +Use the ifconfig command to increase the MTU size. For example, enter the
> +following where <x> is the interface number:
> +
> +   ifconfig eth<x> mtu 9000 up
> +Alternatively, you can use the ip command as follows:
> +   ip link set mtu 9000 dev eth<x>
> +   ip link set up dev eth<x>
> +
> +This setting is not saved across reboots. The setting change can be made
> +permanent by adding 'MTU=9000' to the file:
> +/etc/sysconfig/network-scripts/ifcfg-eth<x> for RHEL or to the file
> +/etc/sysconfig/network/<config_file> for SLES.
> +
> +NOTE: The maximum MTU setting for Jumbo Frames is 8996. This value coincides
> +with the maximum Jumbo Frames size of 9018 bytes.
> +
> +NOTE: Using Jumbo frames at 10 or 100 Mbps is not supported and may result in
> +poor performance or loss of link.
> +
> +NOTE: The following adapters limit Jumbo Frames sized packets to a maximum of
> +4088 bytes:
> +  - Intel(R) 82578DM Gigabit Network Connection
> +  - Intel(R) 82577LM Gigabit Network Connection
> +- The following adapters do not support Jumbo Frames:
> +  - Intel(R) PRO/1000 Gigabit Server Adapter
> +  - Intel(R) PRO/1000 PM Network Connection
> +  - Intel(R) 82562G 10/100 Network Connection
> +  - Intel(R) 82562G-2 10/100 Network Connection
> +  - Intel(R) 82562GT 10/100 Network Connection
> +  - Intel(R) 82562GT-2 10/100 Network Connection
> +  - Intel(R) 82562V 10/100 Network Connection
> +  - Intel(R) 82562V-2 10/100 Network Connection
> +  - Intel(R) 82566DC Gigabit Network Connection
> +  - Intel(R) 82566DC-2 Gigabit Network Connection
> +  - Intel(R) 82566DM Gigabit Network Connection
> +  - Intel(R) 82566MC Gigabit Network Connection
> +  - Intel(R) 82566MM Gigabit Network Connection
> +  - Intel(R) 82567V-3 Gigabit Network Connection
> +  - Intel(R) 82577LC Gigabit Network Connection
> +  - Intel(R) 82578DC Gigabit Network Connection
> +- Jumbo Frames cannot be configured on an 82579-based Network device if
> +  MACSec is enabled on the system.
> +
> +
> +ethtool
> +-------
> +The driver utilizes the ethtool interface for driver configuration and
> +diagnostics, as well as displaying statistical information. The latest ethtool
> +version is required for this functionality. Download it at:
> +http://ftp.kernel.org/pub/software/network/ethtool/
>   
> -  This setting is not saved across reboots.
> +NOTE: When validating enable/disable tests on some parts (for example, 82578),
> +it is necessary to add a few seconds between tests when working with ethtool.
>   
> -  Notes:
>   
> -  - The maximum MTU setting for Jumbo Frames is 9216.  This value coincides
> -    with the maximum Jumbo Frames size of 9234 bytes.
> +Speed and Duplex Configuration
> +------------------------------
> +In addressing speed and duplex configuration issues, you need to distinguish
> +between copper-based adapters and fiber-based adapters.
>   
> -  - Using Jumbo frames at 10 or 100 Mbps is not supported and may result in
> -    poor performance or loss of link.
> +In the default mode, an Intel(R) Ethernet Network Adapter using copper
> +connections will attempt to auto-negotiate with its link partner to determine
> +the best setting. If the adapter cannot establish link with the link partner
> +using auto-negotiation, you may need to manually configure the adapter and link
> +partner to identical settings to establish link and pass packets. This should
> +only be needed when attempting to link with an older switch that does not
> +support auto-negotiation or one that has been forced to a specific speed or
> +duplex mode. Your link partner must match the setting you choose. 1 Gbps speeds
> +and higher cannot be forced. Use the autonegotiation advertising setting to
> +manually set devices for 1 Gbps and higher.
>   
> -  - Some adapters limit Jumbo Frames sized packets to a maximum of
> -    4096 bytes and some adapters do not support Jumbo Frames.
> +Speed, duplex, and autonegotiation advertising are configured through the
> +ethtool* utility. ethtool is included with all versions of Red Hat after Red
> +Hat 7.2. For the latest version, download and install ethtool from the
> +following website:
>   
> -  - Jumbo Frames cannot be configured on an 82579-based Network device, if
> -    MACSec is enabled on the system.
> +   http://ftp.kernel.org/pub/software/network/ethtool/
>   
> -  ethtool
> -  -------
> -  The driver utilizes the ethtool interface for driver configuration and
> -  diagnostics, as well as displaying statistical information.  We
> -  strongly recommend downloading the latest version of ethtool at:
> +Caution: Only experienced network administrators should force speed and duplex
> +or change autonegotiation advertising manually. The settings at the switch must
> +always match the adapter settings. Adapter performance may suffer or your
> +adapter may not operate if you configure the adapter differently from your
> +switch.
>   
> -  https://kernel.org/pub/software/network/ethtool/
> +An Intel(R) Ethernet Network Adapter using fiber-based connections, however,
> +will not attempt to auto-negotiate with its link partner since those adapters
> +operate only in full duplex and only at their native speed.
>   
> -  NOTE: When validating enable/disable tests on some parts (82578, for example)
> -  you need to add a few seconds between tests when working with ethtool.
>   
> -  Speed and Duplex
> -  ----------------
> -  Speed and Duplex are configured through the ethtool* utility. For
> -  instructions,  refer to the ethtool man page.
> +Enabling Wake on LAN* (WoL)
> +---------------------------
>   
> -  Enabling Wake on LAN* (WoL)
> -  ---------------------------
> -  WoL is configured through the ethtool* utility. For instructions on
> -  enabling WoL with ethtool, refer to the ethtool man page.
> +WoL is configured through the ethtool* utility. ethtool is included with all
> +versions of Red Hat after Red Hat 7.2. For other Linux distributions, download
> +and install ethtool from the following website:
> +http://ftp.kernel.org/pub/software/network/ethtool/.
>   
> -  WoL will be enabled on the system during the next shut down or reboot.
> -  For this driver version, in order to enable WoL, the e1000e driver must be
> -  loaded when shutting down or rebooting the system.
> +For instructions on enabling WoL with ethtool, refer to the website listed
> +above.
>   
> -  In most cases Wake On LAN is only supported on port A for multiple port
> -  adapters. To verify if a port supports Wake on Lan run ethtool eth<X>.
> +WoL will be enabled on the system during the next shut down or reboot. For
> +this driver version, in order to enable WoL, the e1000e driver must be loaded
> +prior to shutting down or suspending the system.
>   
> -Support
> -=======
> +NOTE: Wake on LAN is only supported on port A for the following devices:
> +- Intel(R) PRO/1000 PT Dual Port Network Connection
> +- Intel(R) PRO/1000 PT Dual Port Server Connection
> +- Intel(R) PRO/1000 PT Dual Port Server Adapter
> +- Intel(R) PRO/1000 PF Dual Port Server Adapter
> +- Intel(R) PRO/1000 PT Quad Port Server Adapter
> +- Intel(R) Gigabit PT Quad Port Server ExpressModule
>   
> -For general information, go to the Intel support website at:
>   
> -    www.intel.com/support/
> +Support
> +-------
> +For general information, go to the Intel support website at:
> +www.intel.com/support/
>   
>   or the Intel Wired Networking project hosted by Sourceforge at:
> +http://sourceforge.net/projects/e1000
> +If an issue is identified with the released source code on a supported kernel
> +with a supported adapter, email the specific information related to the issue
> +to e1000-devel at lists.sf.net.
>   
> -    http://sourceforge.net/projects/e1000
>   
> -If an issue is identified with the released source code on the supported
> -kernel with a supported adapter, email the specific information related
> -to the issue to e1000-devel at lists.sf.net
> diff --git a/Documentation/networking/fm10k.txt b/Documentation/networking/fm10k.txt
> new file mode 100644
> index 000000000000..af7d9ef529ed
> --- /dev/null
> +++ b/Documentation/networking/fm10k.txt
> @@ -0,0 +1,389 @@
> +README for Intel(R) Ethernet Multi-host Controller Driver
> +=========================================================
> +
> +February 23, 2017
> +Copyright(c) 2015-2017 Intel Corporation.

2018?

> +
> +Contents
> +========
> +- Identifying Your Adapter
> +- Additional Configurations
> +- Performance Tuning
> +- Known Issues
> +- Support
> +
> +Identifying Your Adapter
> +------------------------
> +The driver in this release is compatible with devices based on the Intel(R)
> +Ethernet Multi-host Controller.
> +
> +For information on how to identify your adapter, and for the latest Intel
> +network drivers, refer to the Intel Support website:
> +http://www.intel.com/support
> +
> +
> +SFP+ Devices with Pluggable Optics
> +----------------------------------
> +
> +82599-BASED ADAPTERS
> +--------------------

Maybe I'm missing something, or just purely don't know what I'm talking 
about with fm10k, but why are you talking about Niantic parts here?

> +
> +NOTES:
> +- If your 82599-based Intel(R) Network Adapter came with Intel optics or is an
> +  Intel(R) Ethernet Server Adapter X520-2, then it only supports Intel optics
> +  and/or the direct attach cables listed below.
> +- When 82599-based SFP+ devices are connected back to back, they should be
> +  set to the same Speed setting via ethtool. Results may vary if you mix
> +  speed settings.
> +
> +Supplier	Type					Part Numbers
> +--------	----					------------
> +SR Modules
> +Intel		DUAL RATE 1G/10G SFP+ SR (bailed)	FTLX8571D3BCV-IT
> +Intel		DUAL RATE 1G/10G SFP+ SR (bailed)	AFBR-703SDZ-IN2
> +Intel		DUAL RATE 1G/10G SFP+ SR (bailed)	AFBR-703SDDZ-IN1
> +LR Modules
> +Intel		DUAL RATE 1G/10G SFP+ LR (bailed)	FTLX1471D3BCV-IT
> +Intel		DUAL RATE 1G/10G SFP+ LR (bailed)	AFCT-701SDZ-IN2
> +Intel		DUAL RATE 1G/10G SFP+ LR (bailed)	AFCT-701SDDZ-IN1
> +
> +The following is a list of 3rd party SFP+ modules that have received some
> +testing. Not all modules are applicable to all devices.
> +
> +Supplier	Type					Part Numbers
> +--------	----					------------
> +Finisar		SFP+ SR bailed, 10g single
> +rate		FTLX8571D3BCL
> +Avago		SFP+ SR bailed, 10g single rate		AFBR-700SDZ
> +Finisar		SFP+ LR bailed, 10g single
> +rate		FTLX1471D3BCL
> +Finisar		DUAL RATE 1G/10G SFP+ SR (No
> +Bail)	FTLX8571D3QCV-IT
> +Avago		DUAL RATE 1G/10G SFP+ SR (No Bail)	AFBR-703SDZ-IN1
> +Finisar		DUAL RATE 1G/10G SFP+ LR (No
> +Bail)	FTLX1471D3QCV-IT
> +Avago		DUAL RATE 1G/10G SFP+ LR (No Bail)	AFCT-701SDZ-IN1
> +
> +Finisar		1000BASE-T
> +SFP				FCLF8522P2BTL
> +Avago		1000BASE-T				ABCU-5710RZ
> +HP		1000BASE-SX SFP				453153-001
> +
> +82599-based adapters support all passive and active limiting direct attach
> +cables that comply with SFF-8431 v4.1 and SFF-8472 v10.4 specifications.
> +
> +
> +Laser turns off for SFP+ when ifconfig ethX down
> +------------------------------------------------
> +
> +"ifconfig ethX down" turns off the laser for 82599-based SFP+ fiber adapters.
> +"ifconfig ethX up" turns on the laser.
> +Alternatively, you can use "ip link set [down/up] dev ethX" to turn the
> +laser off and on.
> +
> +
> +82599-based QSFP+ Adapters
> +--------------------------
> +
> +NOTES:
> +- If your 82599-based Intel(R) Network Adapter came with Intel optics, it
> +  only supports Intel optics.
> +- 82599-based QSFP+ adapters only support 4x10 Gbps connections.
> +  1x40 Gbps connections are not supported. QSFP+ link partners must be
> +  configured for 4x10 Gbps.
> +- 82599-based QSFP+ adapters do not support automatic link speed detection.
> +  The link speed must be configured to either 10 Gbps or 1 Gbps to match the
> +  link partners speed capabilities. Incorrect speed configurations will result
> +  in failure to link.
> +- Intel(R) Ethernet Converged Network Adapter X520-Q1 only supports the
> +  optics and direct attach cables listed below.
> +
> +
> +Supplier	Type				Part Numbers
> +--------	----				------------
> +Intel	DUAL RATE 1G/10G QSFP+ SRL (bailed)	E10GQSFPSR
> +
> +82599-based QSFP+ adapters support all passive and active limiting QSFP+
> +direct attach cables that comply with SFF-8436 v4.1 specifications.
> +
> +
> +82598-BASED ADAPTERS
> +--------------------
> +
> +NOTES:
> +- Intel(r) Ethernet Network Adapters that support removable optical modules
> +  only support their original module type (for example, the Intel(R) 10 Gigabit
> +  SR Dual Port Express Module only supports SR optical modules). If you plug
> +  in a different type of module, the driver will not load.
> +- Hot Swapping/hot plugging optical modules is not supported.
> +- Only single speed, 10 gigabit modules are supported.
> +- LAN on Motherboard (LOMs) may support DA, SR, or LR modules. Other module
> +  types are not supported. Please see your system documentation for details.
> +
> +  The following is a list of SFP+ modules and direct attach cables that have
> +  received some testing. Not all modules are applicable to all devices.
> +
> +Supplier	Type					Part Numbers
> +--------	----					------------
> +Finisar		SFP+ SR bailed, 10g single
> +rate		FTLX8571D3BCL
> +Avago		SFP+ SR bailed, 10g single rate		AFBR-700SDZ
> +Finisar		SFP+ LR bailed, 10g single
> +rate		FTLX1471D3BCL
> +
> +82598-based adapters support all passive direct attach cables that comply with
> +SFF-8431 v4.1 and SFF-8472 v10.4 specifications. Active direct attach cables
> +are not supported.
> +
> +Third party optic modules and cables referred to above are listed only for the
> +purpose of highlighting third party specifications and potential
> +compatibility, and are not recommendations or endorsements or sponsorship of
> +any third party's product by Intel. Intel is not endorsing or promoting
> +products made by any third party and the third party reference is provided
> +only to share information regarding certain optic modules and cables with the
> +above specifications. There may be other manufacturers or suppliers, producing
> +or supplying optic modules and cables with similar or matching descriptions.
> +Customers must use their own discretion and diligence to purchase optic
> +modules and cables from any third party of their choice. Customers are solely
> +responsible for assessing the suitability of the product and/or devices and
> +for the selection of the vendor for purchasing any product. THE OPTIC MODULES
> +AND CABLES REFERRED TO ABOVE ARE NOT WARRANTED OR SUPPORTED BY INTEL. INTEL
> +ASSUMES NO LIABILITY WHATSOEVER, AND INTEL DISCLAIMS ANY EXPRESS OR IMPLIED
> +WARRANTY, RELATING TO SALE AND/OR USE OF SUCH THIRD PARTY PRODUCTS OR
> +SELECTION OF VENDOR BY CUSTOMERS.
> +
> +
> +Flow Control
> +------------
> +The Intel(R) Ethernet Switch Host Interface Driver does not support Flow
> +Control. It will not send pause frames. This may result in dropped frames.
> +
> +
> +Intel(R) Ethernet Flow Director
> +-------------------------------
> +The Intel Ethernet Flow Director performs the following tasks:
> +
> +- Directs receive packets according to their flows to different queues.
> +- Enables tight control on routing a flow in the platform.
> +- Matches flows and CPU cores for flow affinity.
> +- Supports multiple parameters for flexible flow classification and load
> +  balancing (in SFP mode only).
> +
> +NOTE: An included script (set_irq_affinity) automates setting the IRQ to CPU
> +affinity.
> +
> +ethtool commands:
> +
> +To enable or disable the Intel Ethernet Flow Director:
> +
> +  # ethtool -K ethX ntuple <on|off>
> +
> +When disabling ntuple filters, all the user programed filters are flushed from
> +the driver cache and hardware. All needed filters must be re-added when ntuple
> +is re-enabled.
> +
> +To add a filter that directs packet to queue 2, use -U or -N switch:
> +
> +  # ethtool -N ethX flow-type tcp4 src-ip 192.168.10.1 dst-ip \
> +  192.168.10.2 src-port 2000 dst-port 2001 action 2 [loc 1]
> +
> +To see the list of filters currently present:
> +  # ethtool <-u|-n> ethX
> +
> +
> +FdirPballoc
> +-----------
> +Valid Range: 1-3
> +Specifies the Flow Director allocated packet buffer size.
> +1 = 64k
> +2 = 128k
> +3 = 256k
> +
> +
> +AtrSampleRate
> +-------------
> +Valid Range: 0-255
> +This parameter is used with the Flow Director and is the software ATR transmit
> +packet sample rate. For example, when AtrSampleRate is set to 20, every 20th
> +packet looks to see if the packet will create a new flow. A value of 0
> +indicates that ATR should be disabled and no samples will be taken.
> +
> +
> +Node
> +----
> +Valid Range: 0-n
> +0 - n: where n is the number of the NUMA node that should be used to allocate
> +memory for this adapter port.
> +-1: uses the driver default of allocating memory on whichever processor is
> +running modprobe.
> +The Node parameter allows you to choose which NUMA node you want to have the
> +adapter allocate memory from. All driver structures, in-memory queues, and
> +receive buffers will be allocated on the node specified. This parameter is
> +only useful when interrupt affinity is specified; otherwise, part of the
> +interrupt time could run on a different core than where the memory is
> +allocated causing slower memory access and impacting throughput, CPU, or both.
> +
> +
> +max_vfs
> +-------
> +This parameter adds support for SR-IOV. It causes the driver to spawn up to
> +max_vfs worth of virtual functions.
> +Valid Range:0-64
> +
> +NOTE: This parameter is only used on kernel 3.7.x and below. On kernel 3.8.x
> +and above, use sysfs to enable VFs. Also, for Red Hat distributions, this
> +parameter is only used on version 6.6 and older. For version 6.7 and newer, use
> +sysfs. For example:
> +#echo $num_vf_enabled > /sys/class/net/$dev/device/sriov_numvfs	//enable
> +VFs
> +#echo 0 > /sys/class/net/$dev/device/sriov_numvfs	//disable VFs
> +
> +The parameters for the driver are referenced by position. Thus, if you have a
> +dual port adapter, or more than one adapter in your system, and want N virtual
> +functions per port, you must specify a number for each port with each parameter
> +separated by a comma. For example:
> +
> +  modprobe fm10k max_vfs=4
> +
> +This will spawn 4 VFs on the first port.
> +
> +  modprobe fm10k max_vfs=2,4
> +
> +This will spawn 2 VFs on the first port and 4 VFs on the second port.
> +
> +NOTE: Caution must be used in loading the driver with these parameters.
> +Depending on your system configuration, number of slots, etc., it is impossible
> +to predict in all cases where the positions would be on the command line.
> +
> +NOTE: Neither the device nor the driver control how VFs are mapped into config
> +space. Bus layout will vary by operating system. On operating systems that
> +support it, you can check sysfs to find the mapping.
> +
> +
> +NOTE: When SR-IOV mode is enabled, hardware VLAN filtering and VLAN tag
> +stripping/insertion will remain enabled. Please remove the old VLAN filter
> +before the new VLAN filter is added. For example,
> +ip link set eth0 vf 0 vlan 100	// set vlan 100 for VF 0
> +ip link set eth0 vf 0 vlan 0	// Delete vlan 100
> +ip link set eth0 vf 0 vlan 200	// set a new vlan 200 for VF 0
> +
> +
> +Additional Features and Configurations
> +-------------------------------------------
> +
> +
> +Jumbo Frames
> +------------
> +Jumbo Frames support is enabled by changing the Maximum Transmission Unit (MTU)
> +to a value larger than the default value of 1500.
> +
> +Use the ifconfig command to increase the MTU size. For example, enter the
> +following where <x> is the interface number:
> +
> +   ifconfig eth<x> mtu 9000 up
> +Alternatively, you can use the ip command as follows:
> +   ip link set mtu 9000 dev eth<x>
> +   ip link set up dev eth<x>
> +
> +This setting is not saved across reboots. The setting change can be made
> +permanent by adding 'MTU=9000' to the file:
> +/etc/sysconfig/network-scripts/ifcfg-eth<x> for RHEL or to the file
> +/etc/sysconfig/network/<config_file> for SLES.
> +
> +NOTE: The maximum MTU setting for Jumbo Frames is 15342. This value coincides
> +with the maximum Jumbo Frames size of 15364 bytes.
> +
> +NOTE: This driver will attempt to use multiple page sized buffers to receive
> +each jumbo packet. This should help to avoid buffer starvation issues when
> +allocating receive packets.
> +
> +
> +Generic Receive Offload, aka GRO
> +--------------------------------
> +
> +The driver supports the in-kernel software implementation of GRO. GRO has
> +shown that by coalescing Rx traffic into larger chunks of data, CPU
> +utilization can be significantly reduced when under large Rx load. GRO is an
> +evolution of the previously-used LRO interface. GRO is able to coalesce
> +other protocols besides TCP. It's also safe to use with configurations that
> +are problematic for LRO, namely bridging and iSCSI.
> +
> +
> +ethtool
> +-------
> +The driver utilizes the ethtool interface for driver configuration and
> +diagnostics, as well as displaying statistical information. The latest ethtool
> +version is required for this functionality. Download it at:
> +http://ftp.kernel.org/pub/software/network/ethtool/
> +
> +Supported ethtool Commands and Options for Filtering
> +----------------------------------------------------
> +-n --show-nfc
> +  Retrieves the receive network flow classification configurations.
> +
> +rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|tcp6|udp6|ah6|esp6|sctp6
> +  Retrieves the hash options for the specified network traffic type.
> +
> +-N --config-nfc
> +  Configures the receive network flow classification.
> +
> +rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|tcp6|udp6|ah6|esp6|sctp6
> +m|v|t|s|d|f|n|r...
> +  Configures the hash options for the specified network traffic type.
> +
> +  udp4 UDP over IPv4
> +  udp6 UDP over IPv6
> +
> +  f Hash on bytes 0 and 1 of the Layer 4 header of the rx packet.
> +  n Hash on bytes 2 and 3 of the Layer 4 header of the rx packet.
> +
> +
> +FCoE
> +----
> +
> +This release of the fm10k driver contains new code to enable users to use
> +Fiber Channel over Ethernet (FCoE) and Data Center Bridging (DCB)
> +functionality that is supported by the 82598-based hardware. This code has
> +no default effect on the regular driver operation, and configuring DCB and
> +FCoE is outside the scope of this driver README. Refer to
> +http://www.open-fcoe.org/ for FCoE project information and contact
> +fm10k-eedc at lists.sourceforge.net for DCB information.
> +
> +
> +MAC and VLAN anti-spoofing feature
> +----------------------------------
> +
> +When a malicious driver attempts to send a spoofed packet, it is dropped by the
> +hardware and not transmitted.
> +
> +An interrupt is sent to the PF driver notifying it of the spoof attempt. When a
> +spoofed packet is detected, the PF driver will send the following message to
> +the system log (displayed by the "dmesg" command):
> +NOTE: This feature can be disabled for a specific Virtual Function (VF):
> +ip link set <pf dev> vf <vf id> spoofchk {off|on}
> +
> +
> +Known Issues/Troubleshooting
> +----------------------------
> +
> +
> +Enabling SR-IOV in a 64-bit Microsoft* Windows Server* 2012/R2 guest OS under
> +Linux KVM
> +--------------------------------------------------------------------------------
> +KVM Hypervisor/VMM supports direct assignment of a PCIe device to a VM. This
> +includes traditional PCIe devices, as well as SR-IOV-capable devices based on
> +the Intel Ethernet Controller XL710.
> +
> +
> +Support
> +-------
> +For general information, go to the Intel support website at:
> +www.intel.com/support/
> +
> +or the Intel Wired Networking project hosted by Sourceforge at:
> +http://sourceforge.net/projects/e1000
> +If an issue is identified with the released source code on a supported kernel
> +with a supported adapter, email the specific information related to the issue
> +to e1000-devel at lists.sf.net.
> +
> +
> diff --git a/Documentation/networking/i40e.txt b/Documentation/networking/i40e.txt
> index 57e616ed10b0..511098eee5ec 100644
> --- a/Documentation/networking/i40e.txt
> +++ b/Documentation/networking/i40e.txt
> @@ -1,190 +1,836 @@
> -Linux Base Driver for the Intel(R) Ethernet Controller XL710 Family
> -===================================================================
>   
> -Intel i40e Linux driver.
> -Copyright(c) 2013 Intel Corporation.
> +i40e Linux* Base Driver for the Intel(R) Ethernet Controller 700 Series
> +===============================================================================
> +
> +November 28, 2017

Are you not going to add a copyright?

> +
> +===============================================================================
>   
>   Contents
> -========
> +--------
>   
> +- Overview
>   - Identifying Your Adapter
> -- Additional Configurations
> -- Performance Tuning
> -- Known Issues
> -- Support
> +- Intel(R) Ethernet Flow Director
> +- Additional Features & Configurations
> +
> +
> +================================================================================
> +
> +
> +TC0 must be enabled when setting up DCB on a switch
> +---------------------------------------------------
> +The kernel assumes that TC0 is available, and will disable Priority Flow
> +Control (PFC) on the device if TC0 is not available. To fix this, ensure TC0 is
> +enabled when setting up DCB on your switch.

This seems odd to have right at the top before any ID information.

> +
> +
> +This driver supports kernel versions 2.6.32 and newer.
> +
> +Driver information can be obtained using ethtool, lspci, and ifconfig.
> +Instructions on updating ethtool can be found in the section Additional
> +Configurations later in this document.
> +
> +For questions related to hardware requirements, refer to the documentation
> +supplied with your Intel adapter. All hardware requirements listed apply to use
> +with Linux.
> +
> +NOTE: 1 Gb devices based on the Intel(R) Ethernet Network Connection X722 do
> +not support the following features:
> +  * Data Center Bridging (DCB)
> +  * QOS
> +  * VMQ
> +  * SR-IOV
> +  * Task Encapsulation offload (VXLAN, NVGRE)
> +  * Energy Efficient Ethernet (EEE)
> +  * Auto-media detect
>   
>   
>   Identifying Your Adapter
> -========================
> +------------------------
> +The driver in this release is compatible with devices based on the following:
> +  * Intel(R) Ethernet Controller X710
> +  * Intel(R) Ethernet Controller XL710
> +  * Intel(R) Ethernet Network Connection X722
> +  * Intel(R) Ethernet Controller XXV710
> +
> +For the best performance, make sure the latest NVM/FW is installed on your
> +device and that you are using the newest drivers.
> +
> +For information on how to identify your adapter, and for the latest NVM/FW
> +images and Intel network drivers, refer to the Intel Support website:
> +http://www.intel.com/support
> +
> +
> +SFP+ and QSFP+ Devices:
> +-----------------------
> +For information about supported media, refer to this document:
> +http://www.intel.com/content/dam/www/public/us/en/documents/release-notes/xl710-
> +ethernet-controller-feature-matrix.pdf
> +NOTE: Some adapters based on the Intel(R) Ethernet Controller 700 Series only
> +support Intel Ethernet Optics modules. On these adapters, other modules are not
> +supported and will not function.
> +
> +NOTE: For connections based on Intel(R) Ethernet Controller 700 Series, support
> +is dependent on your system board. Please see your vendor for details.
> +
> +NOTE:In all cases Intel recommends using Intel Ethernet Optics; other modules
> +may function but are not validated by Intel. Contact Intel for supported media
> +types.
> +
> +NOTE: In systems that do not have adequate airflow to cool the adapter and
> +optical modules, you must use high temperature optical modules.
> +
> +
> +================================================================================
> +
> +
> +Use sysfs to enable VFs. For example:
> +#echo $num_vf_enabled > /sys/class/net/$dev/device/sriov_numvfs	//enable
> +VFs
> +#echo 0 > /sys/class/net/$dev/device/sriov_numvfs	//disable VFs
> +
> +NOTE: Neither the device nor the driver control how VFs are mapped into config
> +space. Bus layout will vary by operating system. On operating systems that
> +support it, you can check sysfs to find the mapping.
> +Some hardware configurations support fewer SR-IOV instances, as the whole
> +XL710 controller (all functions) is limited to 128 SR-IOV interfaces in total.
> +NOTE: When SR-IOV mode is enabled, hardware VLAN
> +filtering and VLAN tag stripping/insertion will remain enabled. Please remove
> +the old VLAN filter before the new VLAN filter is added. For example,
> +ip link set eth0 vf 0 vlan 100	// set vlan 100 for VF 0
> +ip link set eth0 vf 0 vlan 0	// Delete vlan 100
> +ip link set eth0 vf 0 vlan 200	// set a new vlan 200 for VF 0
> +
> +
> +Configuring SR-IOV for improved network security
> +------------------------------------------------
> +In a virtualized environment, on Intel(R) Ethernet Server Adapters that support
> +SR-IOV, the virtual function (VF) may be subject to malicious behavior.
> +Software-generated layer two frames, like IEEE 802.3x (link flow control), IEEE
> +802.1Qbb (priority based flow-control), and others of this type, are not
> +expected and can throttle traffic between the host and the virtual switch,
> +reducing performance. To resolve this issue, configure all SR-IOV enabled ports
> +for VLAN tagging. This configuration allows unexpected, and potentially
> +malicious, frames to be dropped.
> +
> +
> +Configuring VLAN tagging on SR-IOV enabled adapter ports
> +--------------------------------------------------------
> +To configure VLAN tagging for the ports on an SR-IOV enabled adapter, use the
> +following command. The VLAN configuration should be done before the VF driver
> +is loaded or the VM is booted.
> +
> +$ ip link set dev <PF netdev id> vf <id> vlan <vlan id>
> +
> +For example, the following instructions will configure PF eth0 and the first VF
> +on VLAN 10.
> +$ ip link set dev eth0 vf 0 vlan 10
> +
> +
> +VLAN Tag Packet Steering
> +------------------------
> +Allows you to send all packets with a specific VLAN tag to a particular SR-IOV
> +virtual function (VF). Further, this feature allows you to designate a
> +particular VF as trusted, and allows that trusted VF to request selective
> +promiscuous mode on the Physical Function (PF).
> +
> +To set a VF as trusted or untrusted, enter the following command in the
> +Hypervisor:
> +  # ip link set dev eth0 vf 1 trust [on|off]
> +
> +Once the VF is designated as trusted, use the following commands in the VM to
> +set the VF to promiscuous mode.
> +  For promiscuous all:
> +  #ip link set eth2 promisc on
> +    Where eth2 is a VF interface in the VM
> +  For promiscuous Multicast:
> +  #ip link set eth2 allmulticast on
> +    Where eth2 is a VF interface in the VM
> +
> +NOTE: By default, the ethtool priv-flag vf-true-promisc-support is set to
> +"off",meaning that promiscuous mode for the VF will be limited. To set the
> +promiscuous mode for the VF to true promiscuous and allow the VF to see all
> +ingress traffic, use the following command.
> +  #ethtool -set-priv-flags p261p1 vf-true-promisc-support on
> +The vf-true-promisc-support priv-flag does not enable promiscuous mode; rather,
> +it designates which type of promiscuous mode (limited or true) you will get
> +when you enable promiscuous mode using the ip link commands above. Note that
> +this is a global setting that affects the entire device. However,the
> +vf-true-promisc-support priv-flag is only exposed to the first PF of the
> +device. The PF remains in limited promiscuous mode (unless it is in MFP mode)
> +regardless of the vf-true-promisc-support setting.
> +
> +Now add a VLAN interface on the VF interface.
> +  #ip link add link eth2 name eth2.100 type vlan id 100
> +
> +Note that the order in which you set the VF to promiscuous mode and add the
> +VLAN interface does not matter (you can do either first). The end result in
> +this example is that the VF will get all traffic that is tagged with VLAN 100.
> +
> +
> +Enabling a VF link if the port is disconnected
> +----------------------------------------------
> +If the physical function (PF) link is down, you can force link up (from the
> +host PF) on any virtual functions (VF) bound to the PF. Note that this requires
> +kernel support (Redhat kernel 3.10.0-327 or newer, upstream kernel 3.11.0 or
> +newer, and associated iproute2 user space support). If the following command
> +does not work, it may not be supported by your system. The following command
> +forces link up on VF 0 bound to PF eth0:
> +  ip link set eth0 vf 0 state enable
> +
> +
> +Do not unload port driver if VF with active VM is bound to it
> +-------------------------------------------------------------
> +Do not unload a port's driver if a Virtual Function (VF) with an active Virtual
> +Machine (VM) is bound to it. Doing so will cause the port to appear to hang.
> +Once the VM shuts down, or otherwise releases the VF, the command will complete.
> +
> +
> +Intel(R) Ethernet Flow Director
> +-------------------------------
> +The Intel Ethernet Flow Director performs the following tasks:
> +
> +- Directs receive packets according to their flows to different queues.
> +- Enables tight control on routing a flow in the platform.
> +- Matches flows and CPU cores for flow affinity.
> +- Supports multiple parameters for flexible flow classification and load
> +  balancing (in SFP mode only).
> +
> +NOTE: An included script (set_irq_affinity) automates setting the IRQ to CPU
> +affinity.
> +
> +NOTE: The Linux i40edriver supports the following flow types: IPv4, TCPv4, and

s/i40edriver/i40e driver/

> +UDPv4. For a given flow type, it supports valid combinations of IP addresses
> +(source or destination) and UDP/TCP ports (source and destination). For
> +example, you can supply only a source IP address, a source IP address and a
> +destination port, or any combination of one or more of these four parameters.
> +
> +NOTE: The Linux i40edriver allows you to filter traffic based on a user-defined

s/i40edriver/i40e driver/

> +flexible two-byte pattern and offset by using the ethtool user-def and mask
> +fields. Only L3 and L4 flow types are supported for user-defined flexible
> +filters. For a given flow type, you must clear all Intel Ethernet Flow Director
> +filters before changing the input set (for that flow type).
> +
> +ethtool commands:
> +
> +To enable or disable the Intel Ethernet Flow Director:
> +
> +  # ethtool -K ethX ntuple <on|off>
> +
> +When disabling ntuple filters, all the user programed filters are flushed from
> +the driver cache and hardware. All needed filters must be re-added when ntuple
> +is re-enabled.
> +
> +To add a filter that directs packet to queue 2, use -U or -N switch:
> +
> +  # ethtool -N ethX flow-type tcp4 src-ip 192.168.10.1 dst-ip \
> +  192.168.10.2 src-port 2000 dst-port 2001 action 2 [loc 1]
> +
> +To set a filter using only the source and destination IP address:
> +
> +  # ethtool -N ethX flow-type tcp4 src-ip 192.168.10.1 dst-ip \
> +  192.168.10.2 action 2 [loc 1]
> +
> +To set a filter based on a user defined pattern and offset:
> +
> +  # ethtool -N ethX flow-type tcp4 src-ip 192.168.10.1 dst-ip \
> +  192.168.10.2 user-def 0xffffffff00000001 m 0x40 action 2 [loc 1]
> +
> +  where the value of the user-def field (0xffffffff00000001) is the
> +  pattern and m 0x40 is the offset.
> +
> +Note that in this case the mask (m 0x40) parameter is used with the user-def
> +field, whereas for cloud filter support the mask parameter is not used.
> +
> +To see the list of filters currently present:
> +  # ethtool <-u|-n> ethX
> +
> +Application Targeted Routing (ATR) Perfect Filters
> +--------------------------------------------------
> +ATR is enabled by default when the kernel is in multiple transmit queue mode.
> +An ATR Intel Ethernet Flow Director filter rule is added when a TCP-IP flow
> +starts and is deleted when the flow ends. When a TCP-IP Intel Ethernet Flow
> +Director rule is added from ethtool (Sideband filter), ATR is turned off by the
> +driver. To re-enable ATR, the sideband can be disabled with the ethtool -K
> +option. If sideband is re-enabled after ATR is re-enabled, ATR remains enabled
> +until a TCP-IP flow is added. When all TCP-IP sideband rules are deleted, ATR
> +is automatically re-enabled.
> +
> +Packets that match the ATR rules are counted in fdir_atr_match stats in
> +ethtool, which also can be used to verify whether ATR rules still exist.
> +
> +Sideband Perfect Filters
> +------------------------
> +Sideband Perfect Filters are used to direct traffic that matches specified
> +characteristics. They are enabled through ethtool's ntuple interface. To add a
> +new filter use the following command:
> +  ethtool -U <device> flow-type <type> src-ip <ip> dst-ip <ip> src-port <port>
> +dst-port <port> action <queue>
> +Where:
> +  <device> - the ethernet device to program
> +  <type> - can be ip4, tcp4, udp4, or sctp4
> +  <ip> - the ip address to match on
> +  <port> - the port number to match on
> +  <queue> - the queue to direct traffic towards (-1 discards the matched
> +traffic)
> +Use the following command to display all of the active filters:
> +  ethtool -u <device>
> +Use the following command to delete a filter:
> +  ethtool -U <device> delete <N>
> +Where <N> is the filter id displayed when printing all the active filters, and
> +may also have been specified using "loc <N>" when adding the filter.
> +
> +The following example matches TCP traffic sent from 192.168.0.1, port 5300,
> +directed to 192.168.0.5, port 80, and sends it to queue 7:
> +  ethtool -U enp130s0 flow-type tcp4 src-ip 192.168.0.1 dst-ip 192.168.0.5
> +  src-port 5300 dst-port 7 action 7
> +
> +For each flow-type, the programmed filters must all have the same matching
> +input set. For example, issuing the following two commands is acceptable:
> +  ethtool -U enp130s0 flow-type ip4 src-ip 192.168.0.1 src-port 5300 action 7
> +  ethtool -U enp130s0 flow-type ip4 src-ip 192.168.0.5 src-port 55 action 10
> +Issuing the next two commands, however, is not acceptable, since the first
> +specifies src-ip and the second specifies dst-ip:
> +  ethtool -U enp130s0 flow-type ip4 src-ip 192.168.0.1 src-port 5300 action 7
> +  ethtool -U enp130s0 flow-type ip4 dst-ip 192.168.0.5 src-port 55 action 10
> +The second command will fail with an error. You may program multiple filters
> +with the same fields, using different values, but, on one device, you may not
> +program two tcp4 filters with different matching fields.
> +
> +Matching on a sub-portion of a field is not supported by the i40edriver, thus
> +partial mask fields are not supported.
> +
> +The driver also supports matching user-defined data within the packet payload.
> +This flexible data is specified using the "user-def" field of the ethtool
> +command in the following way:
> ++----------------------------+--------------------------+
> +| 31    28    24    20    16 | 15    12    8    4    0  |
> ++----------------------------+--------------------------+
> +| offset into packet payload | 2 bytes of flexible data |
> ++----------------------------+--------------------------+
> +
> +For example,
> +  ... user-def 0x4FFFF ...
> +
> +tells the filter to look 4 bytes into the payload and match that value against
> +0xFFFF. The offset is based on the beginning of the payload, and not the
> +beginning of the packet. Thus
> +
> +  flow-type tcp4 ... user-def 0x8BEAF ...
> +
> +would match TCP/IPv4 packets which have the value 0xBEAF 8 bytes into the
> +TCP/IPv4 payload.
> +
> +Note that ICMP headers are parsed as 4 bytes of header and 4 bytes of payload.
> +Thus to match the first byte of the payload, you must actually add 4 bytes to
> +the offset. Also note that ip4 filters match both ICMP frames as well as raw
> +(unknown) ip4 frames, where the payload will be the L3 payload of the IP4 frame.
> +
> +The maximum offset is 64. The hardware will only read up to 64 bytes of data
> +from the payload. The offset must be even because the flexible data is 2 bytes
> +long and must be aligned to byte 0 of the packet payload.
> +
> +The user-defined flexible offset is also considered part of the input set and
> +cannot be programmed separately for multiple filters of the same type. However,
> +the flexible data is not part of the input set and multiple filters may use the
> +same offset but match against different data.
> +
> +To create filters that direct traffic to a specific Virtual Function, use the
> +"action" parameter. Specify the action as a 64 bit value, where the lower 32
> +bits represents the queue number, while the next 8 bits represent which VF.
> +Note that 0 is the PF, so the VF identifier is offset by 1. For example:
> +
> +  ... action 0x800000002 ...
> +
> +specifies to direct traffic to Virtual Function 7 (8 minus 1) into queue 2 of
> +that VF.
> +
> +Note that these filters will not break internal routing rules, and will not
> +route traffic that otherwise would not have been sent to the specified Virtual
> +Function.
> +
> +
> +Additional Features and Configurations
> +-------------------------------------------
> +
> +
> +Setting the link-down-on-close Private Flag
> +-------------------------------------------
> +When the link-down-on-close private flag is set to "on", the port's link will
> +go down when the interface is brought down using the ifconfig ethX down command.
> +
> +Use ethtool to view and set link-down-on-close, as follows:
> +  ethtool --show-priv-flags ethX
> +  ethtool --set-priv-flags ethX link-down-on-close [on|off]
> +
> +
> +Viewing Link Messages
> +---------------------
> +Link messages will not be displayed to the console if the distribution is
> +restricting system messages. In order to see network driver link messages on
> +your console, set dmesg to eight by entering the following:
> +dmesg -n 8
> +
> +NOTE: This setting is not saved across reboots.
>   
> -The driver in this release is compatible with the Intel Ethernet
> -Controller XL710 Family.
>   
> -For more information on how to identify your adapter, go to the Adapter &
> -Driver ID Guide at:
> +Jumbo Frames
> +------------
> +Jumbo Frames support is enabled by changing the Maximum Transmission Unit (MTU)
> +to a value larger than the default value of 1500.
>   
> -    http://support.intel.com/support/network/sb/CS-012904.htm
> +Use the ifconfig command to increase the MTU size. For example, enter the
> +following where <x> is the interface number:
>   
> +   ifconfig eth<x> mtu 9000 up
> +Alternatively, you can use the ip command as follows:
> +   ip link set mtu 9000 dev eth<x>
> +   ip link set up dev eth<x>
>   
> -Enabling the driver
> -===================
> +This setting is not saved across reboots. The setting change can be made
> +permanent by adding 'MTU=9000' to the file:
> +/etc/sysconfig/network-scripts/ifcfg-eth<x> for RHEL or to the file
> +/etc/sysconfig/network/<config_file> for SLES.
>   
> -The driver is enabled via the standard kernel configuration system,
> -using the make command:
> +NOTE: The maximum MTU setting for Jumbo Frames is 9702. This value coincides
> +with the maximum Jumbo Frames size of 9728 bytes.
>   
> -     Make oldconfig/silentoldconfig/menuconfig/etc.
> +NOTE: This driver will attempt to use multiple page sized buffers to receive
> +each jumbo packet. This should help to avoid buffer starvation issues when
> +allocating receive packets.
>   
> -The driver is located in the menu structure at:
>   
> -	-> Device Drivers
> -	  -> Network device support (NETDEVICES [=y])
> -	    -> Ethernet driver support
> -	      -> Intel devices
> -	        -> Intel(R) Ethernet Controller XL710 Family
> +ethtool
> +-------
> +The driver utilizes the ethtool interface for driver configuration and
> +diagnostics, as well as displaying statistical information. The latest ethtool
> +version is required for this functionality. Download it at:
> +http://ftp.kernel.org/pub/software/network/ethtool/
>   
> -Additional Configurations
> -=========================
> +Supported ethtool Commands and Options for Filtering
> +----------------------------------------------------
> +-n --show-nfc
> +  Retrieves the receive network flow classification configurations.
>   
> -  Generic Receive Offload (GRO)
> -  -----------------------------
> -  The driver supports the in-kernel software implementation of GRO.  GRO has
> -  shown that by coalescing Rx traffic into larger chunks of data, CPU
> -  utilization can be significantly reduced when under large Rx load.  GRO is
> -  an evolution of the previously-used LRO interface.  GRO is able to coalesce
> -  other protocols besides TCP.  It's also safe to use with configurations that
> -  are problematic for LRO, namely bridging and iSCSI.
> +rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|tcp6|udp6|ah6|esp6|sctp6
> +  Retrieves the hash options for the specified network traffic type.
>   
> -  Ethtool
> -  -------
> -  The driver utilizes the ethtool interface for driver configuration and
> -  diagnostics, as well as displaying statistical information. The latest
> -  ethtool version is required for this functionality.
> +-N --config-nfc
> +  Configures the receive network flow classification.
>   
> -  The latest release of ethtool can be found from
> -  https://www.kernel.org/pub/software/network/ethtool
> +rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|tcp6|udp6|ah6|esp6|sctp6
> +m|v|t|s|d|f|n|r...
> +  Configures the hash options for the specified network traffic type.
>   
> +  udp4 UDP over IPv4
> +  udp6 UDP over IPv6
>   
> -  Flow Director n-ntuple traffic filters (FDir)
> -  ---------------------------------------------
> -  The driver utilizes the ethtool interface for configuring ntuple filters,
> -  via "ethtool -N <device> <filter>".
> +  f Hash on bytes 0 and 1 of the Layer 4 header of the rx packet.
> +  n Hash on bytes 2 and 3 of the Layer 4 header of the rx packet.
>   
> -  The sctp4, ip4, udp4, and tcp4 flow types are supported with the standard
> -  fields including src-ip, dst-ip, src-port and dst-port. The driver only
> -  supports fully enabling or fully masking the fields, so use of the mask
> -  fields for partial matches is not supported.
>   
> -  Additionally, the driver supports using the action to specify filters for a
> -  Virtual Function. You can specify the action as a 64bit value, where the
> -  lower 32 bits represents the queue number, while the next 8 bits represent
> -  which VF. Note that 0 is the PF, so the VF identifier is offset by 1. For
> -  example:
> +Speed and Duplex Configuration
> +------------------------------
> +In addressing speed and duplex configuration issues, you need to distinguish
> +between copper-based adapters and fiber-based adapters.
>   
> -    ... action 0x800000002 ...
> +In the default mode, an Intel(R) Ethernet Network Adapter using copper
> +connections will attempt to auto-negotiate with its link partner to determine
> +the best setting. If the adapter cannot establish link with the link partner
> +using auto-negotiation, you may need to manually configure the adapter and link
> +partner to identical settings to establish link and pass packets. This should
> +only be needed when attempting to link with an older switch that does not
> +support auto-negotiation or one that has been forced to a specific speed or
> +duplex mode. Your link partner must match the setting you choose. 1 Gbps speeds
> +and higher cannot be forced. Use the autonegotiation advertising setting to
> +manually set devices for 1 Gbps and higher.
>   
> -  Would indicate to direct traffic for Virtual Function 7 (8 minus 1) on queue
> -  2 of that VF.
> +NOTE: You cannot set the speed for devices based on the Intel(R) Ethernet
> +Network Adapter XXV710 based devices.
>   
> -  The driver also supports using the user-defined field to specify 2 bytes of
> -  arbitrary data to match within the packet payload in addition to the regular
> -  fields. The data is specified in the lower 32bits of the user-def field in
> -  the following way:
> +Speed, duplex, and autonegotiation advertising are configured through the
> +ethtool* utility. ethtool is included with all versions of Red Hat after Red
> +Hat 7.2. For the latest version, download and install ethtool from the
> +following website:
>   
> -  +----------------------------+---------------------------+
> -  | 31    28    24    20    16 | 15    12     8     4     0|
> -  +----------------------------+---------------------------+
> -  | offset into packet payload |  2 bytes of flexible data |
> -  +----------------------------+---------------------------+
> +   http://ftp.kernel.org/pub/software/network/ethtool/
>   
> -  As an example,
> +Caution: Only experienced network administrators should force speed and duplex
> +or change autonegotiation advertising manually. The settings at the switch must
> +always match the adapter settings. Adapter performance may suffer or your
> +adapter may not operate if you configure the adapter differently from your
> +switch.
>   
> -    ... user-def 0x4FFFF ....
> +An Intel(R) Ethernet Network Adapter using fiber-based connections, however,
> +will not attempt to auto-negotiate with its link partner since those adapters
> +operate only in full duplex and only at their native speed.
>   
> -  means to match the value 0xFFFF 4 bytes into the packet payload. Note that
> -  the offset is based on the beginning of the payload, and not the beginning
> -  of the packet. Thus
>   
> -    flow-type tcp4 ... user-def 0x8BEAF ....
> +NAPI
> +----
> +NAPI (Rx polling mode) is supported in the i40e driver.
> +For more information on NAPI, see
> +https://www.linuxfoundation.org/collaborate/workgroups/networking/napi
>   
> -  would match TCP/IPv4 packets which have the value 0xBEAF 8bytes into the
> -  TCP/IPv4 payload.
>   
> -  For ICMP, the hardware parses the ICMP header as 4 bytes of header and 4
> -  bytes of payload, so if you want to match an ICMP frames payload you may need
> -  to add 4 to the offset in order to match the data.
> +Flow Control
> +------------
> +Ethernet Flow Control (IEEE 802.3x) can be configured with ethtool to enable
> +receiving and transmitting pause frames for i40e. When transmit is enabled,
> +pause frames are generated when the receive packet buffer crosses a predefined
> +threshold. When receive is enabled, the transmit unit will halt for the time
> +delay specified when a pause frame is received.
>   
> -  Furthermore, the offset can only be up to a value of 64, as the hardware
> -  will only read up to 64 bytes of data from the payload. It must also be even
> -  as the flexible data is 2 bytes long and must be aligned to byte 0 of the
> -  packet payload.
> +NOTE: You must have a flow control capable link partner.
>   
> -  When programming filters, the hardware is limited to using a single input
> -  set for each flow type. This means that it is an error to program two
> -  different filters with the same type that don't match on the same fields.
> -  Thus the second of the following two commands will fail:
> +Flow Control is  by default.
>   
> -    ethtool -N <device> flow-type tcp4 src-ip 192.168.0.7 action 5
> -    ethtool -N <device> flow-type tcp4 dst-ip 192.168.15.18 action 1
> +Use ethtool to change the flow control settings.
>   
> -  This is because the first filter will be accepted and reprogram the input
> -  set for TCPv4 filters, but the second filter will be unable to reprogram the
> -  input set until all the conflicting TCPv4 filters are first removed.
> +To enable or disable rx or tx Flow Control:
> +ethtool -A eth? rx <on|off> tx <on|off>
> +Note: This command only enables or disables Flow Control if auto-negotiation is
> +disabled. If auto-negotiation is enabled, this command changes the parameters
> +used for auto-negotiation with the link partner.
>   
> -  Note that the user-defined flexible offset is also considered part of the
> -  input set and cannot be programmed separately for multiple filters of the
> -  same type. However, the flexible data is not part of the input set and
> -  multiple filters may use the same offset but match against different data.
> +To enable or disable auto-negotiation:
> +ethtool -s eth? autoneg <on|off>
> +Note: Flow Control auto-negotiation is part of link auto-negotiation. Depending
> +on your device, you may not be able to change the auto-negotiation setting.
>   
> -  Data Center Bridging (DCB)
> -  --------------------------
> -  DCB configuration is not currently supported.
>   
> -  FCoE
> -  ----
> -  The driver supports Fiber Channel over Ethernet (FCoE) and Data Center
> -  Bridging (DCB) functionality. Configuring DCB and FCoE is outside the scope
> -  of this driver doc. Refer to http://www.open-fcoe.org/ for FCoE project
> -  information and http://www.open-lldp.org/ or email list
> -  e1000-eedc at lists.sourceforge.net for DCB information.
> +RSS Hash Flow
> +-------------
>   
> -  MAC and VLAN anti-spoofing feature
> -  ----------------------------------
> -  When a malicious driver attempts to send a spoofed packet, it is dropped by
> -  the hardware and not transmitted.  An interrupt is sent to the PF driver
> -  notifying it of the spoof attempt.
> +Allows you to set the hash bytes per flow type and any combination of one or
> +more options for Receive Side Scaling (RSS) hash byte configuration.
>   
> -  When a spoofed packet is detected the PF driver will send the following
> -  message to the system log (displayed by  the "dmesg" command):
> +#ethtool -N <dev> rx-flow-hash <type> <option>
>   
> -  Spoof event(s) detected on VF (n)
> +Where <type> is:
> +  tcp4	signifying TCP over IPv4
> +  udp4	signifying UDP over IPv4
> +  tcp6	signifying TCP over IPv6
> +  udp6	signifying UDP over IPv6
> +And <option> is one or more of:
> +  s	Hash on the IP source address of the rx packet.
> +  d	Hash on the IP destination address of the rx packet.
> +  f	Hash on bytes 0 and 1 of the Layer 4 header of the rx packet.
> +  n	Hash on bytes 2 and 3 of the Layer 4 header of the rx packet.
>   
> -  Where n=the VF that attempted to do the spoofing.
>   
> +MAC and VLAN anti-spoofing feature
> +----------------------------------
>   
> -Performance Tuning
> -==================
> +When a malicious driver attempts to send a spoofed packet, it is dropped by the
> +hardware and not transmitted.
> +NOTE: This feature can be disabled for a specific Virtual Function (VF):
> +ip link set <pf dev> vf <vf id> spoofchk {off|on}
>   
> -An excellent article on performance tuning can be found at:
>   
> -http://www.redhat.com/promo/summit/2008/downloads/pdf/Thursday/Mark_Wagner.pdf
> +IEEE 1588 Precision Time Protocol (PTP) Hardware Clock (PHC)
> +------------------------------------------------------------
>   
> +Precision Time Protocol (PTP) is used to synchronize clocks in a computer
> +network. PTP support varies among Intel devices that support this driver. Use
> +"ethtool -T <netdev name>" to get a definitive list of PTP capabilities
> +supported by the device.
>   
> -Known Issues
> -============
>   
>   
> -Support
> -=======
> +IEEE 802.1ad (QinQ)?Support
> +---------------------------
>   
> -For general information, go to the Intel support website at:
> +The IEEE 802.1ad standard, informally known as QinQ, allows for multiple VLAN
> +IDs within a single Ethernet frame. VLAN IDs are sometimes referred to as
> +"tags," and multiple VLAN IDs are thus referred to as a "tag stack." Tag stacks
> +allow L2 tunneling and the ability to segregate traffic within a particular
> +VLAN ID, among other uses.
> +
> +The following are examples of how to configure 802.1ad (QinQ):
> +  ip link add link eth0 eth0.24 type vlan proto 802.1ad id 24
> +  ip link add link eth0.24 eth0.24.371 type vlan proto 802.1Q id 371
> +Where "24" and "371" are example VLAN IDs.
> +
> +NOTES:
> +- 802.1ad (QinQ)is supported in 3.19 and later kernels.
> +- Receive checksum offloads, cloud filters, and VLAN acceleration are not
> +supported for 802.1ad (QinQ) packets.
> +
> +
> +VXLAN and GENEVE Overlay HW Offloading
> +--------------------------------------
> +
> +Virtual Extensible LAN (VXLAN) allows you to extend an L2 network over an L3
> +network, which may be useful in a virtualized or cloud environment. Some
> +Intel(R) Ethernet Network devices perform VXLAN processing, offloading it from
> +the operating system. This reduces CPU utilization.
> +
> +VXLAN offloading is controlled by the tx and rx checksum offload options
> +provided by ethtool. That is, if tx checksum offload is enabled, and the
> +adapter has the capability, VXLAN offloading is also enabled.
> +
> +Support for VXLAN and GENEVE HW offloading is dependent on kernel support of
> +the HW offloading features.
> +
> +
> +Multiple Functions per Port
> +---------------------------
> +
> +Some adapters based on the Intel Ethernet Controller X710/XL710 support
> +multiple functions on a single physical port. Configure these functions through
> +the System Setup/BIOS.
> +
> +Minimum TX Bandwidth is the guaranteed minimum data transmission bandwidth, as
> +a percentage of the full physical port link speed, that the partition will
> +receive. The bandwidth the partition is awarded will never fall below the level
> +you specify.
> +
> +The range for the minimum bandwidth values is:
> +1 to ((100 minus # of partitions on the physical port) plus 1)
> +For example, if a physical port has 4 partitions, the range would be:
> +1 to ((100 - 4) + 1 = 97)
> +
> +The Maximum Bandwidth percentage represents the maximum transmit bandwidth
> +allocated to the partition as a percentage of the full physical port link
> +speed. The accepted range of values is 1-100. The value is used as a limiter,
> +should you chose that any one particular function not be able to consume 100%
> +of a port's bandwidth (should it be available). The sum of all the values for
> +Maximum Bandwidth is not restricted, because no more than 100% of a port's
> +bandwidth can ever be used.
> +
> +NOTE:?X710/XXV710 devices fail to enable Max VFs (64) when Multiple Functions
> +per Port (MFP)?and SR-IOV are enabled. An error from i40e is logged that says
> +"add vsi failed for VF N, aq_err 16". To workaround the issue, enable less than
> +64 virtual functions (VFs).
> +
> +
> +Data Center Bridging (DCB)
> +--------------------------
> +
> +NOTE:
> +The kernel assumes that TC0 is available, and will disable Priority Flow
> +Control (PFC) on the device if TC0 is not available. To fix this, ensure TC0 is
> +enabled when setting up DCB on your switch.
> +
> +
> +DCB is a configuration Quality of Service implementation in hardware. It uses
> +the VLAN priority tag (802.1p) to filter traffic. That means that there are 8
> +different priorities that traffic can be filtered into. It also enables
> +priority flow control (802.1Qbb) which can limit or eliminate the number of
> +dropped packets during network stress. Bandwidth can be allocated to each of
> +these priorities, which is enforced at the hardware level (802.1Qaz).
> +
> +Adapter firmware implements LLDP and DCBX protocol agents as per 802.1AB and
> +802.1Qaz respectively. The firmware based DCBX agent runs in willing mode only
> +and can accept settings from a DCBX capable peer. Software configuration of
> +DCBX parameters via dcbtool/lldptool are not supported.
> +
> +NOTE: Firmware LLDP can be disabled by setting the private flag disable-fw-lldp.
> +
> +The i40e driver implements the DCB netlink interface layer to allow user-space
> +to communicate with the driver and query DCB configuration for the port.
> +
> +
> +Interrupt Rate Limiting
> +-----------------------
> +
> +The Intel(R) Ethernet Controller XL710 family supports an interrupt rate
> +limiting mechanism. The user can control, via ethtool, the number of
> +microseconds between interrupts.
> +
> +Syntax:
> +# ethtool -C ethX rx-usecs-high N
> +
> +Valid Range: 0-235 (0=no limit)
> +
> +The range of 0-235 microseconds provides an effective range of 4,310 to 250,000
> +interrupts per second. The value of rx-usecs-high can be set independently of
> +rx-usecs and tx-usecs in the same ethtool command, and is also independent of
> +the adaptive interrupt moderation algorithm. The underlying hardware supports
> +granularity in 4-microsecond intervals, so adjacent values may result in the
> +same interrupt rate.
> +
> +One possible use case is the following:
> +# ethtool -C ethX adaptive-rx off adaptive-tx off rx-usecs-high 20 rx-usecs 5
> +tx-usecs 5
> +
> +The above command would disable adaptive interrupt moderation, and allow a
> +maximum of 5 microseconds before indicating a receive or transmit was complete.
> +However, instead of resulting in as many as 200,000 interrupts per second, it
> +limits total interrupts per second to 50,000 via the rx-usecs-high parameter.
> +
> +
> +Performance Optimization:
> +-------------------------
> +
> +Driver defaults are meant to fit a wide variety of workloads, but if further
> +optimization is required we recommend experimenting with the following settings.
> +
> +NOTE: For better performance when processing small (64B) frame sizes, try
> +enabling Hyper threading in the BIOS in order to increase the number of logical
> +cores in the system and subsequently increase the number of queues available to
> +the adapter.
>   
> -    http://support.intel.com
> +Virtualized Environments:
> +
> +1. Disable XPS on both ends by using the included virt_perf_default script
> +  or by running the following command as root:
> +  for file in `ls /sys/class/net/<ethX>/queues/tx-*/xps_cpus`;
> +  do echo 0 > $file; done
> +
> +2. Using the appropriate mechanism (vcpupin) in the vm, pin the cpu's to
> +  individual lcpu's, making sure to use a set of cpu's included in the
> +  device's local_cpulist: /sys/class/net/<ethX>/device/local_cpulist.
> +
> +3. Configure as many rx/tx queues in the VM as available. Do not rely on
> +  the default setting of 1.
> +
> +
> +Non-virtualized Environments
> +
> +Pin the adapter's IRQs to specific cores by disabling the irqbalance service
> +and using the included set_irq_affinity script. Please see the script's help
> +text for further options.
> +
> +  - The following settings will distribute the IRQs across all the cores
> +    evenly:
> +
> +    # scripts/set_irq_affinity -x all <interface1> , [ <interface2>, ... ]
> +
> +  - The following settings will distribute the IRQs across all the cores that
> +    are local to the adapter (same NUMA node):
> +
> +    # scripts/set_irq_affinity -x local <interface1> ,[ <interface2>, ... ]
> +
> +For very CPU intensive workloads, we recommend pinning the IRQs to all cores.
> +
> +For IP Forwarding: Disable Adaptive ITR and lower rx and tx interrupts per
> +queue using ethtool.
> +
> +  - Setting rx-usecs and tx-usecs to 125 will limit interrupts to about 8000
> +    interrupts per second per queue.
> +
> +    # ethtool -C <interface> adaptive-rx off adaptive-tx off rx-usecs 125
> +    tx-usecs 125
> +
> +For lower CPU utilization: Disable Adaptive ITR and lower rx and tx interrupts
> +per queue using ethtool.
> +
> +  - Setting rx-usecs and tx-usecs to 250 will limit interrupts to about 4000
> +    interrupts per second per queue.
> +
> +    # ethtool -C <interface> adaptive-rx off adaptive-tx off rx-usecs 250
> +    tx-usecs 250
> +
> +For lower latency: Disable Adaptive ITR and ITR by setting rx and tx to 0 using
> +ethtool.
> +
> +    # ethtool -C <interface> adaptive-rx off adaptive-tx off rx-usecs 0
> +    tx-usecs 0
> +
> +
> +Application Device Queues (ADq)
> +-------------------------------
> +
> +Application Device Queues (ADq) allows you to dedicate one or more queues to a
> +specific application. This can reduce latency for the specified application,
> +and allow Tx traffic to be rate limited per application. Follow the steps below
> +to set ADq.
> +
> +NOTE: Run all tc commands from the iproute2 <pathtoiproute2>/tc/ directory.
> +  1. Create traffic classes (TCs). Maximum of 8 TCs can be created per
> +  interface. The shaper bw_rlimit parameter is optional.
> +  Example:
> +  Sets up two tcs, tc0 and tc1, with 16 queues each and max tx rate set
> +  to 1Gbit for tc0 and 3Gbit for tc1.
> +  # tc qdisc add dev <interface> root mqprio num_tc 2 map 0 0 0 0 1 1 1 1
> +  queues 16 at 0 16 at 16 hw 1 mode channel shaper bw_rlimit min_rate 1Gbit 2Gbit
> +  max_rate 1Gbit 3Gbit
> +
> +  map: priority mapping for up to 16 priorities to tcs
> +  (e.g. map 0 0 0 0 1 1 1 1 sets priorities 0-3 to use tc0 and 4-7 to
> +  use tc1)
> +
> +  queues: for each tc, <num queues>@<offset> (e.g. queues 16 at 0 16 at 16 assigns
> +  16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
> +  number of queues for all tcs is 64 or number of cores, whichever is
> +  lower.)
> +
> +  hw 1 mode channel: ?channel? with ?hw? set to 1 is a new new hardware
> +  offload mode in mqprio that makes full use of the mqprio options, the
> +  TCs, the queue configurations, and the QoS parameters.
> +
> +  shaper bw_rlimit: for each tc, sets minimum and maximum bandwidth rates.
> +  Totals must be equal or less than port speed.
> +  For example: min_rate 1Gbit 3Gbit:
> +  Verify bandwidth limit using network monitoring tools such as ifstat
> +  or sar ?n DEV [interval] [number of samples]
> +
> +NOTE: Setting up channels via ethtool (ethtool -L) is not supported when the
> +TCs are configured using mqprio.
> +
> +  2. Enable HW TC offload on interface:
> +  # ethtool -K <interface> hw-tc-offload on
> +  3. Apply TCs to ingress (RX) flow of interface:
> +  # tc qdisc add dev <interface> ingress
> +NOTES:
> +- You must have kernel version 4.15 or later and the sch_mqprio, act_mirred
> +  and cls_flower modules loaded to set ADq
> +- You must have iproute2 latest version
> +- NVM version 6.01 or later is required.
> +- ADq cannot be enabled when any the following features are enabled: Data
> +  Center Bridging (DCB), Multiple Functions per Port (MFP), or Sideband
> +  Filters.
> +- If another driver (for example, DPDK) has set cloud filters, you cannot
> +  enable ADq.
> +
> +
> +================================================================================
> +
> +
> +Support
> +-------
> +For general information, go to the Intel support website at:
> +www.intel.com/support/
>   
>   or the Intel Wired Networking project hosted by Sourceforge at:
> +http://sourceforge.net/projects/e1000
> +If an issue is identified with the released source code on a supported kernel
> +with a supported adapter, email the specific information related to the issue
> +to e1000-devel at lists.sf.net.
> +
> +
> +================================================================================
> +
> +
> +License
> +-------
> +This program is free software; you can redistribute it and/or modify it under
> +the terms and conditions of the GNU General Public License, version 2, as
> +published by the Free Software Foundation.
> +
> +This program is distributed in the hope it will be useful, but WITHOUT ANY
> +WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
> +PARTICULAR PURPOSE. See the GNU General Public License for more details.
> +
> +You should have received a copy of the GNU General Public License along with
> +this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
> +St - Fifth Floor, Boston, MA 02110-1301 USA.
> +
> +The full GNU General Public License is included in this distribution in the
> +file called "COPYING".
> +
> +Copyright(c) 1999-2017 Intel Corporation.

Okay, so I guess you're putting the copyright here at the end.  Can you 
be consistent with all the files?

> +================================================================================
> +
> +
> +Trademarks
> +----------
> +Intel and Itanium are trademarks or registered trademarks of Intel Corporation
> +or its subsidiaries in the United States and/or other countries.
> +
> +* Other names and brands may be claimed as the property of others.
>   
> -    http://e1000.sourceforge.net
>   
> -If an issue is identified with the released source code on the supported
> -kernel with a supported adapter, email the specific information related
> -to the issue to e1000-devel at lists.sourceforge.net and copy
> -netdev at vger.kernel.org.
> diff --git a/Documentation/networking/i40evf.txt b/Documentation/networking/i40evf.txt
> index e9b3035b95d0..5bfef8791387 100644
> --- a/Documentation/networking/i40evf.txt
> +++ b/Documentation/networking/i40evf.txt
> @@ -1,54 +1,346 @@
> -Linux* Base Driver for Intel(R) Network Connection
> -==================================================
> +Linux* Driver for Intel(R) Ethernet Virtual Function 700 Series
> +======================================================
>   
> -Intel Ethernet Adaptive Virtual Function Linux driver.
> -Copyright(c) 2013-2017 Intel Corporation.
> +November 28, 2017

2018?

> +
> +======================================================
>   
>   Contents
>   ========
> -
> -- Identifying Your Adapter
> -- Known Issues/Troubleshooting
> +- Overview
> +- Additional Configurations
> +- Known Issues
>   - Support
> +- License
> +
> +================================================================================
> +
> +
> +This driver supports XL710- and X710-based virtual function devices
> +with CONFIG_PCI_IOV enabled.
> +
> +SR-IOV requires the correct platform and OS support.
>   
> -This file describes the i40evf Linux* Base Driver.
> +The guest OS loading this driver must support MSI-X interrupts.
>   
> -The i40evf driver supports the below mentioned virtual function
> -devices and can only be activated on kernels running the i40e or
> -newer Physical Function (PF) driver compiled with CONFIG_PCI_IOV.
> -The i40evf driver requires CONFIG_PCI_MSI to be enabled.
> +For questions related to hardware requirements, refer to the documentation
> +supplied with your Intel adapter. All hardware requirements listed apply to use
> +with Linux.
> +
> +Driver information can be obtained using ethtool, lspci, and ifconfig.
> +Instructions on updating ethtool can be found in the section Additional
> +Configurations later in this document.
> +
> +The i40evf driver supports virtual functions generated by the i40e driver,
> +with one or more VFs enabled through sysfs.
>   
> -The guest OS loading the i40evf driver must support MSI-X interrupts.
>   
> -Supported Hardware
> -==================
> -Intel XL710 X710 Virtual Function
> -Intel Ethernet Adaptive Virtual Function
> -Intel X722 Virtual Function
>   
>   Identifying Your Adapter
> -========================
> +------------------------
> +The driver in this release is compatible with devices based on the following:
> +  * Intel(R) Ethernet Controller X710
> +  * Intel(R) Ethernet Controller XL710
> +  * Intel(R) Ethernet Network Connection X722
> +  * Intel(R) Ethernet Controller XXV710
> +
> +For the best performance, make sure the latest NVM/FW is installed on your
> +device and that you are using the newest drivers.
> +
> +For information on how to identify your adapter, and for the latest NVM/FW
> +images and Intel network drivers, refer to the Intel Support website:
> +http://www.intel.com/support
> +
> +
> +Additional Features and Configurations
> +-------------------------------------------
> +
> +
> +Viewing Link Messages
> +---------------------
> +Link messages will not be displayed to the console if the distribution is
> +restricting system messages. In order to see network driver link messages on
> +your console, set dmesg to eight by entering the following:
> +dmesg -n 8
> +
> +NOTE: This setting is not saved across reboots.
> +
> +
> +ethtool
> +-------
> +The driver utilizes the ethtool interface for driver configuration and
> +diagnostics, as well as displaying statistical information. The latest ethtool
> +version is required for this functionality. Download it at:
> +http://ftp.kernel.org/pub/software/network/ethtool/
> +
> +
> +Setting VLAN Tag Stripping
> +--------------------------
> +
> +If you have applications that require Virtual Functions (VFs) to receive
> +packets with VLAN tags, you can disable VLAN tag stripping for the VF. The
> +Physical Function (PF) processes requests issued from the VF to enable or
> +disable VLAN tag stripping. Note that if the PF has assigned a VLAN to a VF,
> +then requests from that VF to set VLAN tag stripping will be ignored.
> +
> +To enable/disable VLAN tag stripping for a VF, issue the following command
> +from inside the VM in which you are running the VF:
> +  ethtool -K <if_name> rxvlan on/off
> +  or alternatively:
> +  ethtool --offload <if_name> rxvlan on/off
>   
> -For more information on how to identify your adapter, go to the
> -Adapter & Driver ID Guide at:
>   
> -    http://support.intel.com/support/go/network/adapter/idguide.htm
> +Adaptive Virtual Function
> +-------------------------
> +Adaptive Virtual Function (AVF) allows the virtual function driver, or VF, to
> +adapt to changing feature sets of the physical function driver (PF) with which
> +it is associated. This allows system administrators to update a PF without
> +having to update all the VFs associated with it. All AVFs have a single common
> +device ID and branding string.
> +
> +AVFs have a minimum set of features known as "base mode," but may provide
> +additional features depending on what features are available in the PF with
> +which the AVF is associated. The following are base mode features:
> +
> +- 4 Queue Pairs (QP) and associated Configuration Status Registers (CSRs)
> +  for Tx/Rx.
> +- i40e descriptors and ring format.
> +- Descriptor write-back completion.
> +- 1 control queue, with i40e descriptors, CSRs and ring format.
> +- 5 MSI-X interrupt vectors and corresponding i40e CSRs.
> +- 1 Interrupt Throttle Rate (ITR) index.
> +- 1 Virtual Station Interface (VSI) per VF.
> +- 1 Traffic Class (TC), TC0
> +- Receive Side Scaling (RSS) with 64 entry indirection table and key,
> +  configured through the PF.
> +- 1 unicast MAC address reserved per VF.
> +- 16 MAC address filters for each VF.
> +- Stateless offloads - non-tunneled checksums.
> +- AVF device ID.
> +- HW mailbox is used for VF to PF communications (including on Windows).
> +
> +
> +IEEE 802.1ad (QinQ)?Support
> +---------------------------
> +
> +The IEEE 802.1ad standard, informally known as QinQ, allows for multiple VLAN
> +IDs within a single Ethernet frame. VLAN IDs are sometimes referred to as
> +"tags," and multiple VLAN IDs are thus referred to as a "tag stack." Tag stacks
> +allow L2 tunneling and the ability to segregate traffic within a particular
> +VLAN ID, among other uses.
> +
> +The following are examples of how to configure 802.1ad (QinQ):
> +  ip link add link eth0 eth0.24 type vlan proto 802.1ad id 24
> +  ip link add link eth0.24 eth0.24.371 type vlan proto 802.1Q id 371
> +Where "24" and "371" are example VLAN IDs.
> +
> +NOTES:
> +- 802.1ad (QinQ)is supported in 3.19 and later kernels.
> +- Receive checksum offloads, cloud filters, and VLAN acceleration are not
> +supported for 802.1ad (QinQ) packets.
> +
> +
> +Application Device Queues (ADq)
> +-------------------------------
> +
> +Application Device Queues (ADq) allows you to dedicate one or more queues to a
> +specific application. This can reduce latency for the specified application,
> +and allow Tx traffic to be rate limited per application. Follow the steps below
> +to set ADq.
> +
> +NOTE: Run all tc commands from the iproute2 <pathtoiproute2>/tc/ directory.
> +  1. Create traffic classes (TCs). Maximum of 8 TCs can be created per
> +  interface. The shaper bw_rlimit parameter is optional.
> +  Example:
> +  Sets up two tcs, tc0 and tc1, with 16 queues each and max tx rate set
> +  to 1Gbit for tc0 and 3Gbit for tc1.
> +  # tc qdisc add dev <interface> root mqprio num_tc 2 map 0 0 0 0 1 1 1 1
> +  queues 16 at 0 16 at 16 hw 1 mode channel shaper bw_rlimit min_rate 1Gbit 2Gbit
> +  max_rate 1Gbit 3Gbit
> +
> +  map: priority mapping for up to 16 priorities to tcs
> +  (e.g. map 0 0 0 0 1 1 1 1 sets priorities 0-3 to use tc0 and 4-7 to
> +  use tc1)
> +
> +  queues: for each tc, <num queues>@<offset> (e.g. queues 16 at 0 16 at 16 assigns
> +  16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
> +  number of queues for all tcs is 64 or number of cores, whichever is
> +  lower.)
> +
> +  hw 1 mode channel: ?channel? with ?hw? set to 1 is a new new hardware
> +  offload mode in mqprio that makes full use of the mqprio options, the
> +  TCs, the queue configurations, and the QoS parameters.
> +
> +  shaper bw_rlimit: for each tc, sets minimum and maximum bandwidth rates.
> +  Totals must be equal or less than port speed.
> +  For example: min_rate 1Gbit 3Gbit:
> +  Verify bandwidth limit using network monitoring tools such as ifstat
> +  or sar ?n DEV [interval] [number of samples]
> +
> +NOTE: Setting up channels via ethtool (ethtool -L) is not supported when the
> +TCs are configured using mqprio.
> +
> +  2. Enable HW TC offload on interface:
> +  # ethtool -K <interface> hw-tc-offload on
> +  3. Apply TCs to ingress (RX) flow of interface:
> +  # tc qdisc add dev <interface> ingress
> +NOTES:
> +- You must have kernel version 4.15 or later and the sch_mqprio, act_mirred
> +  and cls_flower modules loaded to set ADq
> +- You must have iproute2 latest version
> +- NVM version 6.01 or later is required.
> +- ADq cannot be enabled when any the following features are enabled: Data
> +  Center Bridging (DCB), Multiple Functions per Port (MFP), or Sideband
> +  Filters.
> +- If another driver (for example, DPDK) has set cloud filters, you cannot
> +  enable ADq.
> +
> +
> +================================================================================
> +
>   
>   Known Issues/Troubleshooting
> -============================
> +----------------------------
>   
>   
> -Support
> -=======
> +Traffic Is Not Being Passed Between VM and Client
> +-------------------------------------------------
> +You may not be able to pass traffic between a client system and a
> +Virtual Machine (VM) running on a separate host if the Virtual Function
> +(VF, or Virtual NIC) is not in trusted mode and spoof checking is enabled
> +on the VF. Note that this situation can occur in any combination of client,
> +host, and guest operating system. For information on how to set the VF to
> +trusted mode, refer to the section "VLAN Tag Packet Steering" in this
> +readme document. For information on setting spoof checking, refer to the
> +section "MAC and VLAN anti-spoofing feature" in this readme document.
>   
> -For general information, go to the Intel support website at:
>   
> -    http://support.intel.com
> +Do not unload port driver if VF with active VM is bound to it
> +-------------------------------------------------------------
> +Do not unload a port's driver if a Virtual Function (VF) with an active Virtual
> +Machine (VM) is bound to it. Doing so will cause the port to appear to hang.
> +Once the VM shuts down, or otherwise releases the VF, the command will complete.
> +
> +
> +Virtual machine does not get link
> +---------------------------------
> +If the virtual machine has more than one virtual port assigned to it, and those
> +virtual ports are bound to different physical ports, you may not get link on
> +all of the virtual ports. The following command may work around the issue:
> +ethtool -r <PF>
> +Where <PF> is the PF interface in the host, for example: p5p1. You may need to
> +run the command more than once to get link on all virtual ports.
> +
> +
> +MAC address of Virtual Function changes unexpectedly
> +----------------------------------------------------
> +If a Virtual Function's MAC address is not assigned in the host, then the VF
> +(virtual function) driver will use a random MAC address. This random MAC
> +address may change each time the VF driver is reloaded. You can assign a static
> +MAC address in the host machine. This static MAC address will survive
> +a VF driver reload.
> +
> +
> +Hardware Issues
> +---------------
> +
> +For known hardware and troubleshooting issues, either refer to the "Release
> +Notes" in your User Guide, or for more detailed information, go to
> +http://www.intel.com.
> +
> +In the search box enter your devices controller ID followed by "spec update"
> +(i.e., XL710 spec update). The specification update file has complete
> +information on known hardware issues.
> +
> +
> +Software Issues
> +---------------
> +
> +NOTE: After installing the driver, if your Intel Ethernet Network Connection
> +is not working, verify that you have installed the correct driver.
> +
> +
> +Driver Buffer Overflow Fix
> +--------------------------
> +The fix to resolve CVE-2016-8105, referenced in Intel SA-00069
> +<https://security-center.intel.com/advisory.aspx?intelid=INTEL-SA-00069&language
> +id=en-fr>, is included in this and future versions of the driver.
> +
> +
> +Multiple Interfaces on Same Ethernet Broadcast Network
> +------------------------------------------------------
> +Due to the default ARP behavior on Linux, it is not possible to have one system
> +on two IP networks in the same Ethernet broadcast domain (non-partitioned
> +switch) behave as expected. All Ethernet interfaces will respond to IP traffic
> +for any IP address assigned to the system. This results in unbalanced receive
> +traffic.
> +
> +If you have multiple interfaces in a server, either turn on ARP filtering by
> +entering:
> +echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
> +
> +This only works if your kernel's version is higher than 2.4.5.

I doubt this driver can be built on anything 2.4, so perhaps this 
comment is unnecessary?

> +
> +
> +NOTE: This setting is not saved across reboots. The configuration change can be
> +made permanent by adding the following line to the file /etc/sysctl.conf:
> +net.ipv4.conf.all.arp_filter = 1
> +
> +Another alternative is to install the interfaces in separate broadcast domains
> +(either in different switches or in a switch partitioned to VLANs).
> +
> +
> +Rx Page Allocation Errors
> +-------------------------
> +'Page allocation failure. order:0' errors may occur under stress.
> +This is caused by the way the Linux kernel reports this stressed condition.
> +
> +
> +
> +================================================================================
> +
> +
> +Support
> +-------
> +For general information, go to the Intel support website at:
> +www.intel.com/support/
>   
>   or the Intel Wired Networking project hosted by Sourceforge at:
> +http://sourceforge.net/projects/e1000
> +If an issue is identified with the released source code on a supported kernel
> +with a supported adapter, email the specific information related to the issue
> +to e1000-devel at lists.sf.net.
> +
> +
> +================================================================================
> +
> +
> +License
> +-------
> +This program is free software; you can redistribute it and/or modify it under
> +the terms and conditions of the GNU General Public License, version 2, as
> +published by the Free Software Foundation.
> +
> +This program is distributed in the hope it will be useful, but WITHOUT ANY
> +WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
> +PARTICULAR PURPOSE. See the GNU General Public License for more details.
> +
> +You should have received a copy of the GNU General Public License along with
> +this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
> +St - Fifth Floor, Boston, MA 02110-1301 USA.
> +
> +The full GNU General Public License is included in this distribution in the
> +file called "COPYING".
> +
> +Copyright(c) 2014-2017 Intel Corporation.

2018?

> +================================================================================
> +
> +
> +Trademarks
> +----------
> +Intel and Itanium are trademarks or registered trademarks of Intel Corporation
> +or its subsidiaries in the United States and/or other countries.
> +
> +* Other names and brands may be claimed as the property of others.
>   
> -    http://sourceforge.net/projects/e1000
>   
> -If an issue is identified with the released source code on the supported
> -kernel with a supported adapter, email the specific information related
> -to the issue to e1000-devel at lists.sf.net
> diff --git a/Documentation/networking/igb.txt b/Documentation/networking/igb.txt
> index f90643ef39c9..c9a5cf93bb0b 100644
> --- a/Documentation/networking/igb.txt
> +++ b/Documentation/networking/igb.txt
> @@ -2,7 +2,7 @@ Linux* Base Driver for Intel(R) Ethernet Network Connection
>   ===========================================================
>   
>   Intel Gigabit Linux driver.
> -Copyright(c) 1999 - 2013 Intel Corporation.
> +Copyright(c) 1999-2017 Intel Corporation.

2018?

>   
>   Contents
>   ========
> @@ -12,118 +12,250 @@ Contents
>   - Support
>   
>   Identifying Your Adapter
> -========================
> +------------------------
> +This release includes two gigabit FreeBSD base Drivers for Intel(R) Ethernet.
> +These drivers are em and igb.
>   
> -This driver supports all 82575, 82576 and 82580-based Intel (R) gigabit network
> -connections.
> +- The igb driver supports all 82575 and 82576-based gigabit network connections.
> +- The em driver supports all other gigabit network connections.
> +- Gigabit devices base on the Intel(R) Ethernet Controller X722 are supported by
> +  the i40e ixl driver.
>   
> -For specific information on how to identify your adapter, go to the Adapter &
> -Driver ID Guide at:
> +For information on how to identify your adapter, and for the latest Intel
> +network drivers, refer to the Intel Support website:
> +http://www.intel.com/support
>   
> -    http://support.intel.com/support/go/network/adapter/idguide.htm
>   
>   Command Line Parameters
> -=======================
> -
> +-----------------------
> +If the driver is built as a module, the following optional parameters are used
> +by entering them on the command line with the modprobe command using this
> +syntax:
> +modprobe igb [<option>=<VAL1>,<VAL2>,...]
> +
> +There needs to be a <VAL#> for each network port in the system supported by
> +this driver. The values will be applied to each instance, in function order.
> +For example:
> +modprobe igb InterruptThrottleRate=16000,16000

Is this even still supported?  Maybe in the SourceForge version, but 
probably not in the kernel driver.

> +
> +In this case, there are two network ports supported by igb in the system.
>   The default value for each parameter is generally the recommended setting,
>   unless otherwise noted.
>   
> +NOTE: For more information about the command line parameters, see the
> +application note at: http://www.intel.com/design/network/applnots/ap450.htm.
> +
> +NOTE: A descriptor describes a data buffer and attributes related to the data
> +buffer. This information is accessed by the hardware.
> +
> +
>   max_vfs
>   -------
> -Valid Range:   0-7
> -Default Value: 0
> +This parameter adds support for SR-IOV. It causes the driver to spawn up to
> +max_vfs worth of virtual functions.
> +Valid Range: 0-7
> +If the value is greater than 0 it will also force the VMDq parameter to be 1 or
> +more.
> +
> +The parameters for the driver are referenced by position. Thus, if you have a
> +dual port adapter, or more than one adapter in your system, and want N virtual
> +functions per port, you must specify a number for each port with each parameter
> +separated by a comma. For example:
> +
> +  modprobe igb max_vfs=4
> +
> +This will spawn 4 VFs on the first port.
> +
> +  modprobe igb max_vfs=2,4
> +
> +This will spawn 2 VFs on the first port and 4 VFs on the second port.
> +
> +NOTE: Caution must be used in loading the driver with these parameters.
> +Depending on your system configuration, number of slots, etc., it is impossible
> +to predict in all cases where the positions would be on the command line.
> +
> +NOTE: Neither the device nor the driver control how VFs are mapped into config
> +space. Bus layout will vary by operating system. On operating systems that
> +support it, you can check sysfs to find the mapping.
> +
> +
> +NOTE: When either SR-IOV mode or VMDq mode is enabled, hardware VLAN filtering
> +and VLAN tag stripping/insertion will remain enabled. Please remove the old
> +VLAN filter before the new VLAN filter is added. For example,
> +ip link set eth0 vf 0 vlan 100	// set vlan 100 for VF 0
> +ip link set eth0 vf 0 vlan 0	// Delete vlan 100
> +ip link set eth0 vf 0 vlan 200	// set a new vlan 200 for VF 0
> +
> +
> +QueuePairs
> +----------
> +Valid Range: 0-1
> +If set to 0, when MSI-X is enabled, the Tx and Rx will attempt to occupy
> +separate vectors.
> +This option can be overridden to 1 if there are not sufficient interrupts
> +available. This can occur if any combination of RSS, VMDQ, and max_vfs results
> +in more than 4 queues being used.
> +
> +
> +Node
> +----
> +Valid Range: 0-n
> +0 - n: where n is the number of the NUMA node that should be used to allocate
> +memory for this adapter port.
> +-1: uses the driver default of allocating memory on whichever processor is
> +running modprobe.
> +The Node parameter allows you to choose which NUMA node you want to have the
> +adapter allocate memory from. All driver structures, in-memory queues, and
> +receive buffers will be allocated on the node specified. This parameter is
> +only useful when interrupt affinity is specified; otherwise, part of the
> +interrupt time could run on a different core than where the memory is
> +allocated causing slower memory access and impacting throughput, CPU, or both.
> +
> +
> +EEE
> +---
> +Valid Range: 0-1
> +0 = Disables EEE
> +1 = Enables EEE
> +A link between two EEE-compliant devices will result in periodic bursts of
> +data followed by periods where the link is in an idle state. This Low Power
> +Idle (LPI) state is supported in both 1 Gbps and 100 Mbps link speeds.
>   
> -This parameter adds support for SR-IOV.  It causes the driver to spawn up to
> -max_vfs worth of virtual function.
>   
> -Additional Configurations
> -=========================
>   
> -  Jumbo Frames
> -  ------------
> -  Jumbo Frames support is enabled by changing the MTU to a value larger than
> -  the default of 1500.  Use the ip command to increase the MTU size.
> -  For example:
> +DMAC
> +----
> +Valid Range: 0, 1, 250, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000,
> +9000, 10000
> +This parameter enables or disables DMA Coalescing feature. Values are in
> +microseconds and set the internal DMA Coalescing internal timer.
> +DMA (Direct Memory Access) allows the network device to move packet data
> +directly to the system's memory, reducing CPU utilization. However, the
> +frequency and random intervals at which packets arrive do not allow the
> +system to enter a lower power state. DMA Coalescing allows the adapter
> +to collect packets before it initiates a DMA event. This may increase
> +network latency but also increases the chances that the system will enter
> +a lower power state.
> +Turning on DMA Coalescing may save energy with kernel 2.6.32 and newer.
> +DMA Coalescing must be enabled across all active ports in order to save
> +platform power.
>   
> -       ip link set dev eth<x> mtu 9000
>   
> -  This setting is not saved across reboots.
> +Additional Features and Configurations
> +-------------------------------------------
>   
> -  Notes:
>   
> -  - The maximum MTU setting for Jumbo Frames is 9216.  This value coincides
> -    with the maximum Jumbo Frames size of 9234 bytes.
> +Jumbo Frames
> +------------
> +Jumbo Frames support is enabled by changing the Maximum Transmission Unit (MTU)
> +to a value larger than the default value of 1500.
>   
> -  - Using Jumbo frames at 10 or 100 Mbps is not supported and may result in
> -    poor performance or loss of link.
> +Use the ifconfig command to increase the MTU size. For example, enter the
> +following where <x> is the interface number:
>   
> -  ethtool
> -  -------
> -  The driver utilizes the ethtool interface for driver configuration and
> -  diagnostics, as well as displaying statistical information. The latest
> -  version of ethtool can be found at:
> +   ifconfig eth<x> mtu 9000 up
> +Alternatively, you can use the ip command as follows:
> +   ip link set mtu 9000 dev eth<x>
> +   ip link set up dev eth<x>
>   
> -  https://www.kernel.org/pub/software/network/ethtool/
> +To confirm an interface's MTU value, use the ifconfig command.

Since most folks are trying to convert to the iproute2 commands, can we 
replace the ifconfig references?

>   
> -  Enabling Wake on LAN* (WoL)
> -  ---------------------------
> -  WoL is configured through the ethtool* utility.
> +To confirm the MTU used between two specific devices, use:
>   
> -  For instructions on enabling WoL with ethtool, refer to the ethtool man page.
> +   route get <destination_IP_address>
>   
> -  WoL will be enabled on the system during the next shut down or reboot.
> -  For this driver version, in order to enable WoL, the igb driver must be
> -  loaded when shutting down or rebooting the system.
> +This setting is not saved across reboots. The setting change can be made
> +permanent by adding 'MTU=9000' to the file:
> +/etc/sysconfig/network-scripts/ifcfg-eth<x> for RHEL or to the file
> +/etc/sysconfig/network/<config_file> for SLES.
>   
> -  Wake On LAN is only supported on port A of multi-port adapters.
> +NOTE: The maximum MTU setting for Jumbo Frames is 9216. This value coincides
> +with the maximum Jumbo Frames size of 9234 bytes.
>   
> -  Wake On LAN is not supported for the Intel(R) Gigabit VT Quad Port Server
> +NOTE: Using Jumbo frames at 10 or 100 Mbps is not supported and may result in
> +poor performance or loss of link.
> +
> +
> +ethtool
> +-------
> +The driver utilizes the ethtool interface for driver configuration and
> +diagnostics, as well as displaying statistical information. The latest ethtool
> +version is required for this functionality. Download it at:
> +http://ftp.kernel.org/pub/software/network/ethtool/
> +
> +
> +Enabling Wake on LAN* (WoL)
> +---------------------------
> +
> +WoL is configured through the ethtool* utility. ethtool is included with all
> +versions of Red Hat after Red Hat 7.2. For other Linux distributions, download
> +and install ethtool from the following website:
> +http://ftp.kernel.org/pub/software/network/ethtool/.
> +
> +For instructions on enabling WoL with ethtool, refer to the website listed
> +above.
> +
> +WoL will be enabled on the system during the next shut down or reboot. For
> +this driver version, in order to enable WoL, the igb driver must be loaded
> +prior to shutting down or suspending the system.
> +
> +NOTES:
> +- Wake on LAN is only supported on port A of multi-port devices.
> +- Wake On LAN is not supported for the Intel(R) Gigabit VT Quad Port Server
>     Adapter.
>   
> -  Multiqueue
> -  ----------
> -  In this mode, a separate MSI-X vector is allocated for each queue and one
> -  for "other" interrupts such as link status change and errors.  All
> -  interrupts are throttled via interrupt moderation.  Interrupt moderation
> -  must be used to avoid interrupt storms while the driver is processing one
> -  interrupt.  The moderation value should be at least as large as the expected
> -  time for the driver to process an interrupt. Multiqueue is off by default.
>   
> -  REQUIREMENTS: MSI-X support is required for Multiqueue. If MSI-X is not
> -  found, the system will fallback to MSI or to Legacy interrupts.
> +Multiqueue
> +----------
> +In this mode, a separate MSI-X vector is allocated for each queue and one for
> +"other" interrupts such as link status change and errors. All interrupts are
> +throttled via interrupt moderation. Interrupt moderation must be used to avoid
> +interrupt storms while the driver is processing one interrupt. The moderation
> +value should be at least as large as the expected time for the driver to
> +process an interrupt. Multiqueue is off by default.
>   
> -  MAC and VLAN anti-spoofing feature
> -  ----------------------------------
> -  When a malicious driver attempts to send a spoofed packet, it is dropped by
> -  the hardware and not transmitted.  An interrupt is sent to the PF driver
> -  notifying it of the spoof attempt.
> +REQUIREMENTS: MSI-X support is required for Multiqueue. If MSI-X is not found,
> +the system will fallback to MSI or to Legacy interrupts. This driver supports
> +multiqueue in kernel versions 2.6.24 and newer. This driver supports receive
> +multiqueue on all kernels that support MSI-X.
>   
> -  When a spoofed packet is detected the PF driver will send the following
> -  message to the system log (displayed by  the "dmesg" command):
> +NOTES:
> +- Do not use MSI-X with the 2.6.19 or 2.6.20 kernels.
> +- On some kernels a reboot is required to switch between single queue mode
> +and multiqueue mode or vice-versa.
>   
> -  Spoof event(s) detected on VF(n)
>   
> -  Where n=the VF that attempted to do the spoofing.
> +MAC and VLAN anti-spoofing feature
> +----------------------------------
>   
> -  Setting MAC Address, VLAN and Rate Limit Using IProute2 Tool
> -  ------------------------------------------------------------
> -  You can set a MAC address of a Virtual Function (VF), a default VLAN and the
> -  rate limit using the IProute2 tool. Download the latest version of the
> -  iproute2 tool from Sourceforge if your version does not have all the
> -  features you require.
> +When a malicious driver attempts to send a spoofed packet, it is dropped by the
> +hardware and not transmitted.
>   
> +An interrupt is sent to the PF driver notifying it of the spoof attempt. When a
> +spoofed packet is detected, the PF driver will send the following message to
> +the system log (displayed by the "dmesg" command):
> +Spoof event(s) detected on VF(n), where n = the VF that attempted to do the
> +spoofing
>   
> -Support
> -=======
>   
> -For general information, go to the Intel support website at:
>   
> -    www.intel.com/support/
> +Setting MAC Address, VLAN and Rate Limit Using IProute2 Tool
> +------------------------------------------------------------
> +You can set a MAC address of a Virtual Function (VF), a default VLAN and the
> +rate limit using the IProute2 tool. Download the latest version of the
> +IProute2 tool from Sourceforge if your version does not have all the features
> +you require.

You can not find the latest iproute2 on sourceforge.  If you get lucky 
and search hard enough, you might find it over on kernel.org.

> +
> +
> +Support
> +-------
> +For general information, go to the Intel support website at:
> +www.intel.com/support/
>   
>   or the Intel Wired Networking project hosted by Sourceforge at:
> +http://sourceforge.net/projects/e1000
> +If an issue is identified with the released source code on a supported kernel
> +with a supported adapter, email the specific information related to the issue
> +to e1000-devel at lists.sf.net.freebsdnic@mailbox.intel.com
>   
> -    http://sourceforge.net/projects/e1000
>   
> -If an issue is identified with the released source code on the supported
> -kernel with a supported adapter, email the specific information related
> -to the issue to e1000-devel at lists.sf.net
> diff --git a/Documentation/networking/igbvf.txt b/Documentation/networking/igbvf.txt
> index bd404735fb46..9b284dd15a8c 100644
> --- a/Documentation/networking/igbvf.txt
> +++ b/Documentation/networking/igbvf.txt
> @@ -2,79 +2,67 @@ Linux* Base Driver for Intel(R) Ethernet Network Connection
>   ===========================================================
>   
>   Intel Gigabit Linux driver.
> -Copyright(c) 1999 - 2013 Intel Corporation.
> +Copyright(c) 1999-2015 Intel Corporation.

2018

>   
>   Contents
>   ========
> -
>   - Identifying Your Adapter
>   - Additional Configurations
>   - Support
>   
> -This file describes the igbvf Linux* Base Driver for Intel Network Connection.
> +This virtual function driver supports kernel versions default_kernel_version.
>   
> -The igbvf driver supports 82576-based virtual function devices that can only
> -be activated on kernels that support SR-IOV. SR-IOV requires the correct
> -platform and OS support.
> +This driver supports default_hw_family-based virtual function devices
> +that can only be activated on kernels that support SR-IOV.
>   
> -The igbvf driver requires the igb driver, version 2.0 or later. The igbvf
> -driver supports virtual functions generated by the igb driver with a max_vfs
> -value of 1 or greater. For more information on the max_vfs parameter refer
> -to the README included with the igb driver.
> +SR-IOV requires the correct platform and OS support.
>   
> -The guest OS loading the igbvf driver must support MSI-X interrupts.
> +The guest OS loading this driver must support MSI-X interrupts.
>   
> -This driver is only supported as a loadable module at this time.  Intel is
> -not supplying patches against the kernel source to allow for static linking
> -of the driver.  For questions related to hardware requirements, refer to the
> -documentation supplied with your Intel Gigabit adapter.  All hardware
> -requirements listed apply to use with Linux.
> +This driver is only supported as a loadable module at this time. Intel is not
> +supplying patches against the kernel source to allow for static linking of the
> +drivers.
>   
> -Instructions on updating ethtool can be found in the section "Additional
> -Configurations" later in this document.
> +For questions related to hardware requirements, refer to the documentation
> +supplied with your Intel adapter. All hardware requirements listed apply to use
> +with Linux.
>   
> -VLANs: There is a limit of a total of 32 shared VLANs to 1 or more VFs.
> +Driver information can be obtained using variable_value_undefined. Instructions
> +on updating ethtool can be found in the section Additional Configurations later
> +in this document.
>   
> -Identifying Your Adapter
> -========================
> +VLANs: There is a limit of a total of 32 shared VLANs to 1 or more VFs.
>   
> -The igbvf driver supports 82576-based virtual function devices that can only
> -be activated on kernels that support SR-IOV.
>   
> -For more information on how to identify your adapter, go to the Adapter &
> -Driver ID Guide at:
>   
> -    http://support.intel.com/support/go/network/adapter/idguide.htm
> +Identifying Your Adapter
> +------------------------
> +For information on how to identify your adapter, and for the latest Intel
> +network drivers, refer to the Intel Support website:
> +http://www.intel.com/support
>   
> -For the latest Intel network drivers for Linux, refer to the following
> -website.  In the search field, enter your adapter name or type, or use the
> -networking link on the left to search for your adapter:
>   
> -    http://downloadcenter.intel.com/scripts-df-external/Support_Intel.aspx
> +Additional Features and Configurations
> +-------------------------------------------
>   
> -Additional Configurations
> -=========================
>   
> -  ethtool
> -  -------
> -  The driver utilizes the ethtool interface for driver configuration and
> -  diagnostics, as well as displaying statistical information.  The ethtool
> -  version 3.0 or later is required for this functionality, although we
> -  strongly recommend downloading the latest version at:
> +ethtool
> +-------
> +The driver utilizes the ethtool interface for driver configuration and
> +diagnostics, as well as displaying statistical information. The latest ethtool
> +version is required for this functionality. Download it at:
> +http://ftp.kernel.org/pub/software/network/ethtool/
>   
> -  https://www.kernel.org/pub/software/network/ethtool/
>   
>   Support
> -=======
> -
> +-------
>   For general information, go to the Intel support website at:
> -
> -    http://support.intel.com
> +www.intel.com/support/
>   
>   or the Intel Wired Networking project hosted by Sourceforge at:
> +http://sourceforge.net/projects/e1000
> +If an issue is identified with the released source code on a supported kernel
> +with a supported adapter, email the specific information related to the issue
> +to e1000-devel at lists.sf.net.
>   
> -    http://sourceforge.net/projects/e1000
>   
> -If an issue is identified with the released source code on the supported
> -kernel with a supported adapter, email the specific information related
> -to the issue to e1000-devel at lists.sf.net
> diff --git a/Documentation/networking/ixgbe.txt b/Documentation/networking/ixgbe.txt
> index 687835415707..db64a7ad2987 100644
> --- a/Documentation/networking/ixgbe.txt
> +++ b/Documentation/networking/ixgbe.txt
> @@ -2,12 +2,12 @@ Linux* Base Driver for the Intel(R) Ethernet 10 Gigabit PCI Express Family of
>   Adapters
>   =============================================================================
>   
> +February 23, 2017
>   Intel 10 Gigabit Linux driver.
> -Copyright(c) 1999 - 2013 Intel Corporation.
> +Copyright(c) 1999-2017 Intel Corporation.

2018

>   
>   Contents
>   ========
> -
>   - Identifying Your Adapter
>   - Additional Configurations
>   - Performance Tuning
> @@ -15,335 +15,489 @@ Contents
>   - Support
>   
>   Identifying Your Adapter
> -========================
> -
> -The driver in this release is compatible with 82598, 82599 and X540-based
> -Intel Network Connections.
> +------------------------
> +The driver is compatible with devices based on the following:
> +  * Intel(R) Ethernet Controller 82598
> +  * Intel(R) Ethernet Controller 82599
> +  * Intel(R) Ethernet Controller X540
> +  * Intel(R) Ethernet Controller x550
> +  * Intel(R) Ethernet Controller X552
> +  * Intel(R) Ethernet Controller X553
>   
> -For more information on how to identify your adapter, go to the Adapter &
> -Driver ID Guide at:
> +For information on how to identify your adapter, and for the latest Intel
> +network drivers, refer to the Intel Support website:
> +http://www.intel.com/support
>   
> -    http://support.intel.com/support/network/sb/CS-012904.htm
>   
>   SFP+ Devices with Pluggable Optics
>   ----------------------------------
>   
>   82599-BASED ADAPTERS
> +--------------------
> +
> +NOTES:
> +- If your 82599-based Intel(R) Network Adapter came with Intel optics or is an
> +  Intel(R) Ethernet Server Adapter X520-2, then it only supports Intel optics
> +  and/or the direct attach cables listed below.
> +- When 82599-based SFP+ devices are connected back to back, they should be
> +  set to the same Speed setting via ethtool. Results may vary if you mix
> +  speed settings.
> +
> +Supplier	Type					Part Numbers
> +--------	----					------------
> +SR Modules
> +Intel		DUAL RATE 1G/10G SFP+ SR (bailed)	FTLX8571D3BCV-IT
> +Intel		DUAL RATE 1G/10G SFP+ SR (bailed)	AFBR-703SDZ-IN2
> +Intel		DUAL RATE 1G/10G SFP+ SR (bailed)	AFBR-703SDDZ-IN1
> +LR Modules
> +Intel		DUAL RATE 1G/10G SFP+ LR (bailed)	FTLX1471D3BCV-IT
> +Intel		DUAL RATE 1G/10G SFP+ LR (bailed)	AFCT-701SDZ-IN2
> +Intel		DUAL RATE 1G/10G SFP+ LR (bailed)	AFCT-701SDDZ-IN1
> +
> +The following is a list of 3rd party SFP+ modules that have received some
> +testing. Not all modules are applicable to all devices.
> +
> +Supplier	Type					Part Numbers
> +--------	----					------------
> +Finisar		SFP+ SR bailed, 10g single
> +rate		FTLX8571D3BCL
> +Avago		SFP+ SR bailed, 10g single rate		AFBR-700SDZ
> +Finisar		SFP+ LR bailed, 10g single
> +rate		FTLX1471D3BCL
> +Finisar		DUAL RATE 1G/10G SFP+ SR (No
> +Bail)	FTLX8571D3QCV-IT
> +Avago		DUAL RATE 1G/10G SFP+ SR (No Bail)	AFBR-703SDZ-IN1
> +Finisar		DUAL RATE 1G/10G SFP+ LR (No
> +Bail)	FTLX1471D3QCV-IT
> +Avago		DUAL RATE 1G/10G SFP+ LR (No Bail)	AFCT-701SDZ-IN1
> +
> +Finisar		1000BASE-T
> +SFP				FCLF8522P2BTL
> +Avago		1000BASE-T				ABCU-5710RZ
> +HP		1000BASE-SX SFP				453153-001
>   
> -NOTES: If your 82599-based Intel(R) Network Adapter came with Intel optics, or
> -is an Intel(R) Ethernet Server Adapter X520-2, then it only supports Intel
> -optics and/or the direct attach cables listed below.
> +82599-based adapters support all passive and active limiting direct attach
> +cables that comply with SFF-8431 v4.1 and SFF-8472 v10.4 specifications.
>   
> -When 82599-based SFP+ devices are connected back to back, they should be set to
> -the same Speed setting via ethtool. Results may vary if you mix speed settings.
> -82598-based adapters support all passive direct attach cables that comply
> -with SFF-8431 v4.1 and SFF-8472 v10.4 specifications. Active direct attach
> -cables are not supported.
>   
> -Supplier    Type                                             Part Numbers
> +Laser turns off for SFP+ when ifconfig ethX down
> +------------------------------------------------
>   
> -SR Modules
> -Intel       DUAL RATE 1G/10G SFP+ SR (bailed)                FTLX8571D3BCV-IT
> -Intel       DUAL RATE 1G/10G SFP+ SR (bailed)                AFBR-703SDDZ-IN1
> -Intel       DUAL RATE 1G/10G SFP+ SR (bailed)                AFBR-703SDZ-IN2
> -LR Modules
> -Intel       DUAL RATE 1G/10G SFP+ LR (bailed)                FTLX1471D3BCV-IT
> -Intel       DUAL RATE 1G/10G SFP+ LR (bailed)                AFCT-701SDDZ-IN1
> -Intel       DUAL RATE 1G/10G SFP+ LR (bailed)                AFCT-701SDZ-IN2
> +"ifconfig ethX down" turns off the laser for 82599-based SFP+ fiber adapters.
> +"ifconfig ethX up" turns on the laser.
> +Alternatively, you can use "ip link set [down/up] dev ethX" to turn the
> +laser off and on.
>   
> -The following is a list of 3rd party SFP+ modules and direct attach cables that
> -have received some testing. Not all modules are applicable to all devices.
>   
> -Supplier   Type                                              Part Numbers
> +82599-based QSFP+ Adapters
> +--------------------------
>   
> -Finisar    SFP+ SR bailed, 10g single rate                   FTLX8571D3BCL
> -Avago      SFP+ SR bailed, 10g single rate                   AFBR-700SDZ
> -Finisar    SFP+ LR bailed, 10g single rate                   FTLX1471D3BCL
> +NOTES:
> +- If your 82599-based Intel(R) Network Adapter came with Intel optics, it
> +  only supports Intel optics.
> +- 82599-based QSFP+ adapters only support 4x10 Gbps connections.
> +  1x40 Gbps connections are not supported. QSFP+ link partners must be
> +  configured for 4x10 Gbps.
> +- 82599-based QSFP+ adapters do not support automatic link speed detection.
> +  The link speed must be configured to either 10 Gbps or 1 Gbps to match the
> +  link partners speed capabilities. Incorrect speed configurations will result
> +  in failure to link.
> +- Intel(R) Ethernet Converged Network Adapter X520-Q1 only supports the
> +  optics and direct attach cables listed below.
>   
> -Finisar    DUAL RATE 1G/10G SFP+ SR (No Bail)                FTLX8571D3QCV-IT
> -Avago      DUAL RATE 1G/10G SFP+ SR (No Bail)                AFBR-703SDZ-IN1
> -Finisar    DUAL RATE 1G/10G SFP+ LR (No Bail)                FTLX1471D3QCV-IT
> -Avago      DUAL RATE 1G/10G SFP+ LR (No Bail)                AFCT-701SDZ-IN1
> -Finistar   1000BASE-T SFP                                    FCLF8522P2BTL
> -Avago      1000BASE-T SFP                                    ABCU-5710RZ
>   
> -82599-based adapters support all passive and active limiting direct attach
> -cables that comply with SFF-8431 v4.1 and SFF-8472 v10.4 specifications.
> +Supplier	Type				Part Numbers
> +--------	----				------------
> +Intel	DUAL RATE 1G/10G QSFP+ SRL (bailed)	E10GQSFPSR
>   
> -Laser turns off for SFP+ when device is down
> --------------------------------------------
> -"ip link set down" turns off the laser for 82599-based SFP+ fiber adapters.
> -"ip link set up" turns on the laser.
> +82599-based QSFP+ adapters support all passive and active limiting QSFP+
> +direct attach cables that comply with SFF-8436 v4.1 specifications.
>   
>   
>   82598-BASED ADAPTERS
> +--------------------
>   
> -NOTES for 82598-Based Adapters:
> -- Intel(R) Network Adapters that support removable optical modules only support
> -  their original module type (i.e., the Intel(R) 10 Gigabit SR Dual Port
> -  Express Module only supports SR optical modules). If you plug in a different
> -  type of module, the driver will not load.
> +NOTES:
> +- Intel(r) Ethernet Network Adapters that support removable optical modules
> +  only support their original module type (for example, the Intel(R) 10 Gigabit
> +  SR Dual Port Express Module only supports SR optical modules). If you plug
> +  in a different type of module, the driver will not load.
>   - Hot Swapping/hot plugging optical modules is not supported.
>   - Only single speed, 10 gigabit modules are supported.
>   - LAN on Motherboard (LOMs) may support DA, SR, or LR modules. Other module
>     types are not supported. Please see your system documentation for details.
>   
> -The following is a list of 3rd party SFP+ modules and direct attach cables that
> -have received some testing. Not all modules are applicable to all devices.
> -
> -Supplier   Type                                              Part Numbers
> -
> -Finisar    SFP+ SR bailed, 10g single rate                   FTLX8571D3BCL
> -Avago      SFP+ SR bailed, 10g single rate                   AFBR-700SDZ
> -Finisar    SFP+ LR bailed, 10g single rate                   FTLX1471D3BCL
> -
> -82598-based adapters support all passive direct attach cables that comply
> -with SFF-8431 v4.1 and SFF-8472 v10.4 specifications. Active direct attach
> -cables are not supported.
> +  The following is a list of SFP+ modules and direct attach cables that have
> +  received some testing. Not all modules are applicable to all devices.
> +
> +Supplier	Type					Part Numbers
> +--------	----					------------
> +Finisar		SFP+ SR bailed, 10g single
> +rate		FTLX8571D3BCL
> +Avago		SFP+ SR bailed, 10g single rate		AFBR-700SDZ
> +Finisar		SFP+ LR bailed, 10g single
> +rate		FTLX1471D3BCL
> +
> +82598-based adapters support all passive direct attach cables that comply with
> +SFF-8431 v4.1 and SFF-8472 v10.4 specifications. Active direct attach cables
> +are not supported.
> +
> +Third party optic modules and cables referred to above are listed only for the
> +purpose of highlighting third party specifications and potential
> +compatibility, and are not recommendations or endorsements or sponsorship of
> +any third party's product by Intel. Intel is not endorsing or promoting
> +products made by any third party and the third party reference is provided
> +only to share information regarding certain optic modules and cables with the
> +above specifications. There may be other manufacturers or suppliers, producing
> +or supplying optic modules and cables with similar or matching descriptions.
> +Customers must use their own discretion and diligence to purchase optic
> +modules and cables from any third party of their choice. Customers are solely
> +responsible for assessing the suitability of the product and/or devices and
> +for the selection of the vendor for purchasing any product. THE OPTIC MODULES
> +AND CABLES REFERRED TO ABOVE ARE NOT WARRANTED OR SUPPORTED BY INTEL. INTEL
> +ASSUMES NO LIABILITY WHATSOEVER, AND INTEL DISCLAIMS ANY EXPRESS OR IMPLIED
> +WARRANTY, RELATING TO SALE AND/OR USE OF SUCH THIRD PARTY PRODUCTS OR
> +SELECTION OF VENDOR BY CUSTOMERS.
>   
>   
>   Flow Control
>   ------------
>   Ethernet Flow Control (IEEE 802.3x) can be configured with ethtool to enable
> -receiving and transmitting pause frames for ixgbe. When TX is enabled, PAUSE
> -frames are generated when the receive packet buffer crosses a predefined
> -threshold.  When rx is enabled, the transmit unit will halt for the time delay
> -specified when a PAUSE frame is received.
> +receiving and transmitting pause frames for ixgbe. When transmit is enabled,
> +pause frames are generated when the receive packet buffer crosses a predefined
> +threshold. When receive is enabled, the transmit unit will halt for the time
> +delay specified when a pause frame is received.
> +
> +NOTE: You must have a flow control capable link partner.
> +
> +Flow Control is enabled by default.
> +
> +Use ethtool to change the flow control settings.
>   
> -Flow Control is enabled by default. If you want to disable a flow control
> -capable link partner, use ethtool:
> +To enable or disable rx or tx Flow Control:
> +ethtool -A eth? rx <on|off> tx <on|off>
> +Note: This command only enables or disables Flow Control if auto-negotiation is
> +disabled. If auto-negotiation is enabled, this command changes the parameters
> +used for auto-negotiation with the link partner.
>   
> -     ethtool -A eth? autoneg off RX off TX off
> +To enable or disable auto-negotiation:
> +ethtool -s eth? autoneg <on|off>
> +Note: Flow Control auto-negotiation is part of link auto-negotiation. Depending
> +on your device, you may not be able to change the auto-negotiation setting.
> +
> +NOTE: For 82598 backplane cards entering 1 gigabit mode, flow control default
> +behavior is changed to off. Flow control in 1 gigabit mode on these devices can
> +lead to transmit hangs.
>   
> -NOTE: For 82598 backplane cards entering 1 gig mode, flow control default
> -behavior is changed to off.  Flow control in 1 gig mode on these devices can
> -lead to Tx hangs.
>   
>   Intel(R) Ethernet Flow Director
>   -------------------------------
> -Supports advanced filters that direct receive packets by their flows to
> -different queues. Enables tight control on routing a flow in the platform.
> -Matches flows and CPU cores for flow affinity. Supports multiple parameters
> -for flexible flow classification and load balancing.
> +The Intel Ethernet Flow Director performs the following tasks:
>   
> -Flow director is enabled only if the kernel is multiple TX queue capable.
> +- Directs receive packets according to their flows to different queues.
> +- Enables tight control on routing a flow in the platform.
> +- Matches flows and CPU cores for flow affinity.
> +- Supports multiple parameters for flexible flow classification and load
> +  balancing (in SFP mode only).
>   
> -An included script (set_irq_affinity.sh) automates setting the IRQ to CPU
> +NOTE: An included script (set_irq_affinity) automates setting the IRQ to CPU
>   affinity.
>   
> -You can verify that the driver is using Flow Director by looking at the counter
> -in ethtool: fdir_miss and fdir_match.
> +NOTE: Intel Ethernet Flow Director masking works in the opposite manner from
> +subnet masking. In the following command:
> +  #ethtool -N eth11 flow-type ip4 src-ip 172.4.1.2 m 255.0.0.0 dst-ip \
> +  172.21.1.1 m 255.128.0.0 action 31
> +The src-ip value that is written to the filter will be 0.4.1.2, not 172.0.0.0
> +as might be expected. Similarly, the dst-ip value written to the filter will be
> +0.21.1.1, not 172.0.0.0.
> +
> +ethtool commands:
> +
> +To enable or disable the Intel Ethernet Flow Director:
> +
> +  # ethtool -K ethX ntuple <on|off>
> +
> +When disabling ntuple filters, all the user programed filters are flushed from
> +the driver cache and hardware. All needed filters must be re-added when ntuple
> +is re-enabled.
> +
> +To add a filter that directs packet to queue 2, use -U or -N switch:
> +
> +  # ethtool -N ethX flow-type tcp4 src-ip 192.168.10.1 dst-ip \
> +  192.168.10.2 src-port 2000 dst-port 2001 action 2 [loc 1]
>   
> -Other ethtool Commands:
> -To enable Flow Director
> -	ethtool -K ethX ntuple on
> -To add a filter
> -	Use -U switch. e.g., ethtool -U ethX flow-type tcp4 src-ip 10.0.128.23
> -        action 1
>   To see the list of filters currently present:
> -	ethtool -u ethX
> +  # ethtool <-u|-n> ethX
> +
> +
> +Perfect Filter
> +--------------
> +
> +Perfect filter is an interface to load the filter table that funnels all
> +traffic through RSS for queue assignment unless an alternative queue is
> +specified using "action". In that case, any traffic flow that matches the
> +filter criteria is directed to the specified queue.
>   
> -Perfect Filter: Perfect filter is an interface to load the filter table that
> -funnels all flow into queue_0 unless an alternative queue is specified using
> -"action". In that case, any flow that matches the filter criteria will be
> -directed to the appropriate queue.
> +Support for Virtual Function (VF) is through the user data field. ethtool must
> +be updated to the version built for the 2.6.40 kernel. Perfect Filter is
> +supported on all kernels 2.6.30 and later. Rules may be deleted from the table
> +itself. This is done using "ethtool -U ethX delete N", where N is the rule
> +number to be deleted.
>   
> -If the queue is defined as -1, filter will drop matching packets.
> +NOTE: Flow Director Perfect Filters can run in single queue mode when SR-IOV
> +is enabled or when DCB is enabled.
> +
> +If the queue is defined as -1, the filter will drop matching packets.
>   
>   To account for filter matches and misses, there are two stats in ethtool:
>   fdir_match and fdir_miss. In addition, rx_queue_N_packets shows the number of
>   packets processed by the Nth queue.
>   
> -NOTE: Receive Packet Steering (RPS) and Receive Flow Steering (RFS) are not
> -compatible with Flow Director. IF Flow Director is enabled, these will be
> -disabled.
> -
> -The following three parameters impact Flow Director.
> -
> -FdirMode

These module parameters are not supported in the kernel driver.

> ---------
> -Valid Range: 0-2 (0=off, 1=ATR, 2=Perfect filter mode)
> -Default Value: 1
> +NOTES:
> +- Receive Packet Steering (RPS) and Receive Flow Steering (RFS) are not
> +  compatible with Flow Director. If Flow Director is enabled, these will be
> +  disabled
> +- For VLAN Masks only four masks are supported.
> +- Once a rule is defined, you must supply the same fields and masks (if
> +  masks are specified).
>   
> -  Flow Director filtering modes.
>   
>   FdirPballoc
>   -----------
> -Valid Range: 0-2 (0=64k, 1=128k, 2=256k)
> -Default Value: 0
> +Valid Range: 1-3
> +Specifies the Flow Director allocated packet buffer size.
> +1 = 64k
> +2 = 128k
> +3 = 256k
>   
> -  Flow Director allocated packet buffer size.
>   
>   AtrSampleRate
> ---------------
> -Valid Range: 1-100
> -Default Value: 20
> +-------------
> +Valid Range: 0-255
> +This parameter is used with the Flow Director and is the software ATR transmit
> +packet sample rate. For example, when AtrSampleRate is set to 20, every 20th
> +packet looks to see if the packet will create a new flow. A value of 0
> +indicates that ATR should be disabled and no samples will be taken.
>   
> -  Software ATR Tx packet sample rate. For example, when set to 20, every 20th
> -  packet, looks to see if the packet will create a new flow.
>   
>   Node
>   ----
> -Valid Range:   0-n
> -Default Value: 1 (off)
> -
> -  0 - n: where n is the number of NUMA nodes (i.e. 0 - 3) currently online in
> -  your system
> -  1: turns this option off
> +Valid Range: 0-n
> +0 - n: where n is the number of the NUMA node that should be used to allocate
> +memory for this adapter port.
> +-1: uses the driver default of allocating memory on whichever processor is
> +running modprobe.
> +The Node parameter allows you to choose which NUMA node you want to have the
> +adapter allocate memory from. All driver structures, in-memory queues, and
> +receive buffers will be allocated on the node specified. This parameter is
> +only useful when interrupt affinity is specified; otherwise, part of the
> +interrupt time could run on a different core than where the memory is
> +allocated causing slower memory access and impacting throughput, CPU, or both.
>   
> -  The Node parameter will allow you to pick which NUMA node you want to have
> -  the adapter allocate memory on.
>   
>   max_vfs
>   -------
> -Valid Range:   1-63
> -Default Value: 0
> -
> -  If the value is greater than 0 it will also force the VMDq parameter to be 1
> -  or more.
> -
> -  This parameter adds support for SR-IOV.  It causes the driver to spawn up to
> -  max_vfs worth of virtual function.
> +This parameter adds support for SR-IOV. It causes the driver to spawn up to
> +max_vfs worth of virtual functions.
> +Valid Range: 1-63
> +If the value is greater than 0 it will also force the VMDq parameter to be 1 or
> +more.
> +
> +NOTE: This parameter is only used on kernel 3.7.x and below. On kernel 3.8.x
> +and above, use sysfs to enable VFs. Also, for Red Hat distributions, this
> +parameter is only used on version 6.6 and older. For version 6.7 and newer, use
> +sysfs. For example:
> +#echo $num_vf_enabled > /sys/class/net/$dev/device/sriov_numvfs	//enable
> +VFs
> +#echo 0 > /sys/class/net/$dev/device/sriov_numvfs	//disable VFs
> +
> +The parameters for the driver are referenced by position. Thus, if you have a
> +dual port adapter, or more than one adapter in your system, and want N virtual
> +functions per port, you must specify a number for each port with each parameter
> +separated by a comma. For example:
> +
> +  modprobe ixgbe max_vfs=4
> +
> +This will spawn 4 VFs on the first port.
> +
> +  modprobe ixgbe max_vfs=2,4
> +
> +This will spawn 2 VFs on the first port and 4 VFs on the second port.
> +
> +NOTE: Caution must be used in loading the driver with these parameters.
> +Depending on your system configuration, number of slots, etc., it is impossible
> +to predict in all cases where the positions would be on the command line.
> +
> +NOTE: Neither the device nor the driver control how VFs are mapped into config
> +space. Bus layout will vary by operating system. On operating systems that
> +support it, you can check sysfs to find the mapping.
> +
> +
> +NOTE: When either SR-IOV mode or VMDq mode is enabled, hardware VLAN filtering
> +and VLAN tag stripping/insertion will remain enabled. Please remove the old
> +VLAN filter before the new VLAN filter is added. For example,
> +ip link set eth0 vf 0 vlan 100	// set vlan 100 for VF 0
> +ip link set eth0 vf 0 vlan 0	// Delete vlan 100
> +ip link set eth0 vf 0 vlan 200	// set a new vlan 200 for VF 0
> +
> +With kernel 3.6, the driver supports the simultaneous usage of max_vfs and DCB
> +features, subject to the constraints described below. Prior to kernel 3.6, the
> +driver did not support the simultaneous operation of max_vfs greater than 0 and
> +the DCB features (multiple traffic classes utilizing Priority Flow Control and
> +Extended Transmission Selection).
> +
> +When DCB is enabled, network traffic is transmitted and received through
> +multiple traffic classes (packet buffers in the NIC). The traffic is associated
> +with a specific class based on priority, which has a value of 0 through 7 used
> +in the VLAN tag. When SR-IOV is not enabled, each traffic class is associated
> +with a set of receive/transmit descriptor queue pairs. The number of queue
> +pairs for a given traffic class depends on the hardware configuration. When
> +SR-IOV is enabled, the descriptor queue pairs are grouped into pools. The
> +Physical Function (PF) and each Virtual Function (VF) is allocated a pool of
> +receive/transmit descriptor queue pairs. When multiple traffic classes are
> +configured (for example, DCB is enabled), each pool contains a queue pair from
> +each traffic class. When a single traffic class is configured in the hardware,
> +the pools contain multiple queue pairs from the single traffic class.
> +
> +The number of VFs that can be allocated depends on the number of traffic
> +classes that can be enabled. The configurable number of traffic classes for
> +each enabled VF is as follows:
> +0 - 15 VFs = Up to 8 traffic classes, depending on device support
> +16 - 31 VFs = Up to 4 traffic classes
> +32 - 63 VFs = 1 traffic class
> +
> +When VFs are configured, the PF is allocated one pool as well. The PF supports
> +the DCB features with the constraint that each traffic class will only use a
> +single queue pair. When zero VFs are configured, the PF can support multiple
> +queue pairs per traffic class.
> +
> +
> +Additional Features and Configurations
> +-------------------------------------------
>   
>   
> -Additional Configurations
> -=========================
> +Jumbo Frames
> +------------
> +Jumbo Frames support is enabled by changing the Maximum Transmission Unit (MTU)
> +to a value larger than the default value of 1500.
>   
> -  Jumbo Frames
> -  ------------
> -  The driver supports Jumbo Frames for all adapters. Jumbo Frames support is
> -  enabled by changing the MTU to a value larger than the default of 1500.
> -  The maximum value for the MTU is 16110.  Use the ip command to
> -  increase the MTU size.  For example:
> +Use the ifconfig command to increase the MTU size. For example, enter the
> +following where <x> is the interface number:
>   
> -        ip link set dev ethx mtu 9000
> +   ifconfig eth<x> mtu 9000 up
> +Alternatively, you can use the ip command as follows:
> +   ip link set mtu 9000 dev eth<x>
> +   ip link set up dev eth<x>
>   
> -  The maximum MTU setting for Jumbo Frames is 9710.  This value coincides
> -  with the maximum Jumbo Frames size of 9728.
> +This setting is not saved across reboots. The setting change can be made
> +permanent by adding 'MTU=9000' to the file:
> +/etc/sysconfig/network-scripts/ifcfg-eth<x> for RHEL or to the file
> +/etc/sysconfig/network/<config_file> for SLES.
>   
> -  Generic Receive Offload, aka GRO
> -  --------------------------------
> -  The driver supports the in-kernel software implementation of GRO.  GRO has
> -  shown that by coalescing Rx traffic into larger chunks of data, CPU
> -  utilization can be significantly reduced when under large Rx load.  GRO is an
> -  evolution of the previously-used LRO interface.  GRO is able to coalesce
> -  other protocols besides TCP.  It's also safe to use with configurations that
> -  are problematic for LRO, namely bridging and iSCSI.
> +NOTE: The maximum MTU setting for Jumbo Frames is 9710. This value coincides
> +with the maximum Jumbo Frames size of 9728 bytes.
>   
> -  Data Center Bridging, aka DCB
> -  -----------------------------
> -  DCB is a configuration Quality of Service implementation in hardware.
> -  It uses the VLAN priority tag (802.1p) to filter traffic.  That means
> -  that there are 8 different priorities that traffic can be filtered into.
> -  It also enables priority flow control which can limit or eliminate the
> -  number of dropped packets during network stress.  Bandwidth can be
> -  allocated to each of these priorities, which is enforced at the hardware
> -  level.
> +NOTE: This driver will attempt to use multiple page sized buffers to receive
> +each jumbo packet. This should help to avoid buffer starvation issues when
> +allocating receive packets.
>   
> -  To enable DCB support in ixgbe, you must enable the DCB netlink layer to
> -  allow the userspace tools (see below) to communicate with the driver.
> -  This can be found in the kernel configuration here:
> +NOTE: For 82599-based network connections, if you are enabling jumbo frames in
> +a virtual function (VF), jumbo frames must first be enabled in the physical
> +function (PF). The VF MTU setting cannot be larger than the PF MTU.
>   
> -        -> Networking support
> -          -> Networking options
> -            -> Data Center Bridging support
>   
> -  Once this is selected, DCB support must be selected for ixgbe.  This can
> -  be found here:
> +Generic Receive Offload, aka GRO
> +--------------------------------
>   
> -        -> Device Drivers
> -          -> Network device support (NETDEVICES [=y])
> -            -> Ethernet (10000 Mbit) (NETDEV_10000 [=y])
> -              -> Intel(R) 10GbE PCI Express adapters support
> -                -> Data Center Bridging (DCB) Support
> +The driver supports the in-kernel software implementation of GRO. GRO has
> +shown that by coalescing Rx traffic into larger chunks of data, CPU
> +utilization can be significantly reduced when under large Rx load. GRO is an
> +evolution of the previously-used LRO interface. GRO is able to coalesce
> +other protocols besides TCP. It's also safe to use with configurations that
> +are problematic for LRO, namely bridging and iSCSI.
>   
> -  After these options are selected, you must rebuild your kernel and your
> -  modules.
>   
> -  In order to use DCB, userspace tools must be downloaded and installed.
> -  The dcbd tools can be found at:
> +Data Center Bridging (DCB)
> +--------------------------
>   
> -        http://e1000.sf.net
> +NOTE:
> +The kernel assumes that TC0 is available, and will disable Priority Flow
> +Control (PFC) on the device if TC0 is not available. To fix this, ensure TC0 is
> +enabled when setting up DCB on your switch.
>   
> -  Ethtool
> -  -------
> -  The driver utilizes the ethtool interface for driver configuration and
> -  diagnostics, as well as displaying statistical information. The latest
> -  ethtool version is required for this functionality.
>   
> -  The latest release of ethtool can be found from
> -  https://www.kernel.org/pub/software/network/ethtool/
> +DCB is a configuration Quality of Service implementation in hardware. It uses
> +the VLAN priority tag (802.1p) to filter traffic. That means that there are 8
> +different priorities that traffic can be filtered into. It also enables
> +priority flow control (802.1Qbb) which can limit or eliminate the number of
> +dropped packets during network stress. Bandwidth can be allocated to each of
> +these priorities, which is enforced at the hardware level (802.1Qaz).
>   
> -  FCoE
> -  ----
> -  This release of the ixgbe driver contains new code to enable users to use
> -  Fiber Channel over Ethernet (FCoE) and Data Center Bridging (DCB)
> -  functionality that is supported by the 82598-based hardware.  This code has
> -  no default effect on the regular driver operation, and configuring DCB and
> -  FCoE is outside the scope of this driver README. Refer to
> -  http://www.open-fcoe.org/ for FCoE project information and contact
> -  e1000-eedc at lists.sourceforge.net for DCB information.
> +Adapter firmware implements LLDP and DCBX protocol agents as per 802.1AB and
> +802.1Qaz respectively. The firmware based DCBX agent runs in willing mode only
> +and can accept settings from a DCBX capable peer. Software configuration of
> +DCBX parameters via dcbtool/lldptool are not supported.
>   
> -  MAC and VLAN anti-spoofing feature
> -  ----------------------------------
> -  When a malicious driver attempts to send a spoofed packet, it is dropped by
> -  the hardware and not transmitted.  An interrupt is sent to the PF driver
> -  notifying it of the spoof attempt.
> +The ixgbe driver implements the DCB netlink interface layer to allow user-space
> +to communicate with the driver and query DCB configuration for the port.
>   
> -  When a spoofed packet is detected the PF driver will send the following
> -  message to the system log (displayed by  the "dmesg" command):
>   
> -  Spoof event(s) detected on VF (n)
> +ethtool
> +-------
> +The driver utilizes the ethtool interface for driver configuration and
> +diagnostics, as well as displaying statistical information. The latest ethtool
> +version is required for this functionality. Download it at:
> +http://ftp.kernel.org/pub/software/network/ethtool/
>   
> -  Where n=the VF that attempted to do the spoofing.
>   
> +FCoE
> +----
>   
> -Performance Tuning
> -==================
> +This release of the ixgbe driver contains new code to enable users to use
> +Fiber Channel over Ethernet (FCoE) and Data Center Bridging (DCB)
> +functionality that is supported by the 82598-based hardware. This code has
> +no default effect on the regular driver operation, and configuring DCB and
> +FCoE is outside the scope of this driver README. Refer to
> +http://www.open-fcoe.org/ for FCoE project information and contact
> +ixgbe-eedc at lists.sourceforge.net for DCB information.
>   
> -An excellent article on performance tuning can be found at:
>   
> -http://www.redhat.com/promo/summit/2008/downloads/pdf/Thursday/Mark_Wagner.pdf
> +MAC and VLAN anti-spoofing feature
> +----------------------------------
>   
> +When a malicious driver attempts to send a spoofed packet, it is dropped by the
> +hardware and not transmitted.
>   
> -Known Issues
> -============
> +An interrupt is sent to the PF driver notifying it of the spoof attempt. When a
> +spoofed packet is detected, the PF driver will send the following message to
> +the system log (displayed by the "dmesg" command):
> +ixgbe ethX: ixgbe_spoof_check: n spoofed packets detected
> +where "x" is the PF interface number; and "n" is number of spoofed packets.
> +NOTE: This feature can be disabled for a specific Virtual Function (VF):
> +ip link set <pf dev> vf <vf id> spoofchk {off|on}
>   
> -  Enabling SR-IOV in a 32-bit or 64-bit Microsoft* Windows* Server 2008/R2
> -  Guest OS using Intel (R) 82576-based GbE or Intel (R) 82599-based 10GbE
> -  controller under KVM
> -  ------------------------------------------------------------------------
> -  KVM Hypervisor/VMM supports direct assignment of a PCIe device to a VM.  This
> -  includes traditional PCIe devices, as well as SR-IOV-capable devices using
> -  Intel 82576-based and 82599-based controllers.
>   
> -  While direct assignment of a PCIe device or an SR-IOV Virtual Function (VF)
> -  to a Linux-based VM running 2.6.32 or later kernel works fine, there is a
> -  known issue with Microsoft Windows Server 2008 VM that results in a "yellow
> -  bang" error. This problem is within the KVM VMM itself, not the Intel driver,
> -  or the SR-IOV logic of the VMM, but rather that KVM emulates an older CPU
> -  model for the guests, and this older CPU model does not support MSI-X
> -  interrupts, which is a requirement for Intel SR-IOV.
> +Known Issues/Troubleshooting
> +----------------------------
>   
> -  If you wish to use the Intel 82576 or 82599-based controllers in SR-IOV mode
> -  with KVM and a Microsoft Windows Server 2008 guest try the following
> -  workaround. The workaround is to tell KVM to emulate a different model of CPU
> -  when using qemu to create the KVM guest:
>   
> -       "-cpu qemu64,model=13"
> +Enabling SR-IOV in a 64-bit Microsoft* Windows Server* 2012/R2 guest OS under
> +Linux KVM
> +--------------------------------------------------------------------------------
> +KVM Hypervisor/VMM supports direct assignment of a PCIe device to a VM. This
> +includes traditional PCIe devices, as well as SR-IOV-capable devices based on
> +the Intel Ethernet Controller XL710.
>   
>   
>   Support
> -=======
> -
> +-------
>   For general information, go to the Intel support website at:
> -
> -    http://support.intel.com
> +www.intel.com/support/
>   
>   or the Intel Wired Networking project hosted by Sourceforge at:
> +http://sourceforge.net/projects/e1000
> +If an issue is identified with the released source code on a supported kernel
> +with a supported adapter, email the specific information related to the issue
> +to e1000-devel at lists.sf.net.
>   
> -    http://e1000.sourceforge.net
>   
> -If an issue is identified with the released source code on the supported
> -kernel with a supported adapter, email the specific information related
> -to the issue to e1000-devel at lists.sf.net
> diff --git a/Documentation/networking/ixgbevf.txt b/Documentation/networking/ixgbevf.txt
> index 53d8d2a5a6a3..1e88318d43c2 100644
> --- a/Documentation/networking/ixgbevf.txt
> +++ b/Documentation/networking/ixgbevf.txt
> @@ -2,7 +2,7 @@ Linux* Base Driver for Intel(R) Ethernet Network Connection
>   ===========================================================
>   
>   Intel Gigabit Linux driver.
> -Copyright(c) 1999 - 2013 Intel Corporation.
> +Copyright(c) 1999-2016 Intel Corporation.

2018

>   
>   Contents
>   ========
> @@ -11,42 +11,61 @@ Contents
>   - Known Issues/Troubleshooting
>   - Support
>   
> -This file describes the ixgbevf Linux* Base Driver for Intel Network
> -Connection.
> +This virtual function driver supports kernel versions 2.6.x and newer.
>   
> -The ixgbevf driver supports 82599-based virtual function devices that can only
> -be activated on kernels with CONFIG_PCI_IOV enabled.
> +This driver supports 82599, X540, X550, and X552-based virtual function devices
> +that can only be activated on kernels that support SR-IOV.
>   
> -The ixgbevf driver supports virtual functions generated by the ixgbe driver
> -with a max_vfs value of 1 or greater.
> +SR-IOV requires the correct platform and OS support.
>   
> -The guest OS loading the ixgbevf driver must support MSI-X interrupts.
> +The guest OS loading this driver must support MSI-X interrupts.
> +
> +This driver is only supported as a loadable module at this time. Intel is not
> +supplying patches against the kernel source to allow for static linking of the
> +drivers.
> +
> +For questions related to hardware requirements, refer to the documentation
> +supplied with your Intel adapter. All hardware requirements listed apply to use
> +with Linux.
> +
> +Driver information can be obtained using variable_value_undefined. Instructions
> +on updating ethtool can be found in the section Additional Configurations later
> +in this document.
> +
> +VLANs: There is a limit of a total of 64 shared VLANs to 1 or more VFs.
> +
> +A version of the driver may already be included by your
> +distribution and/or the kernel.org kernel.
>   
> -VLANs: There is a limit of a total of 32 shared VLANs to 1 or more VFs.
>   
>   Identifying Your Adapter
> -========================
> +------------------------
> +The driver is compatible with devices based on the following:
> +  * Intel(R) Ethernet Controller 82598
> +  * Intel(R) Ethernet Controller 82599
> +  * Intel(R) Ethernet Controller X540
> +  * Intel(R) Ethernet Controller x550
> +  * Intel(R) Ethernet Controller X552
> +  * Intel(R) Ethernet Controller X553
>   
> -For more information on how to identify your adapter, go to the Adapter &
> -Driver ID Guide at:
> +For information on how to identify your adapter, and for the latest Intel
> +network drivers, refer to the Intel Support website:
> +http://www.intel.com/support
>   
> -    http://support.intel.com/support/go/network/adapter/idguide.htm
>   
>   Known Issues/Troubleshooting
> -============================
> +----------------------------
>   
>   
>   Support
> -=======
> -
> +-------
>   For general information, go to the Intel support website at:
> -
> -    http://support.intel.com
> +www.intel.com/support/
>   
>   or the Intel Wired Networking project hosted by Sourceforge at:
> +http://sourceforge.net/projects/e1000
> +If an issue is identified with the released source code on a supported kernel
> +with a supported adapter, email the specific information related to the issue
> +to e1000-devel at lists.sf.net.
>   
> -    http://sourceforge.net/projects/e1000
>   
> -If an issue is identified with the released source code on the supported
> -kernel with a supported adapter, email the specific information related
> -to the issue to e1000-devel at lists.sf.net
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
