Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14442C61DBD
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 23:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C06F3605F8;
	Tue, 25 Aug 2026 23:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zxvs8ts-AORL; Tue, 25 Aug 2026 23:57:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787702268;
	bh=0zuxoKD2M1JEVqHANBIUbWduPp/SxtJyTy5Prh/oD7w=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yHW9QtuNpRfq6Vrd0qou8u/XJ5ZRcBKgGrT+o7o7wdxocZFQ9s2AJwhDGcWA4GezB
	 Me34+L+R9mkw1ZOmdWLyYr9vuUbBsScnBRb0VeLQxREn+QOHE2EAarT1FeqcqcKey6
	 a9ASEAJKzWtrueBuz/0++RLn3NqlozrE8GGh4dkYaiqoiy5zH90p4keXQtBVGVtb2s
	 oG19jtdvbgrxtE0jKD93tEWgknFVsPqr997yLmbf7TPBnMvWqzCsIkiILaOyMwc7dK
	 Pb19EVTdLOPBleJibJLEmYdIjF7Cie+sbPXCYe6W9PI16BnBJhySMlgeOVi55vk0lt
	 Bq+UfrrBltiqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA8FD605F9;
	Tue, 25 Aug 2026 23:57:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A63B2FD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 23:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 70F6A40055
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 23:56:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w9kqt1Ty1eul for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 23:56:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.103;
 helo=mail-244103.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail3 header.b=mrGmclxG
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69B49401AD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 23:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail3; t=1787702146; x=1787961346;
 bh=0zuxoKD2M1JEVqHANBIUbWduPp/SxtJyTy5Prh/oD7w=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=mrGmclxGRKil5ZV/uCVKYMkGgZX257YTVHByLpKbQjafzcklEip4jwpOOgdPl2hch
 tqTZFnukn1bui8ETwIF6tdrefF4GR4SCv3s3aBBHDPKS8lkdI56C1nkKpaPZ1+rvPT
 CQGTwcanShKSG2PUZlDhKTqcAqL1mMdagjK3HMkrHwky3dHFfHFgYBtnT+gRAvkBJF
 dCOhDtafvMec+qinDtVQKzeH/DIUpxqP2DWiNsxQorhPCNzMyLJI+/RDr2j6vwYm7X
 aYVsXeF0IwZKinWiNHh08MmMxEQTonwL9f4BXX6sxUCoKuJzwnXSNQVNXV5j48aaZi
 FRr9h/9BRK6Zg==
Date: Tue, 25 Aug 2026 23:55:40 +0000
To: intel-wired-lan@lists.osuosl.org
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maciej.fijalkowski@intel.com,
 andre.guedes@intel.com, vedang.patel@intel.com, jithu.joseph@intel.com,
 richardcochran@gmail.com, tkusters@aweta.nl, stable@vger.kernel.org
Subject: [PATCH net] igc: only strip RX timestamp header from first buffer
Message-ID: <20260825235530.3278670-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 8f3ba88960520ef0ca5839f4ffd264c7e10e4b08
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 25 Aug 2026 23:57:47 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org

igc_clean_rx_irq() strips IGC_TS_HDR_LEN whenever a descriptor reports
IGC_RXDADV_STAT_TSIP. For multi-buffer packets, continuation descriptors
retain TSIP even though the inline timestamp is present only in the first
RX buffer.

Subtracting the header length from each continuation buffer truncates
jumbo packets by 16 bytes per continuation and leaves the packet length
larger than the received data.

Only consume the timestamp header when skb is NULL, which identifies the
first buffer of a new packet. An skb carried in rx_ring->skb remains
non-NULL when packet assembly resumes in a later NAPI poll.

Link: https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@=
aweta.nl/
Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
#
# REPRO
#=20
# Receiver: igc / enp1s0 / 10.0.5.175
# Sender:   RTL8125B / enP4p65s0 / 10.0.5.165

# Both hosts
sudo ip link set dev enp1s0 mtu 9000
sudo ip link set dev enP4p65s0 mtu 9000

# Baseline: RX timestamping off
sudo hwstamp_ctl -i enp1s0 -t 0 -r 0
ping -n -M do -c 5 -s 8972 10.0.5.175
# 5/5 received

# Enable RX timestamping only
sudo hwstamp_ctl -i enp1s0 -t 0 -r 1

# Receiver
sudo timeout 20 tcpdump -ni enp1s0 -s 0 -w /tmp/igc-jumbo.pcap \
  'icmp and host 10.0.5.165'

# Sender
ping -n -M do -c 5 -W 2 -s 8972 10.0.5.175
# 0/5 received

# Receiver
sudo tcpdump -nn -e -vvv -r /tmp/igc-jumbo.pcap
# length 8950
# [total length 9000 > length 8936] (invalid)
# wrong icmp cksum

# Expected Ethernet length: 9014
# Captured length:          8950
# Loss:                       64 =3D 4 continuation buffers * 16 bytes

# Disable RX timestamping again
sudo hwstamp_ctl -i enp1s0 -t 0 -r 0
ping -n -M do -c 5 -s 8972 10.0.5.175
# 5/5 received

---

 drivers/net/ethernet/intel/igc/igc_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 1fb5f3cbe93c..41b293dc10c3 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_ve=
ctor, const int budget)
=20
 =09=09pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
=20
-=09=09if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
+=09=09if (!skb &&
+=09=09    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
 =09=09=09ctx.rx_ts =3D pktbuf;
 =09=09=09pkt_offset =3D IGC_TS_HDR_LEN;
 =09=09=09size -=3D IGC_TS_HDR_LEN;
--=20
2.55.GIT


