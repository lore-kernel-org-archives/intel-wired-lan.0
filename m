Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD40606A31E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=9TOdkrIo;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NS5K5G6O
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA8F840659;
	Wed, 25 Nov 2026 09:52:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HeXuWTD1GuB1; Wed, 25 Nov 2026 09:52:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2C2840660
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795600329;
	b=Ya+My+BWJDt5FqWmsw9y1W4eEDuq9nPmCGr8Y4twOrCnvuzfosXmZYFEzeRLP1Dx7wIg
	 CL8ickpjDFz2nX+XYVNgZJ7KWBghlD/Ro9s9axJ3SjN67ePvzY0KpGRCa9dS4+UMzxpwm
	 rI7FhypSUgbmKTd53zs8ZfnsTb9jE5QHN4FQdycBROQwwNXhiF7t4ivWhL/yyiveJkbZB
	 TlWHgmFrtx4iFfnLnT8FZm25+8jJ34H9sRzTNkiSCMVdYTMZd83zttR+ovcIfRW+CLMwk
	 EaiCN1rb8DZTjoC2DF3VzdiwGhffcYfZlqA4cYQ0izbP93S73jVBhDX+9Q/coElE/ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795600329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WXzjn+vyJIpaH9gzDIVnY/hmD1MIvRpuB4YDU1U7djk=;
	b=P2WYOM968CZg5wdHCnsNSGz023DrLAJ5VnjMdlujEYSZmPJ9+q7WEnvK5GB8TKOgBJho
	 FFINxBBbiGFuF0D9veJ4tSkUBKvw4t+HT2omJKASXxqetnYWUS25OQI3MJ5GtuIuTUjZV
	 lRkfAc5xKm9ciSev06+PS4X2t8E223716hi2ssPTr69Y5bcZPLsxj9ZR710T3yttZdpkY
	 E7e94Rg5cOCEUftqJDZI48c5ANGmXD/XzZCAKNfREFXIpXsPhq1ra6EWqiqfu6z05mkK+
	 rM6kidNVYC7OY7JMsXqYvsZcoIZw+wf8iFTFAsW3OsoS7bZxbwcGhcZxFUWl+41hblg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NS5K5G6O;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795600329;
	bh=WXzjn+vyJIpaH9gzDIVnY/hmD1MIvRpuB4YDU1U7djk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=9TOdkrIozkRuwXRzDksC2v7RxfgQLDlV5XPMAf1YTJkR0nlJOp2rRBO4szqlt3f7a
	 0NEOLjuGT2FOdBr0sZskP/Lpn/jxAylVrjhoax+iuL+UchSIBXWwD6iPvvmGSDrDus
	 DxsUyRXSX6YAtELnjkW0tuBuukw7/9AIFeO5KkzEgCNO3pQPD9yCJqTgNraLFLLNYb
	 7YdlIZjQ9pRC70nRec0YIFUc3RgktzmBv3pnw4Wu99dd7k6EF8RbPKRTgrJspnV32z
	 hd3rO/Toe7uo5k1Cucy7GtQoZAq62ARZidLY/lBT7GxZoxPRjmbBxsTU0RQKnq7OHr
	 WYLYvcuYwlVZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2C2840660;
	Wed, 25 Nov 2026 09:52:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A0FE311
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 09:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EFCC140660
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 09:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fcGwJGMRwO0G for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 09:52:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B06CE40659
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=NS5K5G6O
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B06CE40659
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 09:52:07 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b87a92c17eso7774078a12.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 01:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1795600325; x=1796205125;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WXzjn+vyJIpaH9gzDIVnY/hmD1MIvRpuB4YDU1U7djk=;
 b=NS5K5G6OFjRGTDCxCcrETiEfjloWfQwlg0i3+GSvEBe5qiqofZNbt+vq+MuRe7xxGb
 Y/N91XsGjpM39nDrVxxA1LLstOsMYYIyoHYeuHEzN+acNxHbY3yCoA9aqdLxMQ8S8ULI
 e53ahgbtRTFRRXD9UOB16Ag1jEl4DCLoDAYlKaC4cqhIEK9OpLMM7A7PX8nw4IW+uI/P
 zY3YckLNfHwnzE9hRvnrHvaHpoAXZuLNvKDIjUhUkoi7NwDVKzDWlO1F2V/OPjJY1FYv
 5iIWD2bMBIfiw9hXyPLtAk29rh2SmAEvmBHQ4pDjYlD6w0oBLL9muN8GIRJtH459PivP
 OtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795600325; x=1796205125;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WXzjn+vyJIpaH9gzDIVnY/hmD1MIvRpuB4YDU1U7djk=;
 b=CPOFs3mn+x6tkc7zLoLu9qL5/XLNc+IeQPKEp+g9IAKahOMeY21/1xYAqZuQDf34k+
 q0JLEKvGXUSIKGlvv5Wsal2RyM+Z5imIVKpMUhzVVeoLNo7yhU9wWu4TFYXLkT97tkKl
 4b2M01Fcw/Kst1ugXSWKJM9nF9okWd0UTyjnTKf0xlDFE7C3G8Bd5IIQPaMGlQPLYD4M
 TTNCn/M4WLrOV+QEJI1cNN3/WjiHUGOHOFBgGqke5ybzBGrQVAt5tQSU7p8qIAKKz3Jt
 guaafJ5NGYKStp0xCAhtgURWfZybmn/Y6RAyZlVca+Ud9mq/tBJ7msHzNlR/ePnyL3NO
 mUMw==
X-Forwarded-Encrypted: i=1;
 AL+hErHiq6WuCjd6qvW260AXPPKgGmDFpA3fVwj98zPZymw7UEObOmKKl/XzqF6TjWmKBtPlZ8/qDYNlNDy/rdEgvH0=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9BCbVX8ajxUAzlzZw1tm7Rq8B/3RK0TslTDU3n0wUT9o9d6iQr
 pDAGdfqLuwItAW4JETBORHEmk/MZKbru8gCkivbiBbb6FzhEKnRmUrmgXUFGr1HZM1Q=
X-Gm-Gg: AZFdTZfIR4JGxQ3KGOnDkdUeYdB/n16D/fLKGGEPgmi4XELcmfv6KvHYOfXo86zA+ZB
 +sPQm1I6BY9irox5tKumzfSWRLii0+Y8ajGzGNisKBCbMOHidLQ+I17f/23V1G0AnoWD0ZYI5Eo
 nxx49Znj86u8/peHqtRF5+viCpxjmmCnDxvyZd02rFxCJ/0hzKoR1sbk/gdqkyCIAQ9w7oV+iMh
 N+BCpN6jLs6IsnYI2zTNKOj1ed+sC8ywVVQPkjvPd/llOb1C64gvy9p8wx4aHRrU/UFe/cQPyqu
 4QsVSl6pfMoUKId90fo6Opucumwq5CFiFq7o3mgm0qLK6N2uSZyWUbEKBN7e292ApX5jy1q0Fmz
 JT72Tr6W8Eg+TZqo/5AwQ2E7vxpYXYbHa8oF3/uiDVRw/SwK1IVoDMwfVrisv736FUG+5IoLUjN
 kBWsbAyx9C6JnWoZKAnAMGWCeShD2PrCxeL4VCkcvWI79/is4Ln/Z7vNFeOiLy0amZZrtWG6TIa
 bOLbUr8+Kl96jcjz8v6CKNRCwncPPgvJ3MFYA+9nkPVB8xBlZs7soM8r5S+PRZ409bzaTxWLi82
 1OTkCzZzmt8i4uB0sqCQP0hkEp2D/Xo/WpkMinNnbCyBDIBqXnyD+IulgdA=
X-Received: by 2002:a05:6402:42c8:b0:6ba:90b8:6584 with SMTP id
 4fb4d7f45d1cf-6ba90b86c26mr7931504a12.27.1795600325287; 
 Wed, 25 Nov 2026 01:52:05 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.56]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba37108c8esm8147342a12.31.2026.11.25.01.52.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 01:52:03 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Alice Michael <alice.michael@intel.com>,
 Eric Joyner <eric.joyner@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, tianyi.gao@linux.dev,
 Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net v2] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
Date: Wed, 25 Nov 2026 09:52:01 +0000
Message-ID: <20261125095201.98279-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On E830, ice reports CHECKSUM_COMPLETE with the generic checksum (GCS)
that the hardware computes over the received frame. If an XDP program
changes the packet and returns XDP_PASS, that checksum no longer
matches. The stack then checks the packet again in software and calls
netdev_rx_csum_fault().

On Cloudflare servers, an XDP load balancer removes the encapsulation
of the packets that it accepts locally. Our production traffic hits
netdev_rx_csum_fault() all the time.

Do not use GCS while the VSI has an XDP program, as mlx5 has done since
commit 5d0bb3bac4b9 ("net/mlx5e: XDP, Avoid checksum complete when XDP
prog is loaded"). Set ICE_RX_FLAGS_RING_GCS in ice_vsi_cfg_rxq()
instead of ice_vsi_alloc_rings(). The flag then follows the program
when it is attached or removed, and after a VSI rebuild. Log an info
message when a program is attached on a port with GCS.

E830 also sets the L3L4P and checksum error bits, so the packet gets
CHECKSUM_UNNECESSARY or CHECKSUM_NONE, as on E810. For example, a zero
UDP checksum over IPv6 is marked as bad and gets CHECKSUM_NONE. A zero
UDP checksum over IPv4 gets CHECKSUM_UNNECESSARY, so the inner checksum
is never checked, as on E810 and as on E830 before v6.15. The
discussion in [3] concluded that CHECKSUM_UNNECESSARY only is the safe
option with XDP for now, and that the decap case is a known problem.

Two pending series [1][2] give XDP access to the checksum status.
Neither of them supports CHECKSUM_COMPLETE.

Tested on an E830 with an XDP program that removes 16 bytes of UDP
payload with bpf_xdp_adjust_head() and returns XDP_PASS:

- Without this patch, the changed packets got CHECKSUM_COMPLETE, and
  the stack called netdev_rx_csum_fault() 368512 times.
- With it, they got CHECKSUM_UNNECESSARY, and there were no calls.
- Plain UDP got CHECKSUM_UNNECESSARY while the program was attached,
  also after ethtool -L rebuilt the VSI, and CHECKSUM_COMPLETE again
  after it was removed.

On an E810, which has no GCS, drivers/net/xdp.py, ping.py and
hw/csum.py give the same results with and without this patch.

Link: https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org/ [1]
Link: https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.com/ [2]
Link: https://lore.kernel.org/all/20260721183256.6f49d6e1@kernel.org/ [3]
Fixes: 905d1a220e8d ("ice: Add E830 checksum offload support")
Suggested-by: Jesse Brandeburg <jbrandeb@kernel.org>
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
Changes in v2:
- Set ICE_RX_FLAGS_RING_GCS in ice_vsi_cfg_rxq() instead of reading
  rx_ring->xdp_prog for each packet in ice_rx_csum() (Alexander Duyck).
- Log an info message when a program is attached on a port with GCS
  (Alexander Duyck).
- Drop the paragraph about the two reads of rx_ring->xdp_prog. It does
  not apply any more.
- Move the test results into the commit message.
- Drop the Acked-by of Maciej Fijalkowski, because the code changed.
- v1: https://lore.kernel.org/all/20261121012402.84848-1-tianyi@cloudflare.com/

The E810 tests ran on net. The E830 tests ran on v6.18.65 with this
patch applied, on 8086:12d2 with fw.mgmt 7.9.5 and DDP ICE COMMS
1.3.63.0. Without the patch, 164150 changed IPv4 packets and 154671
changed IPv6 packets got CHECKSUM_COMPLETE in 2 s each.

 drivers/net/ethernet/intel/ice/ice_base.c | 7 +++++++
 drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1667f686ff75..3c44e112acf9 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -705,6 +705,13 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		}
 	}
 
+	/* XDP can change the frame and make the GCS value wrong */
+	if (ice_is_feature_supported(ring->vsi->back, ICE_F_GCS) &&
+	    !ice_is_xdp_ena_vsi(ring->vsi))
+		ring->flags |= ICE_RX_FLAGS_RING_GCS;
+	else
+		ring->flags &= ~ICE_RX_FLAGS_RING_GCS;
+
 	ring->xdp.data = NULL;
 	err = ice_setup_rx_ctx(ring);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 977cd8dd6e31..910951a17950 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1532,9 +1532,6 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 		ring->count = vsi->num_rx_desc;
 		ring->cached_phctime = pf->ptp.cached_phc_time;
 
-		if (ice_is_feature_supported(pf, ICE_F_GCS))
-			ring->flags |= ICE_RX_FLAGS_RING_GCS;
-
 		WRITE_ONCE(vsi->rx_rings[i], ring);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 47c6798c97e8..9644b25e7935 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2944,6 +2944,8 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 			}
 		}
 		xdp_features_set_redirect_target(vsi->netdev, true);
+		if (ice_is_feature_supported(vsi->back, ICE_F_GCS))
+			netdev_info(vsi->netdev, "XDP program attached, Rx CHECKSUM_COMPLETE disabled\n");
 	} else if (ice_is_xdp_ena_vsi(vsi) && !prog) {
 		xdp_features_clear_redirect_target(vsi->netdev);
 		xdp_ring_err = ice_destroy_xdp_rings(vsi, ICE_XDP_CFG_FULL);

base-commit: cc7fe6e741730fef549e484379281736d32746f0
-- 
2.56.0

