From: Benjamin Poirier <benjamin.poirier@gmail.com>
Date: Fri, 19 Jan 2018 14:36:52 +0900
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
In-Reply-To: <alpine.DEB.2.10.1801181835490.23969@shri-linux.eng.vmware.com>
References: <20180118065054.29844-1-bpoirier@suse.com>
 <20180118072741.hlkepaeibppz7uih@f1.synalogic.ca>
 <alpine.DEB.2.10.1801181835490.23969@shri-linux.eng.vmware.com>
Message-ID: <20180119053652.77zlafisweg2ar74@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/01/18 18:42, Shrikrishna Khare wrote:
> 
> 
> On Thu, 18 Jan 2018, Benjamin Poirier wrote:
> 
> > On 2018/01/18 15:50, Benjamin Poirier wrote:
> > > It was reported that emulated e1000e devices in vmware esxi 6.5 Build
> > > 7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid receiver
> > > overrun interrupt bursts", v4.15-rc1). Some tracing shows that after
> > > e1000e_trigger_lsc() is called, ICR reads out as 0x0 in e1000_msix_other()
> > > on emulated e1000e devices. In comparison, on real e1000e 82574 hardware,
> > > icr=0x80000004 (_INT_ASSERTED | _OTHER) in the same situation.
> > > 
> > > Some experimentation showed that this flaw in vmware e1000e emulation can
> > > be worked around by not setting Other in EIAC. This is how it was before
> > > 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1).
> > 
> > vmware folks, please comment.
> 
> Thank you for bringing this to our attention.
> 
> Using the reported build (ESX 6.5, 7526125) and 4.15.0-rc8+ kernel (which 
> has the said patch), I could bring up e1000e interface (version: 3.2.6-k),
> get dhcp address and even do large file downloads without difficulty.
> 
> Could you give us more pointers on how we may be able to reproduce this 
> locally? Was there anything different with the configuration when the 
> issue was observed? Is the issue consistently reproducible?

It's consistently reproducible, however I noticed that once in a while
there is a genuine "Other" interrupt that comes in and triggers the link
status change. The problem is with interrupts that are triggered via a
write to ICS (such as in e1000e_trigger_lsc()). Can you reproduce a
problem if you do:
	ip link set ethX down
	ip link set ethX up

If you're building your own kernel, you can add the following patch and
cat /sys/kernel/debug/tracing/trace_pipe

For me it shows on v4.15-rc8:
           <...>-2578  [000] .... 83527.938321: e1000e_trigger_lsc: trigger_lsc
           <...>-2578  [000] d.h. 83527.938398: e1000_msix_other: icr 0x0

With the patch that I submitted, it shows:
         wickedd-1329  [002] .N..    20.123545: e1000e_trigger_lsc: trigger_lsc
          <idle>-0     [000] d.h.    20.123630: e1000_msix_other: icr 0x81000004
          <idle>-0     [000] d.h.    20.123654: e1000_msix_other: lsc
          <idle>-0     [000] d.h.    20.123676: e1000_msix_other: mod_timer


diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 9f18d39bdc8f..16620ce840fc 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1918,22 +1918,29 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
 	bool enable = true;
 
 	icr = er32(ICR);
+	trace_printk("icr 0x%x\n", icr);
+
 	if (icr & E1000_ICR_RXO) {
+		trace_printk("rxo\n");
 		ew32(ICR, E1000_ICR_RXO);
 		enable = false;
 		/* napi poll will re-enable Other, make sure it runs */
 		if (napi_schedule_prep(&adapter->napi)) {
+			trace_printk("napi schedule\n");
 			adapter->total_rx_bytes = 0;
 			adapter->total_rx_packets = 0;
 			__napi_schedule(&adapter->napi);
 		}
 	}
 	if (icr & E1000_ICR_LSC) {
+		trace_printk("lsc\n");
 		ew32(ICR, E1000_ICR_LSC);
 		hw->mac.get_link_status = true;
 		/* guard against interrupt when we're going down */
-		if (!test_bit(__E1000_DOWN, &adapter->state))
+		if (!test_bit(__E1000_DOWN, &adapter->state)) {
+			trace_printk("mod_timer\n");
 			mod_timer(&adapter->watchdog_timer, jiffies + 1);
+		}
 	}
 
 	if (enable && !test_bit(__E1000_DOWN, &adapter->state))
@@ -4221,6 +4228,8 @@ static void e1000e_trigger_lsc(struct e1000_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
 
+	trace_printk("trigger_lsc\n");
+
 	if (adapter->msix_entries)
 		ew32(ICS, E1000_ICS_LSC | E1000_ICS_OTHER);
 	else
