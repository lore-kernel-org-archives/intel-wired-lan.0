Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F60606A31C
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Nov 2026 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=2FRCw9Md;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tcQjIkvV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF57980DE5;
	Sat, 28 Nov 2026 13:40:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cRZGVfKsl6QO; Sat, 28 Nov 2026 13:40:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C8C1A80F5F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795873231;
	b=cXkJ5xFBr+ZBZv7TpVPNV15oVtJDi2Ow3MWdt/AfCZBfGuw9BaM4f42eqvJNKoO0ybUX
	 q8LWMJFMfyzY1CxWb8h7RwtskhcL5J3kLf7IUrzX7OUDPWKL0tMHY/feXVyJ2TNZ48tZv
	 q0ryJKQ+0j2ArDKuHjvSmvwQM1kz7QSFFkuP0DLlWJNSuWPEEhu+/YtuGbT7/vbBr8Etl
	 iNCM3jIFLEiIjD95nfKkNU+jLQDPafQiy28RDYoHQu26N+PTVzbsssXJS1uj8i+Rhf8XO
	 QXpVV/Y/o9MQxOyvi4y8LFVT4cGeGjM6ojRu8tvzlOsI+cAS9SzMO5RvnBLoXaVBZDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795873231;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QyFV4pisqndkw4NPxkRB4pgaLfPMNmkrYfYabK5Jawo=;
	b=L4/xNdPa++Isr/BhOfZK4M7neqj8xG3rDiVb2j2WHXmIxZiyZjcahrjTbXVNa6t8r837
	 ZbMXSCq27hHBdQx8O3ePUXlI4Ctkswnz/n28rAuMtKgi4kDnIP5osAk7Ef5P76YM4Bkfu
	 1h0rttGkaV7AlvoefMjWyoBaiGHrk7VVzvekKFHpnoYMcM7FJVEF+Uv6GGoaJVBUMfW5l
	 4B5/3zMaj3Q4+Mj8lCIWI4v26rzymIDI69OzADG8M0UzY0qsHVMvu1pqFK6nrm2qJ9R2c
	 nK4tiT8PvXXH57fWb57syqeopyCevof+QwhtuZwQZ/NTGBvr7fssfXfsrSbY5dyuSVA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795873231;
	bh=QyFV4pisqndkw4NPxkRB4pgaLfPMNmkrYfYabK5Jawo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2FRCw9MdodC9KQNbGbzDkhKm0XG52bDLWkHUY2NjrhCQA7VDeAxwb7Bt/p+5AJiyo
	 3TTEG1WrUAPE9R4Jqsy3WEsdMerUjARWsQnWY2NY6On8OEbUXkFcZY+wcFrLynlNyJ
	 K3HnK2moYEjU1qqNBRJtYPoe5p42PDdq4UvS+jrQIXdG1MTJt3mKTLBuj34Mvsxgfq
	 HJkjEXg6Tjq9wnjsv0SOwt+uEMZPHNJH7apgOnySQ/k6YVbXlxEFKLjYHTZLnF4UuL
	 F37xVQo6dbzRmUTNJIzL4mbLlNDVoz0I9WcpYcUyoSJX7MGAjzzZxjviPjXjY0Gmca
	 TTKdGMnew4Q4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8C1A80F5F;
	Sat, 28 Nov 2026 13:40:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F9AD3C0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9AB6400CD
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ToT-NaSX25Bp for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Nov 2026 13:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C1AEF4005D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=janislacis06@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=tcQjIkvV
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C1AEF4005D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:40:28 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so7644365f8f.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 05:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795873226; x=1796478026; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QyFV4pisqndkw4NPxkRB4pgaLfPMNmkrYfYabK5Jawo=;
 b=tcQjIkvVNxwSwRTE2zZCyoC+Gyb2chkfWP0lzli+e1VdirTZHmYuAYuNwF+83PM1aI
 9et+IAOUGfjNj9TCo8MIXuiIFbVHVr/6IYusGamuEwaqrVBerYwkUChI7nT0PjPRG4m0
 fxiC1G5eHiWxi2BjbmdhS2zIAftMBY3oOg+zYbHakoiTjGYqDOMJqKqhRRya8Z+uj034
 dl/QMPWoyxczIMiW8feR4KIbq0Gfrsd7dR6xMMc33vdNiZ04DvCXt8etRDSMQnFdw1ab
 Mg0J2V5Rt2fveWjkF60vwMqGIpl71jNKlPP88EdGsH+nNRtxIyrv6yuJdZg6d5jwNf4H
 WZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795873226; x=1796478026;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QyFV4pisqndkw4NPxkRB4pgaLfPMNmkrYfYabK5Jawo=;
 b=dZC7gN40rK2Z9mJAun71Bwynkn/qs2xDU4faGkT9Xtz9Rhukl4Zn0dWf9xKVH+LC2o
 b+rzrRG4V1SPzQcCC7k5Dgqz6PNkxxxMoZPuGqZ908+x7SH9go9h1B4J9QBoEw4ya5Ha
 9D0Q9hKUkjPr6ojOUwahh9mmXOubXnXEhYW9VIYyncqtAaMLn6924Lhle4KjEH0AfJso
 PxbzcsogvOg3kxar24wFL/RCQ5mqLGXLLyYpXUcrn8g1WAyiDArEtNfH04tas0mo1buV
 TbX2TIjon/KpCJB5w9nXeqJrnsoadKtJVhiO3uIzLOryFXNRKropdftJisjBo+p7FJYE
 F3nQ==
X-Gm-Message-State: APuU4Z8wVZ4MmG/NCIysNphApVorkW0muaOZ7lUBik0MZmURIgU5lcdM
 CiKr4NVj5iX9Pr5XmQhlNCTOADhTy5yECOKUuwdkzcUNpVq+X8YSxM1Y
X-Gm-Gg: AZFdTZdiVytjagptTdFl0JE8qBB/gSiiLApMpe8mjczbZysu6tejUUWZuNliuNg5p8N
 ONWDj7+URbs8+BDSF5LLcmjAXfeuE1np8q4p4U8zrhvRR6T5rjOaYr5xsC0Wl00qv5Heq+l1Srl
 PNlY/Eoy5wRQjv1hDzkng311MOO7U5aXCWL2x1gQwkURg6bnWydy+j4I8RMy4lNssvYpBnPPbjK
 UgCcltmsuAadj0PXANTVCn5kQ9uvVgxx0hfjJgpeNGtBv7hpbMEh1GtGeK8AjgLQroNGkiTznfx
 qOyvCzHLTOhgIt+cXQ4w++IB5xomBiufiso9+sdw7dOIZEM/9AsDNXekUAN8m0G9fzKvety/wEk
 1Ok7KCASfVrKCXLgcvUgNkRRmpxw+yNRJlDcVlkrkIJWe/sey646dvXp/dMrgzroZiU3be+35pI
 XdgR2HnlOdlbsR/m3jJkxowio5NIBU21z6htaJ8rkV2RFyaXR9mRzNGkIfgbKENwgW6zvpFdzrh
 cQlv+9XL6B7GEjkfPcE0Kb+F3A9FjBeAo3zX/bMaCcwEQlvwIt3bG5zJjjr45OQ9l78Hfzix02y
 osVI1r7w4RZvjU9BVn1KlBes7WXsreeXOo6QMuUc16wyQOlKyrqPnsP80duNtYe4PSdesH7irvD
 8jfCEG9AE1AQG+CuUj+6dFVCtj9z/DcoGr2U=
X-Received: by 2002:a05:600c:4e16:b0:4bb:69b2:d3df with SMTP id
 5b1f17b1804b1-4bb88813024mr568205445e9.25.1795873226378; 
 Sat, 28 Nov 2026 05:40:26 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm1404838525e9.4.2026.11.28.05.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:40:25 -0800 (PST)
Date: Sat, 28 Nov 2026 15:40:24 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5 6/6] igb: only allow runtime PM if the device can
 wake up
Message-ID: <ri6pk2cv4qsc3lyumnpskogyadfhhk2aybgwyvbpdfoetkrbjf@efy5saiqmdzy>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
 <20261124235723.1135808-7-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124235723.1135808-7-antonio@mandelbit.com>
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
>igb lets the device be runtime suspended even if it can't signal a
>wake-up from D3. Such a device doesn't notice the link coming back, so
>the port stays down until it is resumed from user space.
>
>Only schedule a runtime suspend if pci_dev_run_wake() is true. Devices
>that can't wake up no longer runtime suspend, even with power/control
>set to auto. Checking it when scheduling the suspend, rather than at
>probe and remove as e1000e and r8169 do, keeps the runtime PM usage
>count balanced if the result changes while the driver is bound.
>
>Tested with the 82576 emulated by QEMU.
>
>Fixes: 749ab2cd1270 ("igb: add basic runtime PM support")
>Cc: stable@vger.kernel.org
>Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
>Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
>---
>v5: check pci_dev_run_wake() when scheduling the suspend rather than
>at probe and remove, which keeps the usage count balanced (Sashiko)
>v4: no changes
>v3: no changes
>v2: no code changes; mention the tested hardware
>
>Note: igc has the same issue: igc_probe() also allows runtime PM
>regardless of pci_dev_run_wake().
>
> drivers/net/ethernet/intel/igb/igb_main.c | 14 +++++++++++---
> 1 file changed, 11 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>index 80ae03d..853bdf4 100644
>--- a/drivers/net/ethernet/intel/igb/igb_main.c
>+++ b/drivers/net/ethernet/intel/igb/igb_main.c
>@@ -5625,6 +5625,15 @@ static void igb_watchdog(struct timer_list *t)
> 	schedule_work(&adapter->watchdog_task);
> }
>
>+/* A device that can't wake up wouldn't notice the link coming back while
>+ * runtime suspended
>+ */
>+static void igb_schedule_runtime_suspend(struct igb_adapter *adapter)
>+{
>+	if (pci_dev_run_wake(adapter->pdev))
>+		pm_schedule_suspend(&adapter->pdev->dev, MSEC_PER_SEC * 5);
>+}
>+
> static void igb_watchdog_task(struct work_struct *work)
> {
> 	struct igb_adapter *adapter = container_of(work,
>@@ -5777,8 +5786,7 @@ no_wait:
> 					return;
> 				}
> 			}
>-			pm_schedule_suspend(netdev->dev.parent,
>-					    MSEC_PER_SEC * 5);
>+			igb_schedule_runtime_suspend(adapter);
>
> 		/* also check for alternate media here */
> 		} else if (!netif_carrier_ok(netdev) &&
>@@ -9741,7 +9749,7 @@ static int igb_runtime_idle(struct device *dev)
> 	struct igb_adapter *adapter = netdev_priv(netdev);
>
> 	if (!igb_has_link(adapter))
>-		pm_schedule_suspend(dev, MSEC_PER_SEC * 5);
>+		igb_schedule_runtime_suspend(adapter);
>
> 	return -EBUSY;
> }
>-- 
>2.56.1
>
Reviewed-by: Janis Edvarts Lacis <janislacis06@gmail.com>
