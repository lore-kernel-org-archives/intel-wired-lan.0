Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5176606A332
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=0+ego53M;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzwtWeRa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EAF460635;
	Mon, 26 Oct 2026 13:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eAnGnkU8mSrx; Mon, 26 Oct 2026 13:30:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D77CE60612
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793021426;
	b=X21USZTlYHT0zixvxihk/no0SO+c9yx1gzQRd+n/KFvMIwKniLfryB/p8Ytz4PzvxWRH
	 aa5MJKHd5ga34lUwK6Xmdmqo0G5UAvV16OWLCrJz6Tts8tRXqoq/wOY3tNurnB94Has4q
	 7ri3cBKvzErF8mH0/Jr52kMFzonxtxL7fs5K5Vby9CkyuR7UnxAP1IMxJ44PMEbMpLKcD
	 xQZ7gLqeXRY8PonKMtp3NCcS5/nZmdgPedxZzGUSvUgyuVntwzHfDGnlf6/Pvx7EcYxNm
	 em7QGgSLWCRAdABsZwKMV/MwLKqYhDZXDhj5PCEu81W4p1GY9REALENs9a2S9P6FdYQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793021426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=CQEmrnzAxzrvt2FH74TyL1gH4vTDIUFyAXmmW2ABe8A=;
	b=Xl3SzdG2B9TrohBMRh6plkqBmUmndwyZU1h8lHhkXycBzrYJiFJ0e2fa5bHoOIGsWiqP
	 IfP37gbb+TinRVFNYK2B6QegTJvNE77CKM5UbiNwXlXGiOUdrXMKlJUq7xUaf1A4niZKm
	 0fo8B+VV9/CJsL/C2r+VyNOfnyE2LqaQY7ECyH6xG81zRXaUYxwLjOWNmQSuvS6THstEA
	 w2MFgJy7PvRspP/+RJo5AURgHjGbeXsILUd4UqCIFyvfhhRPH9BZjywrZYTePlwJAAwOn
	 00DcU06mEbqFq61tEDeKjs2W1d9JBHBFIaV3ZB7I3Xb6svGmjZNRbN/DQIkwo5d+dPA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzwtWeRa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793021426;
	bh=CQEmrnzAxzrvt2FH74TyL1gH4vTDIUFyAXmmW2ABe8A=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=0+ego53MeP1wtY6zbwnzzzzCERiOVaBwwcmXqIpEBlHYmpcqlKzsPfyh4cwNrtKqK
	 ks/pePFsYzliiHvkonYQwdqmW2JXgksOW8XX8JkUiMUXhpgin4yASJAcAxsCEOYlbL
	 ATzd/pYTLxE3Kifj7EeMwATHgXZT+Xv0wnKj5r2IJnvYLQ+p0cEz+rxbbA52fYSg+7
	 HSowrdm7YvA3qBRBCN+jDOVqdqJizsjVU+PwqFK+lJx3vO/inhua6VbM1V97wu1TV+
	 F3E1M5FoSDGOy+2Hza8OrPACR2eUnUMEZMw0N2bT0mgU+ZqMcJevkz2BVxiLotYkpk
	 b5M5MgyIri7yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D77CE60612;
	Mon, 26 Oct 2026 13:30:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 70706279
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 13:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 61BD060612
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 13:30:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B-Cq325KDS_w for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 13:30:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 92AA560603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793021424;
 b=Z4+/6Ptz4DDueszJsobdrmh4asdzHaTIz18upkGC9Yky75gX9tH5Fri1g1HLapUCQVMX
 jY99pgFWxf59hrsyH0CEvtt3OqQJCKYEFP5Y4op+SZ4/sg77bTdkdj5Kn6hpP7qmOxKTF
 31WvhtxfGcHPyV1liUEarFLCYAB/dWGD0dpKcKhrvesa+7T61OjyepZ3NERCxDkMJSo0l
 Of4k06OYxtFoGChdsRwPkHF5sTCqDmt5qJCaGAIstOubKG5QJgE8m47hn3BQlEu4n+S4B
 0XbVf/JNO+Q2LtGCzzaRr/LL8Yz7Ia4oCmisW1CjeVUqx2XyooHhTX8xX19tH3kQHWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793021424;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=CQEmrnzAxzrvt2FH74TyL1gH4vTDIUFyAXmmW2ABe8A=;
 b=FdEEcGRFRcyw9FCQ6Gz0wWKDeXL7BsbI9ThgWnzjm3YGJboElKMmtrxw/4qU1OyIrAvV
 rClM8zXR4USxbI7gZ3kq43pcWk/CUEbQyNNRmVdRgb+/ZIxzkG069vUoISRvRyXoc3bZh
 VNKW9XB5U1uUlHmZIMtkQKT9DhzP/ZbAa+rVY4xdzMw+lXCFU9wYGXiN6gP6rYgVoufFh
 L8pBTI8EHKEV7ebrdP9jshgEQYtCj7QTvGyyKL0hLM2yfBG9fDIbkPBW/ZR8v55RNULat
 bWBV+yD/G1ODch5MibjaSWikidMsV3MlQ8LjxzDZk0/cZDXTXfy/eSrqLUeq82FykTg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lzwtWeRa; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+choiniere.vincent.hydroquebec.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lzwtWeRa
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92AA560603
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 13:30:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53190601EF;
 Mon, 26 Oct 2026 13:30:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793021423;
 b=OX6+fGx5vbo2yu//1D/rwmYrvRYG8phmJHmI3OPViwEzj/++AaUBj0D/+0jUPbR5puIL
 SVkaBM6nG/ZMpc3+XmSZGMGGaS8CB/e6d7HbHwWjeqgPt1trgkTuYez2RigqrB80lwIEK
 6mTM0Xd7FafP/iYBjHwK+jI0jz/bjcMUJ4+zv8nQabToCQLr6noE8f0+05NZu/ddfyQeS
 sDfY7yR0vPVWAG5ihFTCmOkjHnkmIbgy2Hgs7ki8tqaR6fZckNQxX39+5Z1hNmVxpLxg2
 /4VLwI6Q9QX04jJFfmAJbXI8K6PO1l67/0QijnGS622+sIbmNIP6R1UNKJX3BgOjzag==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793021423;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=CQEmrnzAxzrvt2FH74TyL1gH4vTDIUFyAXmmW2ABe8A=;
 b=K7WgO9uOSVsjNAaUPhlbHZUnDCZctDxSP8TGfZNoYoe/mKZgPNvlBoKw4YfgV9zXvQQ+
 EmGTW9OwA5MM1ZLAVBq2v1ps9/FhrDYGdwF3DncfJnJiVfKmhUV/Jgu4vtyINxG/RLbbH
 5BfYKK4MjqENhsPa1vP03uXVfF36c0hDYLqQ6myfPQfzf2zYQ+ZkJvspihKcRxtaJK4T4
 2SyxW7DZfr7Xs/oftyYrZ8UDbd9cr1zcY9p8kZKWXF8blFhXAgJrIkZuEsS4Wu4dLCofJ
 1EDBfXwWm+dBSbrK0+jhjXVJ/IGSBaKdpj68zoJssgnz0KVV5FDa/cBk4uG6s5yojuw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 72BE41F01825;
 Mon, 26 Oct 2026 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793021423;
 bh=CQEmrnzAxzrvt2FH74TyL1gH4vTDIUFyAXmmW2ABe8A=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=lzwtWeRaMrmft/zLO/PTQb7aek4d3nHTw6AFajjHJtgPj8eoTf1PTz63CSu+P2XXy
 N6Znt8WzPsXjyVhWC4ykfDAXUsuf5G+VMQl53TfbyQl0eR2Vt6iAZuezF9huAWDYHq
 2vd+2XrxmQfeBA4SaPA5RGpzVb3zG+Bs3urrH/dBBg/J6oWN83S8KvS/etSQop+r3t
 rIrre4S1Ayt9Y5b/rUdKFeSz8X+PuUlu86cD2jmTOTJ96U3++21uNiF+JlFDX6dPVP
 C6cbFhm7HYyUub5K4fz6Ef5EIVOgw8VdFfGxDqGNwzd8Qo7uYnCviE8ErkECc/SlTH
 aTEO3HJ6DSCVA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 0362444D1A;
 Mon, 26 Oct 2026 13:30:22 +0000 (UTC)
From: Vincent Choiniere via B4 Relay
 <devnull+choiniere.vincent.hydroquebec.com@kernel.org>
Date: Mon, 26 Oct 2026 09:30:22 -0400
Subject: [PATCH iwl-net] ice: fix NULL dereference after disabling RDMA
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-ice-deinit-rdma-null-v1-1-7d2130d1809a@hydroquebec.com>
X-B4-Tracking: v=1; b=H4sIAO1V32oC/yWMwQrCMBAFf6Xs2YUmwQr+inhokxddiaskaRVK/
 92ox2GYWakgCwodu5UyFiny0AZm15G/jnoBS2hMtreD6e2exYMDRKVyDveRdU6JB+OimeBcPFh
 q6TMjyvu3PZG8Eisqnf+izNMNvn6ntG0fbZLQUIEAAAA=
X-Change-ID: 20261025-ice-deinit-rdma-null-613f1be33f72
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Vincent Choiniere <choiniere.vincent@hydroquebec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793021421; l=3312;
 i=choiniere.vincent@hydroquebec.com; s=20261016;
 h=from:subject:message-id;
 bh=k9KyR/hu9YHlPLJ6ekmbRPgwMefAd5BueodKK2/VMpU=;
 b=8bwOLo9nJW2N0lkprTPvo4m7YK3bCgAvaOdITw89TeFZE4NqbPiFYxMcXYABPUonNi9ZXkF/N
 SSg99Pxr0XBDc4xD+agc0rCZRcm5RqV9IGR1Q9in27Ko8MdWDYYRiTp
X-Developer-Key: i=choiniere.vincent@hydroquebec.com; a=ed25519;
 pk=MctQE067DucsZOaNqb+sjY7aQ+urhztuURanagEW3+8=
X-Endpoint-Received: by B4 Relay for
 choiniere.vincent@hydroquebec.com/20261016 with auth_id=1210
X-Original-From: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
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
Reply-To: choiniere.vincent@hydroquebec.com
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vincent Choiniere <choiniere.vincent@hydroquebec.com>

ice_deinit_rdma() checks ice_is_rdma_ena() before dereferencing
pf->cdev_info. While the enable_rdma devlink driverinit parameter is
registered, that helper returns the parameter value. Once the parameter
is unregistered, it falls back to ICE_FLAG_RDMA_ENA.

When enable_rdma is set to false and applied by a devlink reload,
ice_init_rdma() returns early, leaving pf->cdev_info NULL. During driver
removal, ice_remove() calls ice_deinit_devlink() before ice_unload().
The parameters are therefore unregistered before ice_deinit_rdma()
runs. On an RDMA-capable device, ice_is_rdma_ena() then returns true,
allowing ice_deinit_rdma() to dereference the NULL pointer.

This can cause a panic during reboot, module removal or PCI unbind.
Reproduced on an E810 PF with Ubuntu kernel 7.0.0-14 (PREEMPT_RT):

 devlink dev param set pci/0000:02:00.0 name enable_rdma value false \
         cmode driverinit
 devlink dev reload pci/0000:02:00.0 action driver_reinit
 systemctl reboot

 BUG: kernel NULL pointer dereference, address: 0000000000000018
 RIP: 0010:ice_deinit_rdma+0x30/0x60 [ice]
  ice_unload+0x3f/0x150 [ice]
  ice_remove+0xb5/0x1d0 [ice]
  ice_shutdown+0x1b/0x60 [ice]
  pci_device_shutdown
  device_shutdown
  kernel_restart
 Kernel panic - not syncing: Attempted to kill init!

Check pf->cdev_info before dereferencing it, as
ice_rdma_update_vsi_filter() already does. This preserves the existing
enable_rdma semantics without changing other ice_is_rdma_ena() callers.

Fixes: 87181cd6985f ("ice: enable_rdma devlink param")
Cc: stable@vger.kernel.org
Signed-off-by: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
---
Testing was performed on an E810 PF passed through to a KVM guest,
using Ubuntu kernel 7.0.0-38 (PREEMPT_RT). Two kernels differing only
by this patch were compared. Each test set enable_rdma=false and
applied it with devlink reload driver_reinit before the removal step.

  Removal path      Without patch           With patch
  reboot (x3)       NULL deref, panic (3/3) clean (3/3)
  rmmod ice         NULL deref              clean
  PCI unbind        NULL deref              clean

Additional checks on the patched kernel:
  - Reboot without a preceding devlink reload completed cleanly.
  - irdma devices returned after PCI unbind/bind.
  - irdma devices returned after an enable_rdma false -> true reload
    cycle.

No KASAN or kmemleak testing was performed.

The exact target tree (net, 7076f684d5132e6a) was not built or tested.
ice_deinit_rdma() and ice_is_rdma_ena() are unchanged there compared
with the tested code.
---
 drivers/net/ethernet/intel/ice/ice_idc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 102d63c30..09dfcffeb 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -454,7 +454,7 @@ int ice_init_rdma(struct ice_pf *pf)
  */
 void ice_deinit_rdma(struct ice_pf *pf)
 {
-	if (!ice_is_rdma_ena(pf))
+	if (!ice_is_rdma_ena(pf) || !pf->cdev_info)
 		return;
 
 	xa_erase(&ice_aux_id, pf->aux_idx);

---
base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
change-id: 20261025-ice-deinit-rdma-null-613f1be33f72


