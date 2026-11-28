Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBD2606A31F
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Nov 2026 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=w0YN6D81;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDpZqYGe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E51C40680;
	Sat, 28 Nov 2026 13:39:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qbjIfGvY0fHa; Sat, 28 Nov 2026 13:39:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B74BA40683
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795873144;
	b=oRw1NuA6bZjtveKfFD/luKNivppuFMgRf/+AAnXIkGKvMwyf7zM/01a6eijfQALAXgVB
	 E+5h3q6bw9/6XnZxTHc/dmUqwUaz/cVrXPpUunnpmVXI4JhTcZfGjsbgU6SKhWlpjSkg5
	 6mcQmt9eGaUuf78WqbnAc7L53H6RDijGAxf8wbURV5x+CfV9MXohuVepJOar+ob28MCTn
	 frjn4HWJjvSZUKVgA80WV/OYaJ5NoTaTn1z8raYbbxGQLYqgMEXoO5F/Di9ml2SERdieb
	 kTOY4Rf7fUInmZvxXJSdJmiqVa6eTQRZ1kyyIzOMp0j/7M81woRCTWD9rDts1MxEwdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795873144;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4lDF0vQqikD7LUr8D749WPrms9ik25wN2smo9HvyhNI=;
	b=jludFvVi+W9jT7v6jBmHAc5FMJkvieww6+Y4MTPMGtYSZXsMv5AuEiW96xTlS6d42Wc7
	 Z5lVWNH6q5Ritfi8XUedBLWHIQBpN12f7DfAuWt6kuwS29OGl1J/4dq5UbJB4mZmCclZa
	 U3g5ik87KP5Mff8SS8I4CiQwbm/T2qUrmPqyqnyE2Kdid/V3S4Ig6TSnT0wZz2artraGB
	 hVLQBFJsurKme2DqH3+9emN0A6xPcKTFODrhhi4mDtsXLbB+xvJ1LAH9/LbmjT+2tVb0D
	 JOiJLgl65gCNEhHGVMSm9zO2iJbCrwpeZNsZlXHzXg8vZZP5czt75F25iNHjjJG5dkw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795873144;
	bh=4lDF0vQqikD7LUr8D749WPrms9ik25wN2smo9HvyhNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w0YN6D81ltflL9T2jEBbWiWiYUofyJ96U+cXlUgn+2AyUC7TOeIJFWbc0yWrJFTz7
	 EZtPCBwdTu0KRnU9rN4hC6hIt2DPo7g+Eq6siCoDinxuipYF9/XKdqrwvpgPBOV5yj
	 Ncivys0O4LQWEr3mu0EILipsNAB6unxLErQnsbWLa6Qabw0GOJr8ZexTj101wPB3Re
	 XDJhItPWkiGsPucde0oJL1wdlHSH4GEZWo0MRHsHdIVmgXxK9QBQX8RT53MJIZLyDQ
	 FQtx4IVK2jXrDgmazni/jCKlslpogvAw3Zh5hPU+260av7kuSLAtbqlISLPX0xoNAh
	 nxmT7lPS01kyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B74BA40683;
	Sat, 28 Nov 2026 13:39:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A9E763C0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8FC7080E51
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:39:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mgBx9SuAyyDU for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Nov 2026 13:39:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A11EA80DC0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=janislacis06@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=RDpZqYGe
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A11EA80DC0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:39:01 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4bb606491faso46971195e9.3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 05:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795873139; x=1796477939; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4lDF0vQqikD7LUr8D749WPrms9ik25wN2smo9HvyhNI=;
 b=RDpZqYGeomgtJfV02cgbavakfGDHsbX9HJkNmROgRibrTIOCn9SjnsVpdpeJ81w4Uz
 +Kr++JaOqttQon0ip7uPGJbEzEP1vEj4ViMovPJbCjXrCb1bm3G/Rlql1V2Nz5tcMTb1
 s0XBgPJ3knRaWSqEFuiNyhy6VxRA/gnrVK6HEG9V664U9yxF7zsLTwyw8zPPqPKP/aKR
 KAVcaWwYHZEB7oq6y/6Jl3jAn6yIpbUIccy8HgpYaJ+DBSNVB8uzyu3ZL4+3gj9BDazz
 n5OV1XjNZzGLYarq+Lth8B39Sz5RWl4ZD8VfbVctd6C3f3tjpdwaFF7nDt5VqNOyYwWm
 hyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795873139; x=1796477939;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4lDF0vQqikD7LUr8D749WPrms9ik25wN2smo9HvyhNI=;
 b=yfBfJv/0mrw5PxIJEdUP5aRFTCmuz4+LUuB1WhpXlJDUCURoJObbCzZmGBkZ7+rL52
 oi0IYLA0yl1XjKbHK/y6kvX0s3XujwFrlQ3jf0rn/+JQkz3lRKS9mKXkPdZTsYHBuerB
 VMEGphHeaxywCDB5d3jNjh2iuP9zSIVNBeoVAj0XYdvPMxbgQwfW9FPndHOsEsCQja1k
 snedc56RutISDDO1AlMJ/QmHrIQIWqqepZtnoKIsdDFCgnyen0/cYl2CGVCxKvCWqGMN
 gga+hCRXdHQSDla+aP0p4w21QJxsZwpjBKPh7cCIWhXrgM1VpFjBSYY6XIlO2hE2+4sC
 dkIQ==
X-Gm-Message-State: APuU4Z/UlGnIYf3EIR9ksRzrBpR5EcSgp9IsvMttYcAE71jNGgLKPC1p
 JoPC2+K04WLYQEZjkM9Oi3grep38orW06PPqG/hDuJgJgELs7sdx7EsY
X-Gm-Gg: AZFdTZes4NjBG1exq9Q06AgZQaRWbSIGoRCTAwgKhw7mPjrBFFG2GNnp3TXOR0WJqd/
 ntMZzOoh/Wsmb94AiMcHvIX/eJFT86Q/d1gcQxNwrL3Xnpto4LhMv9jWw64e7jxVZEVgsbUw5NF
 3JkuTIPnqRM4ge/A6PGgW61n4ceDRJNYjrHKjShqggFEb9mTaz3Wnxx2zFgP4UTELsuZlgJdpVx
 Q3f5O/r98eWDIcaXYhDMGtrvk3DFNRuEdKUfgm0vffZSP0bgV9fM99iupBtjZbtJDcI6JcqPPqD
 DTro3XDl1mqB6mV6QFiJzk3eiVV0ZkN9TNHe+lJwIcNDJ2CEQrd4COHBKFQKb6C++tLa0c1ARFw
 ndIkA4Vfmq/9gkFrjXbStTg30I/563j/CJ3iNwWP5G442QKzY65rvrHH+DDBSowYRinWlHVbMPy
 SnkVepLHHBmHcb7F8rkWhnTGTXJsf6MPHSPebATG28LN/3hOsVpk+WvJpxyQwZOJFJrb8+5kxMG
 yvNAFUmHSpjwLusMV4onGHfQOCSXi5rtXQak/08YmNmzXzr5OnU04d88JE57/aywPFwouEZ96zP
 NbRrvEF993qkqGecNcc0U0EKQrYOt+fipimIYS9z1d6m6B/K4VYO4weCe9sEwnn9aui+dQT1uNX
 2fv4OW4DLrUvqeYqTOlLvdACAbG2JX2KXzAIAUp2NnHoDEZCrAJnMeuwQ
X-Received: by 2002:a05:600c:a115:b0:4bb:a5e1:74ac with SMTP id
 5b1f17b1804b1-4bba5e195bcmr184828885e9.4.1795873139198; 
 Sat, 28 Nov 2026 05:38:59 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bba6a0d65fsm295847225e9.3.2026.11.28.05.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:38:58 -0800 (PST)
Date: Sat, 28 Nov 2026 15:38:55 +0200
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
 Sven Auhagen <sven.auhagen@voleatech.de>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Kurt Kanzenbach <kurt@linutronix.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v5 5/6] igb: resume the device before changing XDP or
 XSK settings
Message-ID: <lwmb2es2v4j6ec2kha24lk3uxtour2q45fqvjwihl7ik4auvet@jyhouq2ojte2>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
 <20261124235723.1135808-6-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124235723.1135808-6-antonio@mandelbit.com>
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25 Nov 00:57, Antonio Quartulli wrote:
>igb_xdp() can run while the device is runtime suspended or resuming,
>and __igb_resume() rebuilds the queue counts and the rings without
>RTNL. igb_xdp_setup() and igb_xsk_pool_setup() can then see a queue
>count whose rings don't exist yet (NULL dereference), or a NAPI that
>isn't enabled yet (napi_disable() never returns). Changing the XDP
>program of a runtime suspended device also opened it twice.
>
>Resume the device for the duration of igb_xdp(), as ethtool does. Like
>the other resumes done with RTNL held, this can still deadlock with a
>runtime suspend already in progress, which takes RTNL itself; closing
>an AF_XDP socket or changing the XDP program is now one of them.
>
>Tested with the 82576 emulated by QEMU by closing a zero-copy AF_XDP
>socket and attaching an XDP program while the device is runtime
>suspended; the latter no longer warns in __netif_napi_del_locked()
>because of the double open. The races themselves weren't reproduced.
>
>Fixes: 9cbc948b5a20 ("igb: add XDP support")
>Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
>Cc: stable@vger.kernel.org
>Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
>---
>v5: new patch (Sashiko)
>
> drivers/net/ethernet/intel/igb/igb_main.c | 20 ++++++++++++++++----
> 1 file changed, 16 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>index acd9a33..80ae03d 100644
>--- a/drivers/net/ethernet/intel/igb/igb_main.c
>+++ b/drivers/net/ethernet/intel/igb/igb_main.c
>@@ -2942,16 +2942,28 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
> static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
> {
> 	struct igb_adapter *adapter = netdev_priv(dev);
>+	int err;
>+
>+	/* The rings only exist while the device is resumed, and resuming
>+	 * rebuilds them without RTNL
>+	 */
>+	pm_runtime_get_sync(&adapter->pdev->dev);
>
> 	switch (xdp->command) {
> 	case XDP_SETUP_PROG:
>-		return igb_xdp_setup(dev, xdp);
>+		err = igb_xdp_setup(dev, xdp);
>+		break;
> 	case XDP_SETUP_XSK_POOL:
>-		return igb_xsk_pool_setup(adapter, xdp->xsk.pool,
>-					  xdp->xsk.queue_id);
>+		err = igb_xsk_pool_setup(adapter, xdp->xsk.pool,
>+					 xdp->xsk.queue_id);
>+		break;
> 	default:
>-		return -EINVAL;
>+		err = -EINVAL;
> 	}
>+
>+	pm_runtime_put(&adapter->pdev->dev);
>+
>+	return err;
> }
>
> int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
>-- 
>2.56.1
>
Reviewed-by: Janis Edvarts Lacis <janislacis06@gmail.com>
