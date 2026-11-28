Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151D7606A31C
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Nov 2026 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=FfWosKab;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vBSk7A04
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E768D81076;
	Sat, 28 Nov 2026 13:36:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7hkaKPFSCE_U; Sat, 28 Nov 2026 13:36:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 119118108F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795873002;
	b=LoRSSbLtZeZICwWRBvN+iOmg7KpRzzZWVhk3eDDA2cmVgyDfeS+qc6UJmaCcP/hxSboW
	 Wpwk6TKjIeJdMLNohP5T1jVwalB11HebdUM9lPDSx6f7I0Zep2vCSu+lt9tqOZM+8ch45
	 P/VIhbCvouH5+YR5s45f74qXlJqcuTBzWbz55wiZ/VU/HWARVsw9AkBtFy3LWzgBxh18Q
	 YPdJMDhdvtxCxgbTqRGPHP7bWs32bCpwf18oSvAL2DWUEDHyb/quAsIfrseZHl/KkXGr8
	 GSLSk4s+yzH1zSTDtnd+asl9dgQ+0m4GRAn3eUyOevIVZsOsqVynYKJwHUBj3QCCbEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795873002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a5WxxRcYdBHgsweyummlp7eYA7vC+58yNVZbC9L/D58=;
	b=WkHMmhB/A/psZJyVcFF1H7pfOBIgjjAyDN0vuNMG5QDlWgSeEAAeyH3C/FfqopoOLAy9
	 hi4Pl7pkIwwhZ2VGCSbAxaOoeiALOr75o8q1ybDa0/XI1a7j1mYf3L6YW1RSO1maC56Ll
	 OkyuJIc/538MiR0h0MZl1v+4Sp0MSV77Gp2AUocYelwuwEx1/HdUEnuNq8IvTZkPDXIX8
	 sCOYDvK/R7Ni22OxnZlL8iMqa29Szjh78YfPv96LgKMruNTi4hmVQ24j31AgXEblORmg/
	 p4rCbwPlx5/c6k90CQBmm5YFO3phY6yoWlipbhQxuplVg6EPjOWj4OgzPj4neFOr59w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795873002;
	bh=a5WxxRcYdBHgsweyummlp7eYA7vC+58yNVZbC9L/D58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FfWosKabS9+kofDcX68zKhpcZnzuM9AGEZk4aD9cNghfgumOKkJPWt+WrgScQZRYr
	 5vVzZHb+lZKK4S4sAEOO2oGUvXUny8QUXHX0v6RTG1YCB/2hf0Yuidk1VPkH3BPYxu
	 pEZlm/U6A2pXBC4qP8EQFhU4/nWUYaQXQvqwXd5I/Yrctz7Sybe5bW4m/j4l9q534S
	 wuKTzFuUmBKzUqrYKzso1MIeiZTEtUhdhbFCJZnOOjnueZuDatC5ftF71tYSzhDhOj
	 ijlxuVvm1noabJd4oqmL6ftduy20kgG7ht/OxJBNqY9LpClwP622GvAy2CPQZRtSZF
	 upqE7/CIhdL0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 119118108F;
	Sat, 28 Nov 2026 13:36:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C7073C0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79E0C6063A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:36:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nBFK3N5M19gR for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Nov 2026 13:36:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E5E160635
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=janislacis06@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=vBSk7A04
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E5E160635
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:36:38 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4ac109a8a12so5301687f8f.3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 05:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795872997; x=1796477797; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a5WxxRcYdBHgsweyummlp7eYA7vC+58yNVZbC9L/D58=;
 b=vBSk7A04OQrM+egUW080MBYHWhZ4o3cdfVa75Y1SkJm0RXlOqiaVt5ix+ZAVhTPC/u
 igIquOA20A8KttyMZ2N8qepr5GaR2KufKf1l/YHYL8TAhsz6vWRpJqMcpo49g8bAgqX6
 SK1eCJI1zB++qlm6FRWemYl8hRuz3tSovobHyqufEaRWCSPg00CHpsSF/JgNeK7dxURZ
 jMVOFOg9810PPe8GH+8RMkf/bP+8z8SiSFG/Oeg7vkY4N+09KktWBmvhVZO/3/usBGYH
 VKyySkUinGcFJTAH6oDQqvLdXMa8RQNzR1Lcrf/8WwPdhhJD0pICtar2vRaTEtVn/EwP
 A7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795872997; x=1796477797;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a5WxxRcYdBHgsweyummlp7eYA7vC+58yNVZbC9L/D58=;
 b=UfFKUJL3rn91P/qIAkMMtS8wwUdCmVzwA2KycRuleHLRiziXBgB7IXgSjIgY4WowOz
 GsbgCTE06zEQHAXQOdPPd6DdFnFUDSgDLdbJdptNeIVLDJ49OyOb3R9Rsn55p7qoaHfh
 J3zMyYRprx78lg7GkkJgBtXa8jOHekJOsFFIsykj5rbLKxZSx6+p481Rh2aLXFkZJK6N
 BXUp54+3vhryXeatb9UMxyI5UHX/sCVg/pMw688pn/L9uQS53KWOu7FFTq4zB1UWezXd
 W1moNyWEW1HJvFWiewyacLmVXja5uMAA6hBWxS/hCXXv+gSzp0u9vSzlGkc3ql7+WBpN
 ZDfg==
X-Gm-Message-State: APuU4Z8Ae2KIdylUmMB5ETJyVt4RKeS1+kQ5fGmnaPf9ON9512NERpsi
 FxOTNI4QX5zVqmm7S5JjhTw9nkv1PQfySQzqZpfXaoXjMrxKL/7w3GTm
X-Gm-Gg: AZFdTZfe4PLA0KtQU7r393TR+4mc5YljuWOu9DOpKCYx1u5xNkm3wL5BSnNhbQcNLYg
 tazAGRxoZk+SrmN6OGrPxSiuBa+ScvMhnrpmrc/i//rqflgYBdUoX7hQAHrEHHiYPsMuJhQMwoT
 wTzvs7F36LDvfRylJnACHk2muB85znG41ANYTodu8wRMp+CiHO7NfWUpnTIFk/P1PECJU909XfT
 bI0EwdeaUouxlz8GvNxMLYXLwMd0pWczIEtqKM7uP4TDuYWhG4yklFzz+uux+q0PZHsfmPUDk0k
 uDaPTsjNcHMmNwPjYNK5j1wC78/By4CLk4Zv94MpYavXrrgwLkAQarfxXMrSV9AD7m7y0JAvjnW
 DhYhDIjICLm3Zn+S0drg7dpo0QCTI4uNpXs4vZinDmW61NJZIdV5kSnQDUO19PLbhWRXsqmwfTo
 IWzbQE5qxOzZfHwmpxkFQc6I5OSozk56WWMKltuCmPeCbASsCpupVA1F7pOLUj99U2cmfomEbdJ
 yrXJmCddH9AY4b/zRLxlYDN/yI7w2TDHFu0VHxyZQyfSw8kkD5ty+L8S12VoCVxQHbKAhRzJw+y
 xB1D2dT1ifUzqG8iatrDPWC166SXuVEq5vz+FxHnqv5+RZJuVd3yGOvs5u4dc8I8uxenJ3YOWZk
 A2xo19rwUI0ZnragdGkts72Xr09nXRsGZ8+M=
X-Received: by 2002:a5d:64c9:0:b0:4a6:bc53:2478 with SMTP id
 ffacd0b85a97d-4abb0d5256fmr54313922f8f.13.1795872996813; 
 Sat, 28 Nov 2026 05:36:36 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c61f558sm54895678f8f.58.2026.11.28.05.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:36:36 -0800 (PST)
Date: Sat, 28 Nov 2026 15:36:33 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5 1/6] igb: don't touch rings that don't exist when
 disabling an XSK pool
Message-ID: <qyifvivvv45lstdhummsoji6jdlgxzkfcai5uet53w2spppj6g@amdcea4m54w5>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
 <20261124235723.1135808-2-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124235723.1135808-2-antonio@mandelbit.com>
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25 Nov 00:57, Antonio Quartulli wrote:
>xsk_get_pool_from_qid() checks the queue id against the stack's real
>queue counts, which can be higher than the number of rings the device
>has: on 82576, enabling VFs leaves a single Tx queue while keeping two
>Rx queues, and igb can fall back from MSI-X to MSI with a single queue
>on resume. Disabling the pool of such a queue, e.g. one bound to queue 1
>before enabling VFs, then passes a NULL Tx ring to
>igb_txrx_ring_disable().
>
>Only disable and re-enable the rings the device has: skip the queue if
>it has no Rx ring, and only the Tx part if it has no Tx ring, so that
>an Rx ring using the pool still stops using it. This also stops a NULL
>dereference when the socket is closed while the device is runtime
>suspended, which frees its rings.
>
>Tested with the 82576 emulated by QEMU and a zero-copy AF_XDP socket on
>queue 1: closing it after enabling a VF no longer oopses and the Rx ring
>no longer references the pool afterwards (checked with a debug print, as
>QEMU doesn't spread traffic over the PF queues with VFs), and without
>VFs queue 1 keeps receiving after the close. Not run under KASAN.
>
>Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
>Cc: stable@vger.kernel.org # 6.14+
>Link: https://lore.kernel.org/netdev/20261116153041.3002666-2-antonio@mandelbit.com/
>Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
>---
>v5: the message also mentions the runtime suspended case (no code
>changes)
>v4: also handle queues with an Rx but no Tx ring, as with VFs (Sashiko):
>tear down the Rx ring and skip only the Tx part; tested with a
>zero-copy AF_XDP socket; subject was "don't disable rings that don't exist
>..."
>v3: new patch.
>
> drivers/net/ethernet/intel/igb/igb_xsk.c | 37 +++++++++++++++++-------
> 1 file changed, 26 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
>index ce4a7b5..3b4212a 100644
>--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
>+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
>@@ -31,15 +31,22 @@ static int igb_realloc_rx_buffer_info(struct igb_ring *ring, bool pool_present)
> 	return 0;
> }
>
>+/* With VFs, the device has a single Tx queue but can have more Rx queues */
>+static struct igb_ring *igb_xsk_tx_ring(struct igb_adapter *adapter, u16 qid)
>+{
>+	return qid < adapter->num_tx_queues ? adapter->tx_ring[qid] : NULL;
>+}
>+
> static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
> {
>-	struct igb_ring *tx_ring = adapter->tx_ring[qid];
>+	struct igb_ring *tx_ring = igb_xsk_tx_ring(adapter, qid);
> 	struct igb_ring *rx_ring = adapter->rx_ring[qid];
> 	struct e1000_hw *hw = &adapter->hw;
>
>-	set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
>-
>-	wr32(E1000_TXDCTL(tx_ring->reg_idx), 0);
>+	if (tx_ring) {
>+		set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
>+		wr32(E1000_TXDCTL(tx_ring->reg_idx), 0);
>+	}
> 	wr32(E1000_RXDCTL(rx_ring->reg_idx), 0);
>
> 	synchronize_net();
>@@ -47,24 +54,27 @@ static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
> 	/* Rx/Tx share the same napi context. */
> 	napi_disable(&rx_ring->q_vector->napi);
>
>-	igb_clean_tx_ring(tx_ring);
>+	if (tx_ring) {
>+		igb_clean_tx_ring(tx_ring);
>+		memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
>+	}
> 	igb_clean_rx_ring(rx_ring);
>-
> 	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
>-	memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
> }
>
> static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
> {
>-	struct igb_ring *tx_ring = adapter->tx_ring[qid];
>+	struct igb_ring *tx_ring = igb_xsk_tx_ring(adapter, qid);
> 	struct igb_ring *rx_ring = adapter->rx_ring[qid];
>
>-	igb_configure_tx_ring(adapter, tx_ring);
>+	if (tx_ring)
>+		igb_configure_tx_ring(adapter, tx_ring);
> 	igb_configure_rx_ring(adapter, rx_ring);
>
> 	synchronize_net();
>
>-	clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
>+	if (tx_ring)
>+		clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
>
> 	/* call igb_desc_unused which always leaves
> 	 * at least 1 descriptor unused to make sure
>@@ -148,7 +158,12 @@ static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
> 		return -EINVAL;
>
> 	rx_ring = adapter->rx_ring[qid];
>-	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
>+	/* The stack can know more queues than the device has, e.g. after a
>+	 * fallback to fewer queues on resume: skip the rings it doesn't have.
>+	 */
>+	if_running = netif_running(adapter->netdev) &&
>+		     igb_xdp_is_enabled(adapter) &&
>+		     qid < adapter->num_rx_queues;
> 	if (if_running)
> 		igb_txrx_ring_disable(adapter, qid);
>
>-- 
>2.56.1
>
Reviewed-by: Janis Edvarts Lacis <janislacis06@gmail.com>
