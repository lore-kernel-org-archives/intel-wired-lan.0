Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609960A2629
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=rKg7/VNG;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zlvkdj65
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8489D40E1E;
	Fri, 20 Nov 2026 11:10:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CHQGBSoma6pU; Fri, 20 Nov 2026 11:10:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5E8AC40E10
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795173057;
	b=PghaUZfLEXyN9QB63L578RGKbnVjoQXTlGg/zyZkIFNf/hAT1I8NyHm94ZC9CP4yHP2Z
	 7KgcckotfoeXkKVlrl4L4cirN8A7OGB0nGJzzRBT7Dy+8R2oJJS83FmkQsSqy3Uahw0kO
	 8dwhb5yurTHyoifyqRcRhjcN1lUoaawL95onc9A7EiXLTnuq7hP5A+zGTi5ZitDGh7l/n
	 8F31//suhdfXcwXCtnzlUEtoeAhbbQ068nYXa8OYevJQLYQ+DgFWV0H0EzBnwZpd8aGCt
	 c7U6Q6qoFX1JYIZ62fDe87TEWpata+wcUktkJQuUE6jyKIBWKUuJXhWp5AdseZzlE7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795173057;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=oCOtIdvLKf2/wzqaojXGub0GeIKIVyoMMlNfwp4jvZo=;
	b=iiS18lHsMfLVi7QeQoIWESYF/G14klnYM54bpv3ll9tcD2FleSiOGiE5Jt42SbBUnw/e
	 iid0TXkuOoJ7VBozAhKgXYyDTxf46lboyS2HofP3wyNKnWCMsprQ0zwWTkh2jppN2RLES
	 LBEhzZHy0V3jHxvRHyNa9oxMVQfgvkndZKl4v0FmO2n2Ek0lCJ5JFSCKp/ZMgUVe1td11
	 6fki0zn0amPOxuxOnHm7SBOcwufyGFU5sBO7DMi5/gkeJXf2fcnjt3VwyvrEq4p34uSAj
	 Tbyg865UtkPJyk+xEUjmWDwBkpHdmBPhpeE70FhNCipzPAPtioL6Omu07dWlcSf/VRw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795173057;
	bh=oCOtIdvLKf2/wzqaojXGub0GeIKIVyoMMlNfwp4jvZo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=rKg7/VNG9J9kUwau/SiThD4v4+4XnWqyjKJYlvoOV8vZiHKcOdcjqD+iGspSc6TkQ
	 MX3M/x/6k9q9g2rVgPFfu6h3MS8n8Kv7AAlvt/Zp6W6bNbe8zEVIH15Vd/G1ZMN7gB
	 fnObH0+U694LU2PBSJg5IgLXHX77dUbjvwaARgwEZd+H+KueHs4EakVcdhGoY0Q1jV
	 K9UAK27lAmMkVzgl4tha5Qyej9zwP2Gi56Js6y3MNTQHw4V4oMJ3c491GjtYNAY2FI
	 5GWjdaG9+xfFgJGAOtGuvQzA91hWeMDf5t/HIczpy6MC3V3HYdliA9StPtiLe3MKf+
	 Ms2C5JUdbRc0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E8AC40E10;
	Fri, 20 Nov 2026 11:10:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C4CAE5E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:10:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E6436072E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:10:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZNw-icO0PzCs for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 11:10:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AE98860752
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+tkusters.aweta.nl@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Zlvkdj65
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE98860752
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 11:10:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5640943862;
 Fri, 20 Nov 2026 11:10:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id EC94C1F000E6;
 Fri, 20 Nov 2026 11:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795173052;
 bh=oCOtIdvLKf2/wzqaojXGub0GeIKIVyoMMlNfwp4jvZo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Zlvkdj65nbLBAkxd8I8jM2rtgr7R6SqsG8lixW8ZuFyZ7k49Mq0PTqXb5Hq4L4mW/
 WT5bgJjWgC7jr7GGy8dWkk2aULd3m/GKPVks9ZWf6T7CPhLZKMb74iJCjeLwInCILo
 WtfcrxbB0aFLNohi9tX8aCxrrMVF1GBeIyRE8B+CsHSQOCeFOkHdvEoXyD3cueszUJ
 jGYmcmAiYPLHwgeS0sGYq3mDkvHvwp4EC/sv15b5JDmBXUoHvZRsjWigwG/w9PkY6x
 9CopiX79VdRXdIA1r4lOUl9wTupkZm8wIUYLVbdiJogbfpQoB0pBLdpPIJaszyMien
 i7gWOo8qK1ObQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7CEAF49832;
 Fri, 20 Nov 2026 11:10:40 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Fri, 20 Nov 2026 12:10:38 +0100
Subject: [PATCH net v7 1/3] igb: do not let XDP frames span more than one
 Rx buffer
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-igb-rx-ts-fix-v7-1-63b03045978e@aweta.nl>
References: <20261120-igb-rx-ts-fix-v7-0-63b03045978e@aweta.nl>
In-Reply-To: <20261120-igb-rx-ts-fix-v7-0-63b03045978e@aweta.nl>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Sven Auhagen <sven.auhagen@voleatech.de>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Paul Moses <p@1g4.org>, 
 stable@vger.kernel.org, Tjerk Kusters <tkusters@aweta.nl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795173039; l=15756;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=7M2S2saoF43jPXPM/mX4wW0lZibnTm3/rakb3CkJ9uY=;
 b=SUUON97MeqkZgQ1hDDWSpttarzJB7Ao/d/ge2HGsigZI/CTyCEZMmHEDiQG53Qo/342p10c/k
 5Wzq6UQjbZaA4tv4ncfkzO7ARpZRQWK8fzlt2gSepQcBxoRve/5P183
X-Developer-Key: i=tkusters@aweta.nl; a=ed25519;
 pk=JYRpYQ3+LrphEabgnxcbiOUpwvNP8WDDMcLzz+cwKsk=
X-Endpoint-Received: by B4 Relay for tkusters@aweta.nl/20260619 with
 auth_id=831
X-Original-From: Tjerk Kusters <tkusters@aweta.nl>
Content-Transfer-Encoding: 7bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Reply-To: tkusters@aweta.nl
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tjerk Kusters <tkusters@aweta.nl>

igb does not support XDP multi-buffer: igb_xdp_setup() only accepts an
MTU whose frame fits in one Rx buffer, and the XDP program only sees
the first buffer of a frame. The maximum receive length is not limited
accordingly, though. RLPML is only lowered when the frame fits a
build_skb buffer on systems with PAGE_SIZE < 8192 and no VFs. Otherwise
the MAC still accepts frames of up to MAX_JUMBO_FRAME_SIZE while XDP is
attached, for example at MTU 3000 on 3 KiB buffers, and at any MTU when
PAGE_SIZE >= 8192. With VFs allocated, RLPML always stays at
MAX_JUMBO_FRAME_SIZE and the PF pool limit in VMOLR is only lowered for
frames that fit a build_skb buffer, so the same happens at MTU 3000.

Such frames span several descriptors. When the program does not return
XDP_PASS for the first buffer, no skb is built, and igb_clean_rx_irq()
handles the next buffer of the same frame as the start of a new frame:
it runs the program on it and may pass it to the stack as a bogus frame
made from the middle of the original payload.

Limit the receive length to the configured maximum frame size while XDP
is attached: in RLPML when no VFs are allocated, and in the PF pool's
VMOLR otherwise, as RLPML then has to stay large for the VFs. Larger
frames are dropped by the MAC.

Also make sure that the limit holds:

- Leave room for the inline Rx timestamp header when checking that the
  frame fits in one Rx buffer, on XDP setup and on MTU change, where the
  limit is the hardware buffer size. This lowers the largest MTU
  accepted with XDP by 16 bytes: from 3046 to 3030 on 3 KiB buffers,
  and from 2022 to 2006 with legacy-rx or PAGE_SIZE >= 8192. Setups that
  use XDP at those MTUs will have to lower the MTU. The build_skb frame
  limit used with 2 KiB buffers is kept, so XDP still attaches up to MTU
  1510 on x86. The header is only prepended by 82580 and later MACs; the
  room is reserved on all MACs for simplicity.
- Base that check on the buffer size that igb_set_rx_buffer_len() will
  select, not on the ring flags, which are only updated when the rings
  are configured and can be stale on an interface that is down. As a
  result, an MTU change with XDP attached can now also move from 2 KiB
  to 3 KiB buffers. The check is skipped when XDP is removed.
- Refuse XDP while rx-all is enabled, and keep rx-all off while XDP is
  attached, as the MAC then also stores frames longer than RLPML. If
  rx-all was requested meanwhile, it is turned on when XDP is removed,
  unless the interface could not be opened again. A runtime-suspended
  device is resumed for that first, as ethtool does, and the features
  are left as they are if the resume fails.
- Refuse to change the legacy-rx private flag while XDP is attached, as
  that changes the Rx buffer size without checking it against the MTU.
- Program both limits from igb_configure(), which runs when the
  interface is (re)configured, before Rx is enabled, and no longer from
  igb_set_rx_mode(), which can also run without RTNL, for example on an
  IPv6 multicast join or a VF mailbox request. Otherwise such a call
  during an XDP removal or an MTU change could apply the new limit while
  the rings still use the old buffers.
  Attaching or removing an XDP program on a running interface goes
  through igb_close() and igb_open(), and an MTU change through
  igb_down() and igb_up(), so igb_configure() runs in both cases.
  igb_set_rx_mode() still updates other bits of the PF pool's VMOLR. The
  core calls it under the address lock, so the limit is changed under
  that lock. The VF mailbox path calls it from the interrupt handler
  without the lock, but interrupts are masked while igb_configure()
  runs.

This follows the same approach as the igc fix that limits RLPML while
XDP is attached. igb_set_rx_mode() does not touch VMOLR on i354, but
i354 can have VFs, and then the PF pool limit is the only one. So it is
also written on i354 when VFs are allocated, with or without XDP.

Tested on an I350 at MTU 3000 with Rx timestamping on and xdp-filter
dropping all IPv4 from the peer: 8242-byte frames are now dropped by the
MAC (rx_long_length_errors), instead of their last two buffers being
delivered as a separate frame. XDP attach at MTU 1500 and 3030 still
works, at MTU 3046 it is refused, as is an MTU change from 3030 to 3046
with XDP attached; an MTU change from 1500 to 3000 with XDP attached
now works. With XDP attached, rx-all stays off and the legacy-rx flag
cannot be changed. XDP attach is refused with rx-all on, and at MTU
3000 with legacy-rx on, also when the flag was set while the interface
was down. MTU changes between 1500 and 3000 with XDP attached, while
the peer sent 3000-byte zero-payload frames, let no frame through as a
separate frame. On 7.3.1, removing XDP from a down, runtime-suspended
interface with rx-all requested resumed the device and turned rx-all
on, and the link came up normally afterwards.

With two VFs allocated, the same frames are counted by the MAC but
dropped by the PF pool limit in VMOLR before they reach the Rx queue;
without this patch their last two buffers are again delivered as a
separate frame. Read back from the registers, RLPML then stays at 9728
and the PF pool limit is 3026 at MTU 3000 and 1526 at MTU 1500 with XDP
attached. In repeated runs of about 200 MTU changes each, the limit was
right after every change, except for one read in one run, where the
value was not logged; eleven reruns showed no mismatch.

The i354 path was checked with the driver built so that the I350 takes
the i354 branches for VMOLR. With two VFs and XDP attached, the PF pool
limit kept its old value of 9728 when the VMOLR write was skipped on
i354, and read back as 3026 at MTU 3000 and 1526 at MTU 1500 with this
patch. Only the registers were checked; I have no i354 to test on.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/
Fixes: 9cbc948b5a20 ("igb: add XDP support")
Cc: stable@vger.kernel.org
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c |   9 ++
 drivers/net/ethernet/intel/igb/igb_main.c    | 161 ++++++++++++++++++++-------
 2 files changed, 127 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index f7938c1da835..4f2891fca282 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3438,6 +3438,15 @@ static int igb_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 		flags |= IGB_FLAG_RX_LEGACY;
 
 	if (flags != adapter->flags) {
+		/* the Rx buffer size depends on this flag, see
+		 * igb_xdp_setup()
+		 */
+		if (igb_xdp_is_enabled(adapter)) {
+			netdev_warn(netdev,
+				    "Cannot change legacy-rx while XDP is attached\n");
+			return -EOPNOTSUPP;
+		}
+
 		adapter->flags = flags;
 
 		/* reset interface to repopulate queues */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ce91dda00ec0..5f1a5e2240e6 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1964,6 +1964,57 @@ static void igb_setup_tx_mode(struct igb_adapter *adapter)
 		   "enabled" : "disabled");
 }
 
+/**
+ *  igb_set_rlpml - set the receive length limits
+ *  @adapter: private board structure
+ *
+ *  Called from igb_configure(), before Rx is enabled. igb_set_rx_mode() can
+ *  also run without RTNL, so it does not change these limits.
+ **/
+static void igb_set_rlpml(struct igb_adapter *adapter)
+{
+	u32 rlpml = MAX_JUMBO_FRAME_SIZE, pool_rlpml = MAX_JUMBO_FRAME_SIZE;
+	unsigned int vfn = adapter->vfs_allocated_count;
+	struct e1000_hw *hw = &adapter->hw;
+	u32 vmolr;
+
+#if (PAGE_SIZE < 8192)
+	/* restrict as needed to support build_skb */
+	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB) {
+		pool_rlpml = IGB_MAX_FRAME_BUILD_SKB;
+		if (!vfn)
+			rlpml = IGB_MAX_FRAME_BUILD_SKB;
+	}
+#endif
+	/* XDP does not support frames that span more than one Rx buffer.
+	 * With VFs the global limit stays large and the PF pool is limited
+	 * through VMOLR.
+	 */
+	if (igb_xdp_is_enabled(adapter)) {
+		pool_rlpml = min(pool_rlpml, adapter->max_frame_size);
+		if (!vfn)
+			rlpml = min(rlpml, adapter->max_frame_size);
+	}
+	wr32(E1000_RLPML, rlpml);
+
+	/* the PF pool's VMOLR is used on these MACs, see igb_set_rx_mode(),
+	 * and with VFs it carries the only limit for the PF, also on i354
+	 */
+	if (hw->mac.type < e1000_82576 ||
+	    (hw->mac.type > e1000_i350 && !vfn))
+		return;
+
+	/* igb_set_rx_mode() also updates this register, and the core calls
+	 * it under the address lock
+	 */
+	netif_addr_lock_bh(adapter->netdev);
+	vmolr = rd32(E1000_VMOLR(vfn));
+	vmolr &= ~E1000_VMOLR_RLPML_MASK;
+	vmolr |= pool_rlpml | E1000_VMOLR_LPE;
+	wr32(E1000_VMOLR(vfn), vmolr);
+	netif_addr_unlock_bh(adapter->netdev);
+}
+
 /**
  *  igb_configure - configure the hardware for RX and TX
  *  @adapter: private board structure
@@ -1981,6 +2032,7 @@ static void igb_configure(struct igb_adapter *adapter)
 
 	igb_setup_tctl(adapter);
 	igb_setup_mrqc(adapter);
+	igb_set_rlpml(adapter);
 	igb_setup_rctl(adapter);
 
 	igb_nfc_filter_restore(adapter);
@@ -2468,6 +2520,14 @@ void igb_reset(struct igb_adapter *adapter)
 static netdev_features_t igb_fix_features(struct net_device *netdev,
 	netdev_features_t features)
 {
+	struct igb_adapter *adapter = netdev_priv(netdev);
+
+	/* with rx-all the MAC also stores frames longer than RLPML, which
+	 * XDP cannot handle
+	 */
+	if (igb_xdp_is_enabled(adapter))
+		features &= ~NETIF_F_RXALL;
+
 	/* Since there is no support for separate Rx/Tx vlan accel
 	 * enable/disable make sure Tx flag is always in same state as Rx.
 	 */
@@ -2886,6 +2946,27 @@ static int igb_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	}
 }
 
+/* Check that a frame fits in one Rx buffer together with the inline Rx
+ * timestamp header, for the buffer size igb_set_rx_buffer_len() selects.
+ * The ring flags are only updated when the rings are configured, so they
+ * are not used here. For build_skb rings the frame is limited to
+ * IGB_MAX_FRAME_BUILD_SKB, which is below the 2 KiB hardware buffer size
+ * even with the header.
+ */
+static bool igb_xdp_frame_fits(struct igb_adapter *adapter, int max_frame)
+{
+#if (PAGE_SIZE < 8192)
+	if (!(adapter->flags & IGB_FLAG_RX_LEGACY)) {
+		if (max_frame <= IGB_MAX_FRAME_BUILD_SKB &&
+		    !IGB_2K_TOO_SMALL_WITH_PADDING)
+			return true;
+
+		return max_frame + IGB_TS_HDR_LEN <= IGB_RXBUFFER_3072;
+	}
+#endif
+	return max_frame + IGB_TS_HDR_LEN <= IGB_RXBUFFER_2048;
+}
+
 static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	int i, frame_size = dev->mtu + IGB_ETH_PKT_HDR_PAD;
@@ -2893,18 +2974,23 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 	struct bpf_prog *prog = bpf->prog, *old_prog;
 	bool running = netif_running(dev);
 	bool need_reset;
+	int err = 0;
 
-	/* verify igb ring attributes are sufficient for XDP */
-	for (i = 0; i < adapter->num_rx_queues; i++) {
-		struct igb_ring *ring = adapter->rx_ring[i];
+	/* with rx-all the MAC also stores frames longer than RLPML */
+	if (prog && (dev->features & NETIF_F_RXALL)) {
+		NL_SET_ERR_MSG_MOD(bpf->extack, "XDP is not supported with rx-all");
+		return -EOPNOTSUPP;
+	}
 
-		if (frame_size > igb_rx_bufsz(ring)) {
-			NL_SET_ERR_MSG_MOD(bpf->extack,
-					   "The RX buffer size is too small for the frame size");
-			netdev_warn(dev, "XDP RX buffer size %d is too small for the frame size %d\n",
-				    igb_rx_bufsz(ring), frame_size);
-			return -EINVAL;
-		}
+	/* verify igb ring attributes are sufficient for XDP, leaving room
+	 * for the inline Rx timestamp header
+	 */
+	if (prog && !igb_xdp_frame_fits(adapter, frame_size)) {
+		NL_SET_ERR_MSG_MOD(bpf->extack,
+				   "The RX buffer size is too small for the frame size");
+		netdev_warn(dev, "XDP RX buffer size is too small for the frame size %d\n",
+			    frame_size);
+		return -EINVAL;
 	}
 
 	old_prog = xchg(&adapter->xdp_prog, prog);
@@ -2933,7 +3019,20 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 	}
 
 	if (running)
-		igb_open(dev);
+		err = igb_open(dev);
+
+	/* rx-all may have been requested while XDP was attached. A failed
+	 * igb_open() leaves NAPI disabled, so do not reconfigure then. A down
+	 * interface can be runtime suspended; resume it first, as ethtool
+	 * does before it changes features.
+	 */
+	if (!prog && !err && (dev->wanted_features & NETIF_F_RXALL)) {
+		pm_runtime_get_sync(&adapter->pdev->dev);
+		/* still detached if the resume failed */
+		if (netif_device_present(dev))
+			netdev_update_features(dev);
+		pm_runtime_put(&adapter->pdev->dev);
+	}
 
 	return 0;
 }
@@ -5323,7 +5422,7 @@ static void igb_set_rx_mode(struct net_device *netdev)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 	unsigned int vfn = adapter->vfs_allocated_count;
-	u32 rctl = 0, vmolr = 0, rlpml = MAX_JUMBO_FRAME_SIZE;
+	u32 rctl = 0, vmolr = 0;
 	int count;
 
 	/* Check for Promiscuous and All Multicast modes */
@@ -5380,14 +5479,6 @@ static void igb_set_rx_mode(struct net_device *netdev)
 				     E1000_RCTL_VFE);
 	wr32(E1000_RCTL, rctl);
 
-#if (PAGE_SIZE < 8192)
-	if (!adapter->vfs_allocated_count) {
-		if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
-			rlpml = IGB_MAX_FRAME_BUILD_SKB;
-	}
-#endif
-	wr32(E1000_RLPML, rlpml);
-
 	/* In order to support SR-IOV and eventually VMDq it is necessary to set
 	 * the VMOLR to enable the appropriate modes.  Without this workaround
 	 * we will have issues with VLAN tag stripping not being done for frames
@@ -5399,19 +5490,10 @@ static void igb_set_rx_mode(struct net_device *netdev)
 	/* set UTA to appropriate mode */
 	igb_set_uta(adapter, !!(vmolr & E1000_VMOLR_ROPE));
 
+	/* keep the receive length limit set by igb_set_rlpml() */
 	vmolr |= rd32(E1000_VMOLR(vfn)) &
 		 ~(E1000_VMOLR_ROPE | E1000_VMOLR_MPME | E1000_VMOLR_ROMPE);
 
-	/* enable Rx jumbo frames, restrict as needed to support build_skb */
-	vmolr &= ~E1000_VMOLR_RLPML_MASK;
-#if (PAGE_SIZE < 8192)
-	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
-		vmolr |= IGB_MAX_FRAME_BUILD_SKB;
-	else
-#endif
-		vmolr |= MAX_JUMBO_FRAME_SIZE;
-	vmolr |= E1000_VMOLR_LPE;
-
 	wr32(E1000_VMOLR(vfn), vmolr);
 
 	igb_restore_vf_multicasts(adapter);
@@ -6707,19 +6789,12 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int max_frame = new_mtu + IGB_ETH_PKT_HDR_PAD;
 
-	if (igb_xdp_is_enabled(adapter)) {
-		int i;
-
-		for (i = 0; i < adapter->num_rx_queues; i++) {
-			struct igb_ring *ring = adapter->rx_ring[i];
-
-			if (max_frame > igb_rx_bufsz(ring)) {
-				netdev_warn(adapter->netdev,
-					    "Requested MTU size is not supported with XDP. Max frame size is %d\n",
-					    max_frame);
-				return -EINVAL;
-			}
-		}
+	if (igb_xdp_is_enabled(adapter) &&
+	    !igb_xdp_frame_fits(adapter, max_frame)) {
+		netdev_warn(adapter->netdev,
+			    "Requested MTU size is not supported with XDP. Frame size is %d\n",
+			    max_frame);
+		return -EINVAL;
 	}
 
 	/* adjust max frame to be at least the size of a standard frame */

-- 
2.27.0


