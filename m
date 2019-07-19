From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Fri, 19 Jul 2019 14:00:17 -0700
Subject: [Intel-wired-lan] [PATCH v2] Documentation: iavf: Update the
 Intel LAN driver doc for iavf
In-Reply-To: <a805afc41bb56d2e041946886d9aaae8ca0f5188.camel@intel.com>
References: <20190719200723.27851-1-jeffrey.t.kirsher@intel.com>
 <bc092433-86ee-cf10-9a1a-63fe5ff7bb4c@intel.com>
 <a805afc41bb56d2e041946886d9aaae8ca0f5188.camel@intel.com>
Message-ID: <e56eb092-1fa8-5169-60ea-00ccf0eca6e3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/19/2019 1:26 PM, Jeff Kirsher wrote:
> On Fri, 2019-07-19 at 13:18 -0700, Samudrala, Sridhar wrote:
>>
>> On 7/19/2019 1:07 PM, Jeff Kirsher wrote:
>>> Update the LAN driver documentation to include the latest feature
>>> implementation and driver capabilities.
>>>
>>> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>>> ---
>>> v2: fixed SOB and cleaned up the trailing whitespace
>>>
>>>    .../networking/device_drivers/intel/iavf.rst  | 331
>>> ++++++++++++++++--
>>>    1 file changed, 298 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/Documentation/networking/device_drivers/intel/iavf.rst
>>> b/Documentation/networking/device_drivers/intel/iavf.rst
>>> index 2d0c3baa1752..fd3d045ca6d1 100644
>>> --- a/Documentation/networking/device_drivers/intel/iavf.rst
>>> +++ b/Documentation/networking/device_drivers/intel/iavf.rst
>>> @@ -10,11 +10,15 @@ Copyright(c) 2013-2018 Intel Corporation.
>>>    Contents
>>>    ========
>>>    
>>> +- Overview
>>>    - Identifying Your Adapter
>>>    - Additional Configurations
>>>    - Known Issues/Troubleshooting
>>>    - Support
>>>    
>>> +Overview
>>> +========
>>> +
>>>    This file describes the iavf Linux* Base Driver. This driver was
>>> formerly
>>>    called i40evf.
>>>    
>>> @@ -27,6 +31,7 @@ The guest OS loading the iavf driver must support
>>> MSI-X interrupts.
>>>    
>>>    Identifying Your Adapter
>>>    ========================
>>> +
>>>    The driver in this kernel is compatible with devices based on the
>>> following:
>>>     * Intel(R) XL710 X710 Virtual Function
>>>     * Intel(R) X722 Virtual Function
>>> @@ -50,9 +55,10 @@ Link messages will not be displayed to the
>>> console if the distribution is
>>>    restricting system messages. In order to see network driver link
>>> messages on
>>>    your console, set dmesg to eight by entering the following::
>>>    
>>> -  dmesg -n 8
>>> +    # dmesg -n 8
>>>    
>>> -NOTE: This setting is not saved across reboots.
>>> +NOTE:
>>> +  This setting is not saved across reboots.
>>>    
>>>    ethtool
>>>    -------
>>> @@ -72,11 +78,11 @@ then requests from that VF to set VLAN tag
>>> stripping will be ignored.
>>>    To enable/disable VLAN tag stripping for a VF, issue the
>>> following command
>>>    from inside the VM in which you are running the VF::
>>>    
>>> -  ethtool -K <if_name> rxvlan on/off
>>> +    # ethtool -K <if_name> rxvlan on/off
>>>    
>>>    or alternatively::
>>>    
>>> -  ethtool --offload <if_name> rxvlan on/off
>>> +    # ethtool --offload <if_name> rxvlan on/off
>>>    
>>>    Adaptive Virtual Function
>>>    -------------------------
>>> @@ -91,21 +97,21 @@ additional features depending on what features
>>> are available in the PF with
>>>    which the AVF is associated. The following are base mode
>>> features:
>>>    
>>>    - 4 Queue Pairs (QP) and associated Configuration Status
>>> Registers (CSRs)
>>> -  for Tx/Rx.
>>> -- i40e descriptors and ring format.
>>> -- Descriptor write-back completion.
>>> -- 1 control queue, with i40e descriptors, CSRs and ring format.
>>> -- 5 MSI-X interrupt vectors and corresponding i40e CSRs.
>>> -- 1 Interrupt Throttle Rate (ITR) index.
>>> -- 1 Virtual Station Interface (VSI) per VF.
>>> +  for Tx/Rx
>>> +- i40e descriptors and ring format
>>> +- Descriptor write-back completion
>>> +- 1 control queue, with i40e descriptors, CSRs and ring format
>>> +- 5 MSI-X interrupt vectors and corresponding i40e CSRs
>>> +- 1 Interrupt Throttle Rate (ITR) index
>>> +- 1 Virtual Station Interface (VSI) per VF
>>>    - 1 Traffic Class (TC), TC0
>>>    - Receive Side Scaling (RSS) with 64 entry indirection table and
>>> key,
>>> -  configured through the PF.
>>> -- 1 unicast MAC address reserved per VF.
>>> -- 16 MAC address filters for each VF.
>>> -- Stateless offloads - non-tunneled checksums.
>>> -- AVF device ID.
>>> -- HW mailbox is used for VF to PF communications (including on
>>> Windows).
>>> +  configured through the PF
>>> +- 1 unicast MAC address reserved per VF
>>> +- 16 MAC address filters for each VF
>>> +- Stateless offloads - non-tunneled checksums
>>> +- AVF device ID
>>> +- HW mailbox is used for VF to PF communications (including on
>>> Windows)
>>>    
>>>    IEEE 802.1ad (QinQ) Support
>>>    ---------------------------
>>> @@ -117,8 +123,8 @@ VLAN ID, among other uses.
>>>    
>>>    The following are examples of how to configure 802.1ad (QinQ)::
>>>    
>>> -  ip link add link eth0 eth0.24 type vlan proto 802.1ad id 24
>>> -  ip link add link eth0.24 eth0.24.371 type vlan proto 802.1Q id
>>> 371
>>> +    # ip link add link eth0 eth0.24 type vlan proto 802.1ad id 24
>>> +    # ip link add link eth0.24 eth0.24.371 type vlan proto 802.1Q
>>> id 371
>>>    
>>>    Where "24" and "371" are example VLAN IDs.
>>>    
>>> @@ -133,6 +139,19 @@ specific application. This can reduce latency
>>> for the specified application,
>>>    and allow Tx traffic to be rate limited per application. Follow
>>> the steps below
>>>    to set ADq.
>>>    
>>> +Requirements:
>>> +
>>> +- The sch_mqprio, act_mirred and cls_flower modules must be loaded
>>> +- The latest version of iproute2
>>> +- If another driver (for example, DPDK) has set cloud filters, you
>>> cannot
>>> +  enable ADQ
>>> +- Depending on the underlying PF device, ADQ cannot be enabled
>>> when the
>>> +  following features are enabled:
>>> +
>>> +  + Data Center Bridging (DCB)
>>> +  + Multiple Functions per Port (MFP)
>>> +  + Sideband Filters
>>> +
>>>    1. Create traffic classes (TCs). Maximum of 8 TCs can be created
>>> per interface.
>>>    The shaper bw_rlimit parameter is optional.
>>>    
>>> @@ -141,9 +160,9 @@ to 1Gbit for tc0 and 3Gbit for tc1.
>>>    
>>>    ::
>>>    
>>> -  # tc qdisc add dev <interface> root mqprio num_tc 2 map 0 0 0 0
>>> 1 1 1 1
>>> -  queues 16 at 0 16 at 16 hw 1 mode channel shaper bw_rlimit min_rate
>>> 1Gbit 2Gbit
>>> -  max_rate 1Gbit 3Gbit
>>> +    tc qdisc add dev <interface> root mqprio num_tc 2 map 0 0 0 0
>>> 1 1 1 1
>>> +    queues 16 at 0 16 at 16 hw 1 mode channel shaper bw_rlimit min_rate
>>> 1Gbit 2Gbit
>>> +    max_rate 1Gbit 3Gbit
>>>    
>>>    map: priority mapping for up to 16 priorities to tcs (e.g. map 0
>>> 0 0 0 1 1 1 1
>>>    sets priorities 0-3 to use tc0 and 4-7 to use tc1)
>>> @@ -162,6 +181,10 @@ Totals must be equal or less than port speed.
>>>    For example: min_rate 1Gbit 3Gbit: Verify bandwidth limit using
>>> network
>>>    monitoring tools such as ifstat or sar ?n DEV [interval] [number
>>> of samples]
>>>    
>>> +NOTE:
>>> +  Setting up channels via ethtool (ethtool -L) is not supported
>>> when the
>>> +  TCs are configured using mqprio.
>>> +
>>>    2. Enable HW TC offload on interface::
>>>    
>>>        # ethtool -K <interface> hw-tc-offload on
>>> @@ -171,16 +194,16 @@ monitoring tools such as ifstat or sar ?n DEV
>>> [interval] [number of samples]
>>>        # tc qdisc add dev <interface> ingress
>>>    
>>>    NOTES:
>>> - - Run all tc commands from the iproute2 <pathtoiproute2>/tc/
>>> directory.
>>> - - ADq is not compatible with cloud filters.
>>> + - Run all tc commands from the iproute2 <pathtoiproute2>/tc/
>>> directory
>>> + - ADq is not compatible with cloud filters
>>>     - Setting up channels via ethtool (ethtool -L) is not supported
>>> when the TCs
>>> -   are configured using mqprio.
>>> +   are configured using mqprio
>>>     - You must have iproute2 latest version
>>> - - NVM version 6.01 or later is required.
>>> + - NVM version 6.01 or later is required
>>>     - ADq cannot be enabled when any the following features are
>>> enabled: Data
>>> -   Center Bridging (DCB), Multiple Functions per Port (MFP), or
>>> Sideband Filters.
>>> +   Center Bridging (DCB), Multiple Functions per Port (MFP), or
>>> Sideband Filters
>>>     - If another driver (for example, DPDK) has set cloud filters,
>>> you cannot
>>> -   enable ADq.
>>> +   enable ADq
>>>     - Tunnel filters are not supported in ADq. If encapsulated
>>> packets do arrive
>>>       in non-tunnel mode, filtering will be done on the inner
>>> headers.  For example,
>>>       for VXLAN traffic in non-tunnel mode, PCTYPE is identified as
>>> a VXLAN
>>> @@ -194,10 +217,236 @@ NOTES:
>>>       traffic will be duplicated and sent to all matching TC
>>> queues.  The hardware
>>>       switch mirrors the packet to a VSI list when multiple filters
>>> are matched.
>>>    
>>> +SR-IOV Hypervisor Management Interface
>>> +--------------------------------------
>>> +The sysfs file structure below supports the SR-IOV hypervisor
>>> management
>>> +interface.
>>> +
>>> +| /sys/class/net/<interface-name>/device/sriov (see [1]_)
>>> +| +-- [VF-id, 0 .. 127] (see [2]_)
>>> +| | +-- trunk
>>> +| | +-- vlan_mirror
>>> +| | +-- engress_mirror
>>> +| | +-- ingress_mirror
>>> +| | +-- mac_anti_spoof
>>> +| | +-- vlan_anti_spoof
>>> +| | +-- loopback
>>> +| | +-- mac
>>> +| | +-- mac_list
>>> +| | +-- promisc
>>> +| | +-- vlan_strip
>>> +| | +-- stats
>>> +| | +-- link_state
>>> +| | +-- max_tx_rate
>>> +| | +-- min_tx_rate
>>> +| | +-- spoofcheck
>>> +| | +-- trust
>>> +| | +-- vlan
>>> +
>>> +.. [1] kobject started from ?sriov? is not available from existing
>>> kernel
>>> +   sysfs, and it requires device driver to implement this
>>> interface.
>>> +.. [2] assume maximum # of VF supported by a PF is 128. To support
>>> a device
>>> +   that supports more than 128 SR-IOV instances, a ?vfx? is added
>>> to 0..127.
>>> +   With ?vfx? kboject, users need to add vf index as the first
>>> parameter and
>>> +   followed by ?:?.
>>
>> Is this sysfs mgmt interface and patch targeted for upstream iavf?
> 
> I confirmed with validation that the sysfs mgmt interface was already
> upstream in the kernel before adding the existing documentation.

Isn't this the VF daemon interface that is supposed to be only an out of 
tree solution?
I don't see this sysfs support atleast in the i40e PF driver upstream.

-Sridhar

> 
