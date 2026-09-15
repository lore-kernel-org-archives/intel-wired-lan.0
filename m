Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F38C88E53
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 08:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C58DF60736;
	Tue, 15 Sep 2026 08:37:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fRSqG3ZUP62h; Tue, 15 Sep 2026 08:37:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D36B160721
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789461419;
	b=GhEokm/2bbO4ayyl7XZTHVWYoRyfUGXIgPrCkqwbxyMIqeySVq1WNMCUWlIwKHe6pKdD
	 n1i2GDwPSI8KKQlnM6mXPrkheZj8A68Ni7AHpEyfiVJ4XRIYE9ej4hYMI/ytkcYQbgIRZ
	 tAHhXbkGovpVu9Fuk6QmF4mqrw8CulZso9aZN7kYiZGExQ7qU0LooasDGW4sqStoA5YD7
	 Yh3YJOvBlcK4mtMC0SpagRFxuED1hGzgY5im4JPzuZpxh8cppsmTCDht32h3lH70TUAfG
	 tyceXs3vYytQPnswfXsN9DTfuXfF22LAAHl+67laalyK29W/J2ZlvLkC+SQgvdNxPGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789461419;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=S4qdnUSRXu9jp2j6e/xh0pE4PAJYYoTSoLGlLBucJUA=;
	b=awlFQ+zUpvFnaTZFdAZQOEUy9QP6qgnPR6yrhJUxrTbFY1ReBu+KhRxc40T+xoM6X/Th
	 4wdl/DUGYi46iV944+sG6kv7OrAoxkoxGVqOLHjmxFlWrzDDOkfH3GwYlI67cS7RaJpdE
	 Q1o8SwVxPLQeL7j8hr+RoQ+iY7YPmcOOddOz+CGsvBsgcNRgvtq9bWxWxzRo34KD2lsIO
	 QffzrBcRPxLt0iVzD2bCGWxtnaNW2IMhbPXuUIpu54CWaUmZiWEuJd7vUJywNL3mQu2G5
	 Gg/PlSbTCFuu/hNUj5+JvV0HmjPIPwBsDh5zLIR31e+r1RT77cQPTPZ1W6a0N+3sI+g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789461419;
	bh=S4qdnUSRXu9jp2j6e/xh0pE4PAJYYoTSoLGlLBucJUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5xHKYT+8wENmNpwJrjSRi0H1p+jNLWaRiKmPEsmcHvHsgf7D39cX6NaI6gT63+F1o
	 meGLL3BIrrBrly6d2JmyuWt308nhSHq3eklJf5St0UhFleIH4kuxIBQhJqP9fuTQsb
	 sBf/RRucZKjd8GX7jZ55KUZVYWiL6PrBEnp2JfNsrdXUmkkp+i3fxl+LZWlZTMci9u
	 +OPDYLoJ12lvaM6VS7cTh5y7UYCgIQ9ATyCHjU1KFt956ArBiR5vyWAWbRb0r5SJaQ
	 5/4w1e2XlbOtpMcYzNvSXbZec4/zStlsZl3lNQ863n6deAJ+L6/TIkbI3wQpVeEcMw
	 YTBZByGG1RwBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D36B160721;
	Tue, 15 Sep 2026 08:36:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 61395493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5364B40532
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:36:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Reg4BqcIDbZn for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:36:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AF7864052E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=117.135.210.6
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789461417;
 b=X+WTXWfyqnK7w1Xb0gA9AQjiTLL41+uTSqqKymLI7+2Zi8nv2CugtBHdCC1J29b5CxMa
 XnG4K5IaGFNJsvIMBgGAZ4zI4hNWdVmDXlWsquqGBCo1Wve8jYIz0lBp3ZS875j5Mi4uw
 308Jitwrt8IGW0gE2VjjvRyUKZGi9NhK3ARzxuDQ4Abpbq2eRe84eHWRQkeFTXzY8LMqz
 sKGlimVdsPK+1xf+MHmaGeyvsWndJdAUGvTwES78l5Z2WtuqUo0vn3V042Lis6lTbpkNB
 xgryl9Q4ILf6T8LSsdyO4gGXoulDELXv9XOU5nwrh8aLWE7uIskAqAAl2W8+Kjk9+SA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789461417;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=S4qdnUSRXu9jp2j6e/xh0pE4PAJYYoTSoLGlLBucJUA=;
 b=EcWzcY0nRombjqvObcciWij5L5K0DXZfG8dNvVPPPfdDL3D3CI6S8RxraQ5MTTemkEJZ
 NeS4RehSjqtIrFlaKSp+QLEThVf8HXU0c4cna5r/+qA/K39e1NB+p1VWr2+muaXWk5IdO
 AofKYGwhd5oZjC69DZYSlVR4a/jBHE/ZzJ/R0BaOVum+fBkidkGXLL+ZYxwd6jpf2mWCG
 6Q4XI5a6QAvWpb+BkbxAaHBww+tFXcf6jOanObMSqGhvFGbZyFxwDCiqBp9xTrGswQ5O5
 hqTzjxSS7oXtucaMVL2NKtgiDyRnEpYeO+kQwyD+DyEgpuH4YkOb7voXezkw5aOS3ew==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=JDmxVtrg; 
 arc=none smtp.remote-ip=117.135.210.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.6;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=JDmxVtrg
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF7864052E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=S4
 qdnUSRXu9jp2j6e/xh0pE4PAJYYoTSoLGlLBucJUA=; b=JDmxVtrg6IVuJAAT74
 zftsrXhgTNAPtfYyvMWB6VkSeSoK2VbKUyokz5SPs6nCQlwEyI6ENo8iBpXFi5uW
 iJXBI2telQXprW7FFX5x/Xy6qmmzMFsmdKHxVeJJNS1+agnvlALjec9LmLBoWCLB
 2UxCjn7ggfJm08FiuuHSZ+xj8=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PykvCgCXdbmdA6lqQxoPHw--.53987S2;
 Tue, 15 Sep 2026 16:36:46 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH v2] i40e: add an error handling path in
 i40e_xsk_pool_enable()
Date: Tue, 15 Sep 2026 16:36:43 +0800
Message-Id: <20260915083643.506113-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260131055217.729048-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260131055217.729048-1-lihaoxiang@isrc.iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: PykvCgCXdbmdA6lqQxoPHw--.53987S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WryfKw4kCry5GFy7ZF47Jwb_yoW8Kry5pr
 Wj9a4DCF48XrW7Ww4kJF48u3WrJw4aqa4UK3W3Can3urn0qF93JF4xtFWYg3ykZr4kJwsx
 GF1DAwsxCFn8Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRFeHgUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlB-sw2qpA5+xUwAA3Z
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

Hi Haoxiang,=0D
=0D
The kernel test robot reported the following build error on your v2:=0D
=0D
  drivers/net/ethernet/intel/i40e/i40e_xsk.c:130:9: error: implicit declara=
tion of function 'i40e_xsk_pool_disable'; did you mean 'i40e_xsk_pool_enabl=
e'?=0D
  drivers/net/ethernet/intel/i40e/i40e_xsk.c:141:12: error: conflicting typ=
es for 'i40e_xsk_pool_disable'=0D
=0D
The root cause is that i40e_xsk_pool_disable() is defined after i40e_xsk_po=
ol_enable() in i40e_xsk.c [citation:4]. When the error path in i40e_xsk_poo=
l_enable() calls i40e_xsk_pool_disable(), the compiler has not yet seen its=
 prototype.=0D
=0D
One way to fix this without reordering functions is to unwind the two opera=
tions that i40e_xsk_pool_enable() itself performed in the error path:=0D
=0D
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ether=
net/intel/i40e/i40e_xsk.c=0D
index 9f47388eaba5..97d016be493d 100644=0D
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c=0D
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c=0D
@@ -108,23 +108,31 @@ static int i40e_xsk_pool_enable(struct i40e_vsi *vsi,=
=0D
        if (if_running) {=0D
                err =3D i40e_queue_pair_disable(vsi, qid);=0D
                if (err)=0D
-                       return err;=0D
+                       goto err_pool_unmap;=0D
=0D
                err =3D i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], true);=0D
                if (err)=0D
-                       return err;=0D
+                       goto err_pool_unmap;=0D
=0D
                err =3D i40e_queue_pair_enable(vsi, qid);=0D
                if (err)=0D
-                       return err;=0D
+                       goto err_realloc;=0D
=0D
                /* Kick start the NAPI context so that receiving will start=
 */=0D
                err =3D i40e_xsk_wakeup(vsi->netdev, qid, XDP_WAKEUP_RX);=0D
                if (err)=0D
-                       return err;=0D
+                       goto err_realloc;=0D
        }=0D
=0D
        return 0;=0D
+=0D
+err_realloc:=0D
+       i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], false);=0D
+err_pool_unmap:=0D
+       clear_bit(qid, vsi->af_xdp_zc_qps);=0D
+       xsk_pool_dma_unmap(pool, I40E_RX_DMA_ATTR);=0D
+=0D
+       return err;=0D
 }=0D
=0D
This mirrors the internal logic of i40e_xsk_pool_disable() [citation:12] =
=E2=80=94 clear the zero-copy bit and DMA-unmap the pool =E2=80=94 without =
calling a function defined later in the file. It also avoids the limbo-stat=
e concern you mentioned in your v2 changelog, since it does not go through =
the pool-association check in i40e_xsk_pool_disable().=0D
=0D
Alternatively, a forward declaration of i40e_xsk_pool_disable() at the top =
of i40e_xsk.c would also resolve the build error.=0D
=0D
Best regards,=0D
Linkui Xiao=0D
=0D

