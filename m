Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20598606A31C
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Nov 2026 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=TnoglVs9;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oM8b8xUl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F20BA81076;
	Sat, 28 Nov 2026 13:38:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RJ00qOUqF5hI; Sat, 28 Nov 2026 13:38:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 29D7F8108C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795873086;
	b=c2hASKW64NZnoHMxSLLK+iYO3gTN5lioIKmbF1MMUk2Lbyz+dynmdcIvKIasgMmOMSac
	 7XTEzc+Oij0fyJf1dN2EfyHjG5deLp5tB+6fZFeu5tfV+9cPo7bJeZuzAOsiab0uAvGEe
	 FkyBJTAL+MIuQG0uZMtjweMVd3fVgygfSv87BbQDvdQEodt/51o98k2yLcK2qBDrOkY45
	 WX/4/bTfdwhMhx2+B0hVF1rG5aREA8i6dODBrdnABRVQUr/a3TUQtbMiY5FMGC8YoGw/z
	 qeK+jJu2F/sdkPxzPcCwmvDMjihjPAQqJTEiDxrqxy0I0Ap8EnXpBz35Jv5gurWekyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795873086;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PmOWW/21uAJZG68ORk4wUvCX50AXcNvmfcHlnPOThNM=;
	b=RwPaFsSa1eeL4SOqJF8U69GJfgKGdk8A1P3VnHrWaq/NQJv4LVbvFAoxRlNA832pAvz/
	 0T5x6aber+vU/zW3KcYexfaoOozJ1hvAdDLlSBjoTnsacUtWEPdvtKndfHlfh+IJFaE8j
	 7dxhE0pWynBO3OdXHzTmIRuTMpaqydkBJuBB99oA73HqCW9poux9aczmiWLJcmj3jkv7A
	 f6WQnceBeAkrRdghJzJBZEoptLyqlpufIujNtg3s+7WrtnMAPfabMgpdSNIwLiV3HUKwe
	 dp3Q0HDE4lGBJFcK3ws96qLQtTQBwUgRUympdSQkDCoDhAws8vrDGQd88S98MwxNhGw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795873086;
	bh=PmOWW/21uAJZG68ORk4wUvCX50AXcNvmfcHlnPOThNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TnoglVs9vbMFHMjYhCUkU2S3rWS0fykynSYN5cGMtvjjwLKQESS+VbpFkhmdoUwC/
	 syx45EbNaF01y7bE7rUNasfiHSgRI3IZ1cAVux5q0i0IWe6pxaxIbLfcr6JAcr54Jc
	 0AvGybEIcumScCgLMo96QvXtnabhAe9dgTIpBq/yiTI/+/j0bsIOpu+Hri6RIUjuZ8
	 uIr9VdXdAVgqeREPNlkt8kDCEf1ssZ/tSRAE56M3KwN9v9lsqDQ1k2E9K52UaYwoGP
	 MTVaynzowtZKzL0LKgDBowWkwDEGD1qThCo06TtJsNLsyWOpO4evLKDWPuR+hFccVw
	 uxLo8zSPE3MOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29D7F8108C;
	Sat, 28 Nov 2026 13:38:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 26C7A472
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0D1826063A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:38:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ozCq6Rw-dSPv for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Nov 2026 13:38:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E93CB60635
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=janislacis06@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=oM8b8xUl
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E93CB60635
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:38:03 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so5054709f8f.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 05:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795873082; x=1796477882; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PmOWW/21uAJZG68ORk4wUvCX50AXcNvmfcHlnPOThNM=;
 b=oM8b8xUlD5CPac8s+zt1eKAJqo10VIdH4Muxp/jg+EdaWLgoawIgUq+6wQS85rvzuy
 4+NCHlH6dIXzAA9ypLSpAQWlH+kbsBwLhjS+n+B2IJVGsrHzGltLc3uY23rrY0e/wxOG
 yupv0+rBAdrL1FNPFErgIJdRmxKlW27Xj+bKLGG46gOiauX5eNqekYTytnPoyRV9+vvs
 h4EPu09NSCx2H6U9CHlLQIZfD9yibjpG3OTZwn6hiQMmlgDLoYTymxyWn5bkSV2G8YRa
 QZ1RzUnWudwcBXbQ166OQYn/FoLJkb5OQpZceusIBILGw8c3iAEG59cMUh5hC/XqBPw6
 6S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795873082; x=1796477882;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PmOWW/21uAJZG68ORk4wUvCX50AXcNvmfcHlnPOThNM=;
 b=sTevxkrF1P24cKnMMtJXKbXXGeDxQLTJBWbEoUeAst07RMuYa4XUrZJ3CK9uWWUBvH
 r0cZNLwPAm3eNcS3gf+Zx00fTEHUR3rHiVNttW3jBQmTHASCqTZhBClq77tB/cE6CY9o
 bfo2ZZrxthWx87+W4wWDZakNG+tKbVkcVldlZHotstNjyZafwYCByq/raihYd9eKsWBP
 Gs7vC7o1nf609E6oBFHHe1Bv9Y3f5Idqp3aw4nqWoQxmruTWcFwOYqT7+3Xbr2SA+8E/
 nQJDypNuhfWkjSw4A4Z8s9aPSlUdArfVPTZfr7NBWzNNDYicD2jxbsPG8qSWFEoKfIIZ
 m+VA==
X-Gm-Message-State: APuU4Z/BNOth5LkUtuTPaiDsKpI6dRnaz4aKKf/qZVZdifCILBkAR5pG
 8uLFfsc12b/kKT1pZhuSH1ANbjLV7df+7zdm6uSwSPT528Zp/mT8iYHz
X-Gm-Gg: AZFdTZfgukjUbGoQ3Q7unEOtjWP2qmTWkHuzsCt0FAz4Z6e3lAy7Jm8J9U3+6d5kk8L
 m5waubgXGR8K2zXBhLRiHP3uBIvKTMmJEfgQOt816PGedOxTZe5mWGlNWKjZcpo2UCDHTC4+ZkF
 FBejxkCWdJQKvFPgAql2bsCaQK2rVB9cno4PG7MjStQhickj6QeEcPXdNQUO8dGh7gKJrzoNppU
 K7FiK/ScT7uMewzCIo2+3HbEyOPU8cWforeP3TUl0M925aMLxtnnMQ6ekpx9zpaHubal7dh1JaS
 yf8FCUe+FQrBegbB4r+UfRxcZappVvbjhPFppgpV3JRqxJlEUnDha6sDwWboN2xnSTqWM5FoiRc
 z1rvLfdNSH3bbkg3GQAoOgcYhKYxGlTUosPmU0d8JaEOG0bi/gA1GkdfU5l9TYkTjdwhTCiiXlu
 67f7bKquHHOblPDdpUxH/18Ek5gxYvWItmjMkYMI8AaoUiZbYab2C/2EjBZlRw8+FBmQSk9OlKy
 +Ksold7j9TyLynWKe1lI0OPsjr6ayAsCbfZFKzbtwq4ygXJsstgdFKMOEq/PS8uCH2ef9Pzh8iM
 FQ1ht1cF6QAKaJSqXUqDsQSsCG+ygoLf64GilCIuCb56rT84cq6nTIULOyN6xrYX24FAK+sDoHc
 ID0xtri8eTV/4i2h3bgG5SyjATt/ZvV8qiJoOEe8yUYO1nkmVwTkX9n+1
X-Received: by 2002:a05:600c:530f:b0:4bb:68b9:f615 with SMTP id
 5b1f17b1804b1-4bb88810b22mr557268675e9.17.1795873081828; 
 Sat, 28 Nov 2026 05:38:01 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm867254155e9.10.2026.11.28.05.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:38:01 -0800 (PST)
Date: Sat, 28 Nov 2026 15:37:59 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Kurt Kanzenbach <kurt@linutronix.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5 3/6] igb: keep the stack's Rx queues that still
 have an XSK pool
Message-ID: <jecu26h33ryodbwaalfgihqzgb7axxffhwtboi4orym42pfcsn@7x7cx4r76rin>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
 <20261124235723.1135808-4-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124235723.1135808-4-antonio@mandelbit.com>
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
>When igb lowers its queue counts by itself, after a fallback from MSI-X
>to MSI on resume or when enabling VFs, xsk_get_pool_from_qid() doesn't
>find the pool of a socket bound to a removed queue anymore. Disabling
>it then fails ("Failed to disable zero-copy!") and the pool's DMA
>mappings are never unmapped.
>
>ethtool refuses to remove a queue that still has an XSK pool, but igb
>can't refuse a VF enable or a resume fallback. Keep the real Rx queue
>count up to the highest queue that still has an XSK pool instead, so
>that the pool can still be disabled, and lower it at the next open. The
>Tx count follows the device: an XSK pool is always bound to both an Rx
>and a Tx queue, and the lookup finds it through the Rx one.
>
>Tested with the 82576 emulated by QEMU and a zero-copy AF_XDP socket,
>bound to queue 2 when enabling a VF, and to queue 1 across a runtime
>resume forced to use MSI with a single queue (with a test hook): closing
>it warned and leaked before, not anymore.
>
>Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
>Cc: stable@vger.kernel.org # 6.14+
>Reported-by: Janis Edvarts Lacis <janislacis06@gmail.com>
>Closes: https://lore.kernel.org/netdev/xupy6jbpnziq2qji54zjbvm7neggrwkxg3sfrhlolmrd6ysifl@zptk6ynkbu5f/
>Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
>---
>v5: new patch (Janis)
>
> drivers/net/ethernet/intel/igb/igb_main.c | 27 ++++++++++++++++++-----
> 1 file changed, 22 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>index 2f51edc..6961646 100644
>--- a/drivers/net/ethernet/intel/igb/igb_main.c
>+++ b/drivers/net/ethernet/intel/igb/igb_main.c
>@@ -4126,6 +4126,26 @@ static int igb_sw_init(struct igb_adapter *adapter)
> 	return 0;
> }
>
>+/* ethtool refuses to remove a queue that still has an XSK pool. igb can't
>+ * refuse when it lowers its queue counts by itself, so keep the stack's Rx
>+ * queue instead, or the pool couldn't be disabled anymore: lower the count
>+ * once it's gone, at the next open.
>+ */
>+static int igb_set_real_num_queues(struct igb_adapter *adapter)
>+{
>+	struct net_device *netdev = adapter->netdev;
>+	unsigned int rxq = adapter->num_rx_queues;
>+	unsigned int i;
>+
>+	for (i = netdev->real_num_rx_queues; i > rxq; i--)
>+		if (xsk_get_pool_from_qid(netdev, i - 1)) {
>+			rxq = i;
>+			break;
>+		}
>+
>+	return netif_set_real_num_queues(netdev, adapter->num_tx_queues, rxq);
>+}
>+
> /* Some settings need RTNL, which isn't held when resuming from runtime
>  * suspend: apply them from here instead, if the device is still up.
>  */
>@@ -4137,9 +4157,7 @@ static void igb_rtnl_resume_task(struct work_struct *work)
> 	rtnl_lock();
> 	if (!test_bit(__IGB_DOWN, &adapter->state) &&
> 	    netif_running(adapter->netdev)) {
>-		if (netif_set_real_num_queues(adapter->netdev,
>-					      adapter->num_tx_queues,
>-					      adapter->num_rx_queues))
>+		if (igb_set_real_num_queues(adapter))
> 			netdev_err(adapter->netdev,
> 				   "error setting real queue count\n");
> 	}
>@@ -4208,8 +4226,7 @@ static int __igb_open(struct net_device *netdev, bool resuming,
> 	 * runtime resume igb_rtnl_resume_task() does it.
> 	 */
> 	if (rtnl_held) {
>-		err = netif_set_real_num_queues(netdev, adapter->num_tx_queues,
>-						adapter->num_rx_queues);
>+		err = igb_set_real_num_queues(adapter);
> 		if (err)
> 			goto err_set_queues;
> 	}
>-- 
>2.56.1
>
Reviewed-by: Janis Edvarts Lacis <janislacis06@gmail.com>
