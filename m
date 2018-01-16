From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 16 Jan 2018 11:20:51 -0800
Subject: [Intel-wired-lan] [PATCH 1/2] fm10k: fix function doxygen comments
Message-ID: <20180116192052.7451-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Several function header comments had incorrect function parameter
definitions. Recent versions of the upstream kernel have started to warn
about these issues. Fix up the comments which do not match in order to
resolve these new warnings.

While fixing these, update the copyright year also.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Normally wouldn't necessarily bother fixing these until we actually fix
the function, but they are causing warnings on W=1 when using newer
compilers.

 drivers/net/ethernet/intel/fm10k/fm10k_common.c |  5 +++--
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 10 +++++-----
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c    | 11 ++++++-----
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c     |  4 ++--
 drivers/net/ethernet/intel/fm10k/fm10k_tlv.c    |  7 ++++---
 5 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_common.c b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
index 736a9f087bc9..c58a5377a287 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_common.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
@@ -1,5 +1,5 @@
 /* Intel(R) Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2017 Intel Corporation.
+ * Copyright(c) 2013 - 2018 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -262,6 +262,7 @@ s32 fm10k_stop_hw_generic(struct fm10k_hw *hw)
  *  fm10k_read_hw_stats_32b - Reads value of 32-bit registers
  *  @hw: pointer to the hardware structure
  *  @addr: address of register containing a 32-bit value
+ *  @stat: pointer to structure holding hw stat information
  *
  *  Function reads the content of the register and returns the delta
  *  between the base and the current value.
@@ -281,6 +282,7 @@ u32 fm10k_read_hw_stats_32b(struct fm10k_hw *hw, u32 addr,
  *  fm10k_read_hw_stats_48b - Reads value of 48-bit registers
  *  @hw: pointer to the hardware structure
  *  @addr: address of register containing the lower 32-bit value
+ *  @stat: pointer to structure holding hw stat information
  *
  *  Function reads the content of 2 registers, combined to represent a 48-bit
  *  statistical value. Extra processing is required to handle overflowing.
@@ -461,7 +463,6 @@ void fm10k_update_hw_stats_q(struct fm10k_hw *hw, struct fm10k_hw_stats_q *q,
 
 /**
  *  fm10k_unbind_hw_stats_q - Unbind the queue counters from their queues
- *  @hw: pointer to the hardware structure
  *  @q: pointer to the ring of hardware statistics queue
  *  @idx: index pointing to the start of the ring iteration
  *  @count: number of queues to iterate over
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index a38ae5c54da3..75c99aed3c41 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1,5 +1,5 @@
 /* Intel(R) Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2017 Intel Corporation.
+ * Copyright(c) 2013 - 2018 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -486,7 +486,7 @@ static void fm10k_insert_tunnel_port(struct list_head *ports,
 
 /**
  * fm10k_udp_tunnel_add
- * @netdev: network interface device structure
+ * @dev: network interface device structure
  * @ti: Tunnel endpoint information
  *
  * This function is called when a new UDP tunnel port has been added.
@@ -518,8 +518,8 @@ static void fm10k_udp_tunnel_add(struct net_device *dev,
 
 /**
  * fm10k_udp_tunnel_del
- * @netdev: network interface device structure
- * @ti: Tunnel endpoint information
+ * @dev: network interface device structure
+ * @ti: Tunnel end point information
  *
  * This function is called when a new UDP tunnel port is deleted. The freed
  * port will be removed from the list, then we reprogram the offloaded port
@@ -803,7 +803,7 @@ int fm10k_queue_vlan_request(struct fm10k_intfc *interface,
  * @glort: the target glort for this update
  * @addr: the address to update
  * @vid: the vid to update
- * @sync: whether to add or remove
+ * @set: whether to add or remove
  *
  * This function queues up a MAC request for sending to the switch manager.
  * A separate thread monitors the queue and sends updates to the switch
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index a434fecfdfeb..d7aad4cb73a7 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1,5 +1,5 @@
 /* Intel(R) Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2017 Intel Corporation.
+ * Copyright(c) 2013 - 2018 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -211,7 +211,7 @@ static void fm10k_start_service_event(struct fm10k_intfc *interface)
 
 /**
  * fm10k_service_timer - Timer Call-back
- * @data: pointer to interface cast into an unsigned long
+ * @t: pointer to timer data
  **/
 static void fm10k_service_timer(struct timer_list *t)
 {
@@ -649,7 +649,7 @@ void fm10k_update_stats(struct fm10k_intfc *interface)
 
 /**
  * fm10k_watchdog_flush_tx - flush queues on host not ready
- * @interface - pointer to the device interface structure
+ * @interface: pointer to the device interface structure
  **/
 static void fm10k_watchdog_flush_tx(struct fm10k_intfc *interface)
 {
@@ -679,7 +679,7 @@ static void fm10k_watchdog_flush_tx(struct fm10k_intfc *interface)
 
 /**
  * fm10k_watchdog_subtask - check and bring link up
- * @interface - pointer to the device interface structure
+ * @interface: pointer to the device interface structure
  **/
 static void fm10k_watchdog_subtask(struct fm10k_intfc *interface)
 {
@@ -703,7 +703,7 @@ static void fm10k_watchdog_subtask(struct fm10k_intfc *interface)
 
 /**
  * fm10k_check_hang_subtask - check for hung queues and dropped interrupts
- * @interface - pointer to the device interface structure
+ * @interface: pointer to the device interface structure
  *
  * This function serves two purposes.  First it strobes the interrupt lines
  * in order to make certain interrupts are occurring.  Secondly it sets the
@@ -1995,6 +1995,7 @@ void fm10k_down(struct fm10k_intfc *interface)
 /**
  * fm10k_sw_init - Initialize general software structures
  * @interface: host interface private structure to initialize
+ * @ent: PCI device ID entry
  *
  * fm10k_sw_init initializes the interface private data structure.
  * Fields are initialized based on PCI device information and
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index d6406fc31ffb..bee192fe2ffb 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1,5 +1,5 @@
 /* Intel(R) Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2017 Intel Corporation.
+ * Copyright(c) 2013 - 2018 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -1180,7 +1180,7 @@ s32 fm10k_iov_msg_msix_pf(struct fm10k_hw *hw, u32 **results,
 
 /**
  * fm10k_iov_select_vid - Select correct default VLAN ID
- * @hw: Pointer to hardware structure
+ * @vf_info: pointer to VF information structure
  * @vid: VLAN ID to correct
  *
  * Will report an error if the VLAN ID is out of range. For VID = 0, it will
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c b/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c
index f8e87bf086b9..9d0d31da426b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c
@@ -1,5 +1,5 @@
 /* Intel(R) Ethernet Switch Host Interface Driver
- * Copyright(c) 2013 - 2016 Intel Corporation.
+ * Copyright(c) 2013 - 2018 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -120,6 +120,7 @@ static s32 fm10k_tlv_attr_get_null_string(u32 *attr, unsigned char *string)
  *  @msg: Pointer to message block
  *  @attr_id: Attribute ID
  *  @mac_addr: MAC address to be stored
+ *  @vlan: VLAN to be stored
  *
  *  This function will reorder a MAC address to be CPU endian and store it
  *  in the attribute buffer.  It will return success if provided with a
@@ -155,8 +156,8 @@ s32 fm10k_tlv_attr_put_mac_vlan(u32 *msg, u16 attr_id,
 /**
  *  fm10k_tlv_attr_get_mac_vlan - Get MAC/VLAN stored in attribute
  *  @attr: Pointer to attribute
- *  @attr_id: Attribute ID
  *  @mac_addr: location of buffer to store MAC address
+ *  @vlan: location of buffer to store VLAN
  *
  *  This function pulls the MAC address back out of the attribute and will
  *  place it in the array pointed by by mac_addr.  It will return success
@@ -549,7 +550,7 @@ static s32 fm10k_tlv_attr_parse(u32 *attr, u32 **results,
  *  @hw: Pointer to hardware structure
  *  @msg: Pointer to message
  *  @mbx: Pointer to mailbox information structure
- *  @func: Function array containing list of message handling functions
+ *  @data: Pointer to message handler data structure
  *
  *  This function should be the first function called upon receiving a
  *  message.  The handler will identify the message type and call the correct
-- 
2.15.1.478.ga1e07cd25f8b

