From: Corinna Vinschen <vinschen@redhat.com>
Date: Thu, 28 Jan 2016 13:53:23 +0100
Subject: [Intel-wired-lan] [PATCH] igb: Fix VLAN tag stripping on Intel
	i350
In-Reply-To: <1453922722.3014.29.camel@intel.com>
References: <1453901284-32628-1-git-send-email-vinschen@redhat.com>
 <1453922722.3014.29.camel@intel.com>
Message-ID: <20160128125323.GA17357@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeff,

On Jan 27 11:25, Jeff Kirsher wrote:
> On Wed, 2016-01-27 at 14:28 +0100, Corinna Vinschen wrote:
> > Problem: When switching off VLAN offloading on an i350, the VLAN
> > interface gets unusable.? For testing, set up a VLAN on an i350
> > and some remote machine, e.g.:
> > [...]
> I tried applying your patch to my tree for review and validation, but
> due to patches already applied against the igb driver in my tree, your
> patch does not apply cleanly.
> 
> Can you please update your patch to apply cleanly to my tree?
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue
> 
> (next-queue tree and dev-queue branch)

The attached patch is against the dev-queue branch of your next-queue tree.

I retested again using an i350 as well as a 82580.  On the i350 I tested
additionally adding and removing VFs while offloading was switched on or
off, and it worked as desired.

I'm just a bit unsure about the correctness of the igb_set_vf_vlan_strip
call from igb_vf_reset.  I think it's the right thing to do since
resetting the VF requires to reevaluate the STRVLAN flag.  I'd feel
better if you could double check, though.


Thanks,
Corinna
-------------- next part --------------
From ab27415c3d3be2beb978316007f84fb54d12b619 Mon Sep 17 00:00:00 2001
From: Corinna Vinschen <vinschen@redhat.com>
Date: Thu, 28 Jan 2016 13:31:11 +0100
Subject: [PATCH] igb: Fix VLAN tag stripping on Intel i350

Problem: When switching off VLAN offloading on an i350, the VLAN
interface gets unusable.  For testing, set up a VLAN on an i350
and some remote machine, e.g.:

  $ ip link add link eth0 name eth0.42 type vlan id 42
  $ ip addr add 192.168.42.1/24 dev eth0.42
  $ ip link set dev eth0.42 up

Offloading is switched on by default:

  $ ethtool -k eth0 | grep vlan-offload
  rx-vlan-offload: on
  tx-vlan-offload: on

  $ ping -c 3 -I eth0.42 192.168.42.2
  [...works as usual...]

Now switch off VLAN offloading and try again:

  $ ethtool -K eth0 rxvlan off
  Actual changes:
  rx-vlan-offload: off
  tx-vlan-offload: off [requested on]
  $ ping -c 3 -I eth0.42 192.168.42.2
  PING 192.168.42.2 (192.168.42.2) from 192.168.42.1 eth0.42: 56(84) bytes of da
ta.

  --- 192.168.42.2 ping statistics ---
  3 packets transmitted, 0 received, 100% packet loss, time 1999ms

I can only reproduce it on an i350, the above works fine on a 82580.

While inspecting the igb source, I came across the code in igb_set_vmolr
which sets the E1000_VMOLR_STRVLAN/E1000_DVMOLR_STRVLAN flags once and
for all, and in all of the igb code there's no other place where the
STRVLAN is set or cleared.  Thus, VLAN stripping is enabled in igb
unconditionally, independently of the offloading setting.

I compared that to the latest Intel igb-5.3.3.5 driver from
http://sourceforge.net/projects/e1000/ which in fact sets and clears the
STRVLAN flag independently from igb_set_vmolr in its own function
igb_set_vf_vlan_strip, depending on the vlan settings.

So I included the STRVLAN handling from the igb-5.3.3.5 driver into our
current igb driver and tested the above scenario again.  This time ping
still works after switching off VLAN offloading.

Tested on i350, with and without addtional VFs, as well as on 82580
successfully.

Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 41 ++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 95d6042..c414e41 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3699,6 +3699,28 @@ static inline int igb_set_vf_rlpml(struct igb_adapter *adapter, int size,
 	return 0;
 }
 
+static inline void igb_set_vf_vlan_strip(struct igb_adapter *adapter,
+					 int vfn, bool enable)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	u32 val, reg;
+
+	if (hw->mac.type < e1000_82576)
+		return;
+
+	if (hw->mac.type == e1000_i350)
+		reg = E1000_DVMOLR(vfn);
+	else
+		reg = E1000_VMOLR(vfn);
+
+	val = rd32(reg);
+	if (enable)
+		val |= E1000_VMOLR_STRVLAN;
+	else
+		val &= ~(E1000_VMOLR_STRVLAN);
+	wr32(reg, val);
+}
+
 static inline void igb_set_vmolr(struct igb_adapter *adapter,
 				 int vfn, bool aupe)
 {
@@ -3712,14 +3734,6 @@ static inline void igb_set_vmolr(struct igb_adapter *adapter,
 		return;
 
 	vmolr = rd32(E1000_VMOLR(vfn));
-	vmolr |= E1000_VMOLR_STRVLAN; /* Strip vlan tags */
-	if (hw->mac.type == e1000_i350) {
-		u32 dvmolr;
-
-		dvmolr = rd32(E1000_DVMOLR(vfn));
-		dvmolr |= E1000_DVMOLR_STRVLAN;
-		wr32(E1000_DVMOLR(vfn), dvmolr);
-	}
 	if (aupe)
 		vmolr |= E1000_VMOLR_AUPE; /* Accept untagged packets */
 	else
@@ -6217,6 +6231,7 @@ static int igb_enable_port_vlan(struct igb_adapter *adapter, int vf,
 
 	adapter->vf_data[vf].pf_vlan = vlan;
 	adapter->vf_data[vf].pf_qos = qos;
+	igb_set_vf_vlan_strip(adapter, vf, true);
 	dev_info(&adapter->pdev->dev,
 		 "Setting VLAN %d, QOS 0x%x on VF %d\n", vlan, qos, vf);
 	if (test_bit(__IGB_DOWN, &adapter->state)) {
@@ -6244,6 +6259,7 @@ static int igb_disable_port_vlan(struct igb_adapter *adapter, int vf)
 
 	adapter->vf_data[vf].pf_vlan = 0;
 	adapter->vf_data[vf].pf_qos = 0;
+	igb_set_vf_vlan_strip(adapter, vf, false);
 
 	return 0;
 }
@@ -6264,6 +6280,7 @@ static int igb_set_vf_vlan_msg(struct igb_adapter *adapter, u32 *msgbuf, u32 vf)
 {
 	int add = (msgbuf[0] & E1000_VT_MSGINFO_MASK) >> E1000_VT_MSGINFO_SHIFT;
 	int vid = (msgbuf[1] & E1000_VLVF_VLANID_MASK);
+	int ret;
 
 	if (adapter->vf_data[vf].pf_vlan)
 		return -1;
@@ -6272,7 +6289,10 @@ static int igb_set_vf_vlan_msg(struct igb_adapter *adapter, u32 *msgbuf, u32 vf)
 	if (!vid && !add)
 		return 0;
 
-	return igb_set_vf_vlan(adapter, vid, !!add, vf);
+	ret = igb_set_vf_vlan(adapter, vid, !!add, vf);
+	if (!ret)
+		igb_set_vf_vlan_strip(adapter, vf, !!vid);
+	return ret;
 }
 
 static inline void igb_vf_reset(struct igb_adapter *adapter, u32 vf)
@@ -6289,6 +6309,7 @@ static inline void igb_vf_reset(struct igb_adapter *adapter, u32 vf)
 	igb_set_vmvir(adapter, vf_data->pf_vlan |
 			       (vf_data->pf_qos << VLAN_PRIO_SHIFT), vf);
 	igb_set_vmolr(adapter, vf, !vf_data->pf_vlan);
+	igb_set_vf_vlan_strip(adapter, vf, !!(vf_data->pf_vlan));
 
 	/* reset multicast table array for vf */
 	adapter->vf_data[vf].num_vf_mc_hashes = 0;
@@ -7449,6 +7470,8 @@ static void igb_vlan_mode(struct net_device *netdev, netdev_features_t features)
 		ctrl &= ~E1000_CTRL_VME;
 		wr32(E1000_CTRL, ctrl);
 	}
+
+	igb_set_vf_vlan_strip(adapter, adapter->vfs_allocated_count, enable);
 }
 
 static int igb_vlan_rx_add_vid(struct net_device *netdev,
-- 
2.5.0

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160128/6f9d22c0/attachment.asc>
