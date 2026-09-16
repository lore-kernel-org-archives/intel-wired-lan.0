Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF91C88E5C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 13:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36040406F7;
	Wed, 16 Sep 2026 13:28:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XVZFM3DaGW3k; Wed, 16 Sep 2026 13:28:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8A52140708
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789565310;
	b=N45IiZQ6n2ZzrA6E+JM8z2UCYeEVgCHXaVdVkq+2/IkgeoIJHeVylSI9Hj+ZKw23MKkM
	 N6GStj1VR/EAePz90T8g42X0UaYFBkjozJEp9pmcsK+4AVo6sTTG7OauOFIiGjnYVhRZI
	 H+6qqf+anql7qq9srDFmOJGQj2md1Rl0BWY4FsHm5wQRO1vVIm38t5cR2YbVcwECZi6o8
	 A4F/gegEPjlvdMVmWtOKtCiH57hVnXHgDUObh3xAzoXbws29xBgPpZRuq2o0EE9Go2imf
	 N/pPWR2QXLv++VTJxtJ/t02fRhZgPFu+9xhIOGYeaghw7ulDfwlSFgms34yk9gmIigA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789565310;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mUeWvQyELQ91Zo7gd0quF0DPhsMTPLIThzQR0sZzvog=;
	b=ou/5BBUSaWGpP8/0/rErxx50mWXbx+eI+9CvN2YW/gyz9CK52XBrai3Eio1yKOD691oC
	 nlohJ20rpJxzy97i38PlWEuVfJGaP7eHU/FPFHDKVPl0xig+ycrvxKsKgmcIzhvtH/v6o
	 TyPdfzBaM08FtI8l3yA+KUlM03ULZExOpVfL4PKLYaR4eVwJpHcRIUt48N/HqdNcxAJK3
	 sVnXiS07sl+Bgeke1DSc2hE3DZwzCAtYXB6OlMbNVmvSCxdIe4ViQMNFZUKdGAzqiftgX
	 uO9gTsEiGptEGUNO8aT8WX+A4nFkY6KWvfM0ubmYqkokBRmUtTFQZy++yh6UpJNqCtg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789565310;
	bh=mUeWvQyELQ91Zo7gd0quF0DPhsMTPLIThzQR0sZzvog=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=8xOZZ4wDehnbKVd92f9J8aGjC+P61W3zLVVqyb+MqpA4sPM+vRxPN2FEGYAp+rDkA
	 LZm9nqt23R/yUpFpukmN6SX5cNNBfuVdMZ7YCtTiLJhV4hbSVbm6WguqdbCCY3PUc1
	 OjY7HCfxhVNC4/PFFeeBgoCI/sG2o6c8OvMLFIO7k8UgqEn0Quk+SLFWM29j1MrnE8
	 oz3qzKecORMG17R/7fyEkpzTC/GpkvIjENMj5layfPj+SzjlJ4CZbdrGO1LBcjzipl
	 NBXaIUB3kKSRy2Zfwx7Q2O0R1ZeE5p4Wcj4Z3C5rsf+DFHtuRKZEp6PFY8DqL8zKNt
	 NCdnPcj95cRug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A52140708;
	Wed, 16 Sep 2026 13:28:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC9CE24D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D280E60817
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:28:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CTi7yjRs4XEu for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 13:28:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 636C8607B7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=220.197.31.6
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789565308;
 b=r0xw1Rh23eUbD9dDHNxiQd0dvo5AhABJ1WuvFDvdvhU0glH4JhlE7hdHsDRIxk0YO+Zi
 GlhKnCPFOgQ6jrkeqGNVjqUMWtu5eB8urDq2nractDYOjVnEoTQhzfoqPcBfZ4pMBshcy
 4p/SwhU7T00qiHN4S2qst6VG+Wg6EkS/FN+21ZSbasfqdOwc/0EqfSPIkKc7gdbEgNzZr
 c5ASssfq8Pwqo5/xNzvkGQNdMb8/7sy8aiye2MIqqHLQRw/XfKgpW9X76USEgmp9aScE2
 evfIfa7YwIrAdijljHm75SD7Nh4LDQf7XQZOONEQPmSZEnJD3Cr8R4gXojqbuYAXgug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789565308;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=mUeWvQyELQ91Zo7gd0quF0DPhsMTPLIThzQR0sZzvog=;
 b=VnTvYYUQzS4aXit8qQw/aTFqKJMFy/xmHcH/6Di6AucIJvly6HC2k43TLQ3FDPNNwNbY
 w79wHRQD9Wy9hvTsncOtCKp8D9QY0cSYSyXt2erMG2hA6bA+hG0ohGghmEZKQko7y111w
 2ZSGdaO1b19HlJqSVsYxjvDVdJuYkOer4PZ80O0zdMQVGqiFtud5yUMdMxhyrEk5nCwmz
 ZJmVl+j/zJSuC4cFDMtJLcBPowacFjZf6pF3igbwbaZg9PeuF7pglGh1KLtWvMERq85gJ
 7y7Aj8wN9ZGrqN/e8D1Cp5qiRXypXMq7xqA3OPeJfrwG5f+aYwMEKb6tXnYnXTKVmoQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=FckN4SA3; 
 arc=none smtp.remote-ip=220.197.31.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.6;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=FckN4SA3
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 636C8607B7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mU
 eWvQyELQ91Zo7gd0quF0DPhsMTPLIThzQR0sZzvog=; b=FckN4SA30XOP6w1T8p
 4TiZwK09qFPed466ZHcJoH/Ha4DkptRPANfpFDGVbaPNK2iTvxQ2yFu3Yt0jhuOi
 KwJpH+Oqqn0QMpbuvJkWV4NUlDokgKxHx+UYSRiM3QJsSUp3uOqH1+gjvwax8rqF
 mlU5vRsnWVvSTkauwH2Nr/qSk=
Received: from localhost.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PikvCgDnvepPmapqaFzjHw--.21948S2;
 Wed, 16 Sep 2026 21:27:43 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
Subject: [Intel-wired-lan] [PATCH net] igb: unregister the i2c adapter when
 register_netdev() fails
Date: Wed, 16 Sep 2026 21:27:40 +0800
Message-Id: <20260916132740.1001797-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PikvCgDnvepPmapqaFzjHw--.21948S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr17Wr45XF17Ar4DAw4Utwb_yoW5GF4xpF
 4DAa4fCr4jqrnFga1DJ3W0yFyYkaySk3yYka17Zw4fWFn8tryDXryYyFyYyFyrKrZ5u3Zx
 tr4qvw15Cr1UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UA9N3UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQ++lWqqmU+yYgAA3L
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

From: Linkui Xiao <xiaolinkui@kylinos.cn>

igb_probe() sets up the bit-banging i2c adapter with igb_init_i2c()
before it registers the netdev, but the err_register path only zeroes
adapter->i2c_adap instead of unregistering the adapter. On i350 parts,
where igb_init_i2c() really registers the bus, the adapter is therefore
still registered when free_netdev() releases the memory that embeds it.
The i2c core keeps pointing at the freed adapter, so any later access to
that bus dereferences freed memory, and the adapter number is leaked.

Call igb_remove_i2c() instead, the same way igb_remove() tears the bus
down. Move the helper next to igb_init_i2c() so that it is in scope for
igb_probe(). i2c_del_adapter() returns early for an adapter that was
never registered, so the parts without i2c support are unaffected.

Fixes: 441fc6fdb47a ("igb: Add i2c interface to igb.")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d4a897a8c82c..f965ca144f42 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3190,6 +3190,16 @@ static s32 igb_init_i2c(struct igb_adapter *adapter)
 	return status;
 }
 
+/**
+ *  igb_remove_i2c - Cleanup  I2C interface
+ *  @adapter: pointer to adapter structure
+ **/
+static void igb_remove_i2c(struct igb_adapter *adapter)
+{
+	/* free the adapter bus structure */
+	i2c_del_adapter(&adapter->i2c_adap);
+}
+
 /**
  *  igb_probe - Device Initialization Routine
  *  @pdev: PCI device information struct
@@ -3657,7 +3667,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 err_register:
 	igb_release_hw_control(adapter);
-	memset(&adapter->i2c_adap, 0, sizeof(adapter->i2c_adap));
+	igb_remove_i2c(adapter);
 err_eeprom:
 	if (!igb_check_reset_block(hw))
 		igb_reset_phy(hw);
@@ -3849,16 +3859,6 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs, bool reinit)
 }
 
 #endif
-/**
- *  igb_remove_i2c - Cleanup  I2C interface
- *  @adapter: pointer to adapter structure
- **/
-static void igb_remove_i2c(struct igb_adapter *adapter)
-{
-	/* free the adapter bus structure */
-	i2c_del_adapter(&adapter->i2c_adap);
-}
-
 /**
  *  igb_remove - Device Removal Routine
  *  @pdev: PCI device information struct
-- 
2.25.1

