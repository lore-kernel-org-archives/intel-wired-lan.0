From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 28 Feb 2018 14:48:55 -0800
Subject: [Intel-wired-lan] [PATCH 4/8] Documentation: ixgbe: Update
 kernel documentation
In-Reply-To: <20180228175032.11148-4-jeffrey.t.kirsher@intel.com>
References: <20180228175032.11148-1-jeffrey.t.kirsher@intel.com>
 <20180228175032.11148-4-jeffrey.t.kirsher@intel.com>
Message-ID: <5b2efc18-afde-eb68-9d32-c01b4b683db2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/28/2018 9:50 AM, Jeff Kirsher wrote:
> Updated the ixgbe.txt kernel documentation with the latest information.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>   Documentation/networking/ixgbe.txt | 621 +++++++++++++++++++++++--------------
>   1 file changed, 383 insertions(+), 238 deletions(-)
> 
> diff --git a/Documentation/networking/ixgbe.txt b/Documentation/networking/ixgbe.txt
> index 687835415707..8de863de6032 100644
> --- a/Documentation/networking/ixgbe.txt
> +++ b/Documentation/networking/ixgbe.txt
> @@ -2,12 +2,12 @@ Linux* Base Driver for the Intel(R) Ethernet 10 Gigabit PCI Express Family of
>   Adapters
>   =============================================================================
>   
> +February 23, 2017
>   Intel 10 Gigabit Linux driver.
> -Copyright(c) 1999 - 2013 Intel Corporation.
> +Copyright(c) 1999-2018 Intel Corporation.
>   
>   Contents
>   ========
> -
>   - Identifying Your Adapter
>   - Additional Configurations
>   - Performance Tuning
> @@ -15,335 +15,480 @@ Contents
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

Missing x520

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
> +When disabling ntuple filters, all the user programmed filters are flushed from
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
>   
> -Perfect Filter: Perfect filter is an interface to load the filter table that
> -funnels all flow into queue_0 unless an alternative queue is specified using
> -"action". In that case, any flow that matches the filter criteria will be
> -directed to the appropriate queue.
> +Perfect Filter
> +--------------
>   
> -If the queue is defined as -1, filter will drop matching packets.
> +Perfect filter is an interface to load the filter table that funnels all

More explanation of Perfect Filter here would be good, otherwise I can't 
tell how this is different from what is described for ntuple filters. 
Is there any difference?  Maybe not... can't tell.

> +traffic through RSS for queue assignment unless an alternative queue is
> +specified using "action". In that case, any traffic flow that matches the
> +filter criteria is directed to the specified queue.
> +
> +Support for Virtual Function (VF) is through the user data field. ethtool must

There should be a little more explanation of what support for VF means, 
and definitely an example command line to make it work.


> +be updated to the version built for the 2.6.40 kernel. Perfect Filter is
> +supported on all kernels 2.6.30 and later. Rules may be deleted from the table
> +itself. This is done using "ethtool -U ethX delete N", where N is the rule
> +number to be deleted.
> +
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
> +NOTES:
> +- Receive Packet Steering (RPS) and Receive Flow Steering (RFS) are not
> +  compatible with Flow Director. If Flow Director is enabled, these will be
> +  disabled
> +- For VLAN Masks only four masks are supported.
> +- Once a rule is defined, you must supply the same fields and masks (if
> +  masks are specified).
>   
> -FdirMode
> ---------
> -Valid Range: 0-2 (0=off, 1=ATR, 2=Perfect filter mode)
> -Default Value: 1
> -
> -  Flow Director filtering modes.
>   
>   FdirPballoc

Except for max_fvs, these module parameters are no longer in the 
in-kernel driver so should not be mentioned in the in-kernel 
documentation.  However, you might think about mentioning the other two 
module parameters that are supported.


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
> -
> -
> -Additional Configurations
> -=========================
> -
> -  Jumbo Frames
> -  ------------
> -  The driver supports Jumbo Frames for all adapters. Jumbo Frames support is
> -  enabled by changing the MTU to a value larger than the default of 1500.
> -  The maximum value for the MTU is 16110.  Use the ip command to
> -  increase the MTU size.  For example:
> -
> -        ip link set dev ethx mtu 9000
> -
> -  The maximum MTU setting for Jumbo Frames is 9710.  This value coincides
> -  with the maximum Jumbo Frames size of 9728.
> -
> -  Generic Receive Offload, aka GRO
> -  --------------------------------
> -  The driver supports the in-kernel software implementation of GRO.  GRO has
> -  shown that by coalescing Rx traffic into larger chunks of data, CPU
> -  utilization can be significantly reduced when under large Rx load.  GRO is an
> -  evolution of the previously-used LRO interface.  GRO is able to coalesce
> -  other protocols besides TCP.  It's also safe to use with configurations that
> -  are problematic for LRO, namely bridging and iSCSI.
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
> -  Data Center Bridging, aka DCB
> -  -----------------------------
> -  DCB is a configuration Quality of Service implementation in hardware.
> -  It uses the VLAN priority tag (802.1p) to filter traffic.  That means
> -  that there are 8 different priorities that traffic can be filtered into.
> -  It also enables priority flow control which can limit or eliminate the
> -  number of dropped packets during network stress.  Bandwidth can be
> -  allocated to each of these priorities, which is enforced at the hardware
> -  level.
> +Jumbo Frames
> +------------
> +Jumbo Frames support is enabled by changing the Maximum Transmission Unit (MTU)
> +to a value larger than the default value of 1500.
>   
> -  To enable DCB support in ixgbe, you must enable the DCB netlink layer to
> -  allow the userspace tools (see below) to communicate with the driver.
> -  This can be found in the kernel configuration here:
> +Use the ifconfig command to increase the MTU size. For example, enter the
> +following where <x> is the interface number:
>   
> -        -> Networking support
> -          -> Networking options
> -            -> Data Center Bridging support
> +   ifconfig eth<x> mtu 9000 up
> +Alternatively, you can use the ip command as follows:
> +   ip link set mtu 9000 dev eth<x>
> +   ip link set up dev eth<x>
>   
> -  Once this is selected, DCB support must be selected for ixgbe.  This can
> -  be found here:
> +This setting is not saved across reboots. The setting change can be made
> +permanent by adding 'MTU=9000' to the file:
> +/etc/sysconfig/network-scripts/ifcfg-eth<x> for RHEL or to the file
> +/etc/sysconfig/network/<config_file> for SLES.
>   
> -        -> Device Drivers
> -          -> Network device support (NETDEVICES [=y])
> -            -> Ethernet (10000 Mbit) (NETDEV_10000 [=y])
> -              -> Intel(R) 10GbE PCI Express adapters support
> -                -> Data Center Bridging (DCB) Support
> +NOTE: The maximum MTU setting for Jumbo Frames is 9710. This value coincides
> +with the maximum Jumbo Frames size of 9728 bytes.
>   
> -  After these options are selected, you must rebuild your kernel and your
> -  modules.
> +NOTE: This driver will attempt to use multiple page sized buffers to receive
> +each jumbo packet. This should help to avoid buffer starvation issues when
> +allocating receive packets.
>   
> -  In order to use DCB, userspace tools must be downloaded and installed.
> -  The dcbd tools can be found at:
> +NOTE: For 82599-based network connections, if you are enabling jumbo frames in
> +a virtual function (VF), jumbo frames must first be enabled in the physical
> +function (PF). The VF MTU setting cannot be larger than the PF MTU.
>   
> -        http://e1000.sf.net
>   
> -  Ethtool
> -  -------
> -  The driver utilizes the ethtool interface for driver configuration and
> -  diagnostics, as well as displaying statistical information. The latest
> -  ethtool version is required for this functionality.
> +Generic Receive Offload, aka GRO
> +--------------------------------
> +The driver supports the in-kernel software implementation of GRO. GRO has
> +shown that by coalescing Rx traffic into larger chunks of data, CPU
> +utilization can be significantly reduced when under large Rx load. GRO is an
> +evolution of the previously-used LRO interface. GRO is able to coalesce
> +other protocols besides TCP. It's also safe to use with configurations that
> +are problematic for LRO, namely bridging and iSCSI.
>   
> -  The latest release of ethtool can be found from
> -  https://www.kernel.org/pub/software/network/ethtool/
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
> +Data Center Bridging (DCB)
> +--------------------------
> +NOTE:
> +The kernel assumes that TC0 is available, and will disable Priority Flow
> +Control (PFC) on the device if TC0 is not available. To fix this, ensure TC0 is
> +enabled when setting up DCB on your switch.
>   
> -  MAC and VLAN anti-spoofing feature
> -  ----------------------------------
> -  When a malicious driver attempts to send a spoofed packet, it is dropped by
> -  the hardware and not transmitted.  An interrupt is sent to the PF driver
> -  notifying it of the spoof attempt.
>   
> -  When a spoofed packet is detected the PF driver will send the following
> -  message to the system log (displayed by  the "dmesg" command):
> +DCB is a configuration Quality of Service implementation in hardware. It uses
> +the VLAN priority tag (802.1p) to filter traffic. That means that there are 8
> +different priorities that traffic can be filtered into. It also enables
> +priority flow control (802.1Qbb) which can limit or eliminate the number of
> +dropped packets during network stress. Bandwidth can be allocated to each of
> +these priorities, which is enforced at the hardware level (802.1Qaz).
>   
> -  Spoof event(s) detected on VF (n)
> +Adapter firmware implements LLDP and DCBX protocol agents as per 802.1AB and
> +802.1Qaz respectively. The firmware based DCBX agent runs in willing mode only
> +and can accept settings from a DCBX capable peer. Software configuration of
> +DCBX parameters via dcbtool/lldptool are not supported.
>   
> -  Where n=the VF that attempted to do the spoofing.
> +The ixgbe driver implements the DCB netlink interface layer to allow user-space
> +to communicate with the driver and query DCB configuration for the port.
>   
>   
> -Performance Tuning
> -==================
> +ethtool
> +-------
> +The driver utilizes the ethtool interface for driver configuration and
> +diagnostics, as well as displaying statistical information. The latest ethtool
> +version is required for this functionality. Download it at:
> +http://ftp.kernel.org/pub/software/network/ethtool/
>   
> -An excellent article on performance tuning can be found at:
>   
> -http://www.redhat.com/promo/summit/2008/downloads/pdf/Thursday/Mark_Wagner.pdf
> +FCoE
> +----
> +This release of the ixgbe driver contains new code to enable users to use

Since this is kernel documentation, the phrase "This release" is 
inappropriate.

Also, I think the FCoE code, if even supported anymore, is long past 
being "new".

sln

> +Fiber Channel over Ethernet (FCoE) and Data Center Bridging (DCB)
> +functionality that is supported by the 82598-based hardware. This code has
> +no default effect on the regular driver operation, and configuring DCB and
> +FCoE is outside the scope of this driver README. Refer to
> +http://www.open-fcoe.org/ for FCoE project information and contact
> +ixgbe-eedc at lists.sourceforge.net for DCB information.
>   
>   
> -Known Issues
> -============
> +MAC and VLAN anti-spoofing feature
> +----------------------------------
> +When a malicious driver attempts to send a spoofed packet, it is dropped by the
> +hardware and not transmitted.
>   
> -  Enabling SR-IOV in a 32-bit or 64-bit Microsoft* Windows* Server 2008/R2
> -  Guest OS using Intel (R) 82576-based GbE or Intel (R) 82599-based 10GbE
> -  controller under KVM
> -  ------------------------------------------------------------------------
> -  KVM Hypervisor/VMM supports direct assignment of a PCIe device to a VM.  This
> -  includes traditional PCIe devices, as well as SR-IOV-capable devices using
> -  Intel 82576-based and 82599-based controllers.
> +An interrupt is sent to the PF driver notifying it of the spoof attempt. When a
> +spoofed packet is detected, the PF driver will send the following message to
> +the system log (displayed by the "dmesg" command):
> +ixgbe ethX: ixgbe_spoof_check: n spoofed packets detected
> +where "x" is the PF interface number; and "n" is number of spoofed packets.
> +NOTE: This feature can be disabled for a specific Virtual Function (VF):
> +ip link set <pf dev> vf <vf id> spoofchk {off|on}
>   
> -  While direct assignment of a PCIe device or an SR-IOV Virtual Function (VF)
> -  to a Linux-based VM running 2.6.32 or later kernel works fine, there is a
> -  known issue with Microsoft Windows Server 2008 VM that results in a "yellow
> -  bang" error. This problem is within the KVM VMM itself, not the Intel driver,
> -  or the SR-IOV logic of the VMM, but rather that KVM emulates an older CPU
> -  model for the guests, and this older CPU model does not support MSI-X
> -  interrupts, which is a requirement for Intel SR-IOV.
>   
> -  If you wish to use the Intel 82576 or 82599-based controllers in SR-IOV mode
> -  with KVM and a Microsoft Windows Server 2008 guest try the following
> -  workaround. The workaround is to tell KVM to emulate a different model of CPU
> -  when using qemu to create the KVM guest:
> +Known Issues/Troubleshooting
> +----------------------------
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
> +http://www.intel.com/support/
>   
>   or the Intel Wired Networking project hosted by Sourceforge at:
> -
> -    http://e1000.sourceforge.net
> -
> -If an issue is identified with the released source code on the supported
> -kernel with a supported adapter, email the specific information related
> -to the issue to e1000-devel at lists.sf.net
> +http://sourceforge.net/projects/e1000
> +If an issue is identified with the released source code on a supported kernel
> +with a supported adapter, email the specific information related to the issue
> +to e1000-devel at lists.sf.net.
> 

