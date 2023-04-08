Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38E5C7619A
	for <intel-wired-lan@archiver.kernel.org>; Sat,  8 Apr 2023 19:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F02841E58;
	Sat,  8 Apr 2023 19:25:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F02841E58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680981920;
	bh=6pl35mEKB9Wx/hTaNwn/B7/8kBnlaC+EdpWivAxkmF8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Hdo088gPTG1O0lcA4SaIvMVvwwXzHPNk6H8SPGDZJKdaAF/vMSD1quscVzvjuPcM2
	 nvT9EBc9A7e3PlXTxvWVD+WfxRNC9XBrqE2etmOzMM1iqxFEV+SPNrlKC2Ff0oJmKF
	 TnBzQrLFLjGwyxvqOh2CEP8N4pEguhf9ZBfXibfTTG1IURf0n2CasMryoOhF2bStHM
	 fCW4fWA2VkV1vYXw35sY75jfeSKeDzYfPENrCRtK33/pwknDgYskzeQqe1pEWhwi5R
	 ZgdmoBMXMvzSiCenbbhMjC9jCGz5zjjn1Ao4gS/DPcKSgv2KWfd5lZoETOAXIZOpKM
	 WEXN+qRufm5Hg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NbJKosE0J_Lh; Sat,  8 Apr 2023 19:25:19 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1345641DE0;
	Sat,  8 Apr 2023 19:25:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1345641DE0
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 6A5471C2C89
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Apr 2023 19:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 512F7841FD
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Apr 2023 19:25:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 512F7841FD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WDbgjRMV0Hql for <intel-wired-lan@lists.osuosl.org>;
 Sat,  8 Apr 2023 19:25:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86EC0841F2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86EC0841F2
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Apr 2023 19:25:13 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271--IICphAMNi-JjcJDoW2lFw-1; Sat, 08 Apr 2023 15:25:08 -0400
X-MC-Unique: -IICphAMNi-JjcJDoW2lFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B60261C04181;
 Sat,  8 Apr 2023 19:25:07 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69C292027063;
 Sat,  8 Apr 2023 19:25:07 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
 by firesoul.localdomain (Postfix) with ESMTP id B4C80307372E8;
 Sat,  8 Apr 2023 21:25:06 +0200 (CEST)
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Sat, 08 Apr 2023 21:25:06 +0200
Message-ID: <168098190669.96582.15579713988345319189.stgit@firesoul>
In-Reply-To: <168098183268.96582.7852359418481981062.stgit@firesoul>
References: <168098183268.96582.7852359418481981062.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1680981912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X2qMh1719XPTmN3fL+GQW8KuUqpmNliiESfRG6QrFt4=;
 b=gR+hdyk4B31qF4RxN+dDgaV69pRyblEqSZnLzGv5BBlt2DsEf41f/krQKnQ2iRYfYzPeoi
 7+XuzJ75KhcKmru4NQ129dfnhD7rcEsHz4UqSll042yB/GLeEFthtch+GpkDs/kjzW4vDT
 tHgJdTOP0x17PPYD6BinLwgfG7F4LzY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gR+hdyk4
Subject: [Intel-wired-lan] [PATCH bpf V7 6/7] mlx4: bpf_xdp_metadata_rx_hash
 add xdp rss hash type
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: ast@kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 boon.leong.ong@intel.com, hawk@kernel.org, xdp-hints@xdp-project.net,
 daniel@iogearbox.net, linux-rdma@vger.kernel.org, john.fastabend@gmail.com,
 jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org,
 Jesper Dangaard Brouer <brouer@redhat.com>, kuba@kernel.org, pabeni@redhat.com,
 martin.lau@kernel.org, larysa.zaremba@intel.com, leon@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, tariqt@nvidia.com,
 yoong.siang.song@intel.com, saeedm@nvidia.com, davem@davemloft.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

VXBkYXRlIEFQSSBmb3IgYnBmX3hkcF9tZXRhZGF0YV9yeF9oYXNoKCkgd2l0aCBhcmcgZm9yIHhk
cCByc3MgaGFzaCB0eXBlCnZpYSBtYXRjaGluZyBpbmRpdml1YWwgQ29tcGxldGlvbiBRdWV1ZSBF
bnRyeSAoQ1FFKSBzdGF0dXMgYml0cy4KCkZpeGVzOiBhYjQ2MTgyZDBkY2IgKCJuZXQvbWx4NF9l
bjogU3VwcG9ydCBSWCBYRFAgbWV0YWRhdGEiKQpTaWduZWQtb2ZmLWJ5OiBKZXNwZXIgRGFuZ2Fh
cmQgQnJvdWVyIDxicm91ZXJAcmVkaGF0LmNvbT4KQWNrZWQtYnk6IFRva2UgSMO4aWxhbmQtSsO4
cmdlbnNlbiA8dG9rZUByZWRoYXQuY29tPgpBY2tlZC1ieTogU3RhbmlzbGF2IEZvbWljaGV2IDxz
ZGZAZ29vZ2xlLmNvbT4KLS0tCiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0L2Vu
X3J4LmMgICB8ICAgMTkgKysrKysrKysrKysrKysrKysrLQogZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWVsbGFub3gvbWx4NC9tbHg0X2VuLmggfCAgICAzICsrLQogMiBmaWxlcyBjaGFuZ2VkLCAyMCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L21lbGxhbm94L21seDQvZW5fcnguYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxh
bm94L21seDQvZW5fcnguYwppbmRleCA3M2QxMGFhNGM1MDMuLjMzMjQ3MmZlNDk5MCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NC9lbl9yeC5jCisrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDQvZW5fcnguYwpAQCAtNjg1LDExICs2ODUs
MjggQEAgaW50IG1seDRfZW5feGRwX3J4X2hhc2goY29uc3Qgc3RydWN0IHhkcF9tZCAqY3R4LCB1
MzIgKmhhc2gsCiAJCQllbnVtIHhkcF9yc3NfaGFzaF90eXBlICpyc3NfdHlwZSkKIHsKIAlzdHJ1
Y3QgbWx4NF9lbl94ZHBfYnVmZiAqX2N0eCA9ICh2b2lkICopY3R4OworCXN0cnVjdCBtbHg0X2Nx
ZSAqY3FlID0gX2N0eC0+Y3FlOworCWVudW0geGRwX3Jzc19oYXNoX3R5cGUgeGh0ID0gMDsKKwlf
X2JlMTYgc3RhdHVzOwogCiAJaWYgKHVubGlrZWx5KCEoX2N0eC0+ZGV2LT5mZWF0dXJlcyAmIE5F
VElGX0ZfUlhIQVNIKSkpCiAJCXJldHVybiAtRU5PREFUQTsKIAotCSpoYXNoID0gYmUzMl90b19j
cHUoX2N0eC0+Y3FlLT5pbW1lZF9yc3NfaW52YWxpZCk7CisJKmhhc2ggPSBiZTMyX3RvX2NwdShj
cWUtPmltbWVkX3Jzc19pbnZhbGlkKTsKKwlzdGF0dXMgPSBjcWUtPnN0YXR1czsKKwlpZiAoc3Rh
dHVzICYgY3B1X3RvX2JlMTYoTUxYNF9DUUVfU1RBVFVTX1RDUCkpCisJCXhodCA9IFhEUF9SU1Nf
TDRfVENQOworCWlmIChzdGF0dXMgJiBjcHVfdG9fYmUxNihNTFg0X0NRRV9TVEFUVVNfVURQKSkK
KwkJeGh0ID0gWERQX1JTU19MNF9VRFA7CisJaWYgKHN0YXR1cyAmIGNwdV90b19iZTE2KE1MWDRf
Q1FFX1NUQVRVU19JUFY0IHwgTUxYNF9DUUVfU1RBVFVTX0lQVjRGKSkKKwkJeGh0IHw9IFhEUF9S
U1NfTDNfSVBWNDsKKwlpZiAoc3RhdHVzICYgY3B1X3RvX2JlMTYoTUxYNF9DUUVfU1RBVFVTX0lQ
VjYpKSB7CisJCXhodCB8PSBYRFBfUlNTX0wzX0lQVjY7CisJCWlmIChjcWUtPmlwdjZfZXh0X21h
c2spCisJCQl4aHQgfD0gWERQX1JTU19MM19EWU5IRFI7CisJfQorCSpyc3NfdHlwZSA9IHhodDsK
KwogCXJldHVybiAwOwogfQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxs
YW5veC9tbHg0L21seDRfZW4uaCBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDQv
bWx4NF9lbi5oCmluZGV4IDU0NGUwOWI5NzQ4My4uNGFjNGQ4ODMwNDdiIDEwMDY0NAotLS0gYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0L21seDRfZW4uaAorKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0L21seDRfZW4uaApAQCAtNzk4LDcgKzc5OCw4IEBA
IGludCBtbHg0X2VuX25ldGRldl9ldmVudChzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKnRoaXMsCiAK
IHN0cnVjdCB4ZHBfbWQ7CiBpbnQgbWx4NF9lbl94ZHBfcnhfdGltZXN0YW1wKGNvbnN0IHN0cnVj
dCB4ZHBfbWQgKmN0eCwgdTY0ICp0aW1lc3RhbXApOwotaW50IG1seDRfZW5feGRwX3J4X2hhc2go
Y29uc3Qgc3RydWN0IHhkcF9tZCAqY3R4LCB1MzIgKmhhc2gpOworaW50IG1seDRfZW5feGRwX3J4
X2hhc2goY29uc3Qgc3RydWN0IHhkcF9tZCAqY3R4LCB1MzIgKmhhc2gsCisJCQllbnVtIHhkcF9y
c3NfaGFzaF90eXBlICpyc3NfdHlwZSk7CiAKIC8qCiAgKiBGdW5jdGlvbnMgZm9yIHRpbWUgc3Rh
bXBpbmcKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJ
bnRlbC13aXJlZC1sYW4gbWFpbGluZyBsaXN0CkludGVsLXdpcmVkLWxhbkBvc3Vvc2wub3JnCmh0
dHBzOi8vbGlzdHMub3N1b3NsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLXdpcmVkLWxhbgo=
