Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A8AC88E7F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 15:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8ADBD80A56;
	Tue, 15 Sep 2026 15:39:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kzzoO3hMG883; Tue, 15 Sep 2026 15:39:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7A7A0809CA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789486749;
	b=cnoW2d0wTtYUEDzEVfhdSoSs4rslHd4LyprdZdKaI+ixefRmLo7oGJM+3ePLKxNC7vY6
	 3gMr6OBcwlgCa+iPo53dnLR9yXVmb5vGrvkmiCX1Ehg1tkg/zHAy4i/LwHyMLEQ8fnENZ
	 oSd6lgsZQLaXe4XBe4P9bqiBaujbGgirtCpsx30czgP+scopCn1EAyLPW9RwbEVCLFLbI
	 4vGX5Uk5i0U69zKFRUucODDNiv/tBpgJkQcE/QzaPWHKMeuCneePlxZURhZASSckpdCfH
	 IIvK+XOe3F7AI9cGXntsBJLV176WAIntCFIGL9HtgAynMBVN0HrrD1jdDLQ66uIGECw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789486749;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rmJRg/Am0hi7AntLZKSZ2ty+PuBbNEcVd9oFLNxQpA0=;
	b=OHaSuyY7TD8lwo3fklnLBaIdnC7iI/a1Uy2SIFGjAqBIvMoqFCYM5hF7BwiyMYDV2EsO
	 RJJYJP9jaFZgPsfoBzQ5gA9ENGx+GOtv1tbfL6ula8rVHsy1zlGxls8zh1jvENAJepQoK
	 oLHwKbNzzZN5oI+TS2Qc6z4YQoNQYQGXY0zBhptFXdeDh99kjUZchnUwlS2KWRfl+NsfY
	 PJAzeiotuPPrLl6hLQB7HQ7EQLJB+s2Q9wQUUp3wgxpnrAs2xXeEEsg0jwBnXeFtBfzmb
	 hx13nckVl6nzwF+O/a24O59JZ4aE8j1ZlsYS5MrJU0a8FoJDSpb0A+m4Rci2ME+vArQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789486749;
	bh=rmJRg/Am0hi7AntLZKSZ2ty+PuBbNEcVd9oFLNxQpA0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=3Lj5eqCSZOzoO/hMp6zO58V5n1mlfipYLt/golE0vhGsTw86wfwtKIYi4OMYULIMk
	 UkuwWySSPxWUQMaJSJa4bw1q+KYYMCE5Yr5LV+8cWKMNAty9Yni0FbeXUbUHSo6SR/
	 l19fOISCePQ9oZPet0BFY4kcK5MBNuUMJEzv9Bh4ASU7GYiwIVMUJ+0kpWjIExS6zp
	 DE8FJhZICZH5fd8WLZrlgmS4QsUCreMvAvdW+QYA/hzKlJUZ/VZC5VItvwFFckeJLS
	 cgTZdvhhV06SbGJrBbVxkPEYK3P8Y3FRf+bfxzS5VHZpXw6FwxHStJKPgm3Tq6RB8P
	 wqoQVW2JVi3Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A7A0809CA;
	Tue, 15 Sep 2026 15:39:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E9ADB2E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 15:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E6C3B60735
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 15:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xMyqiZ_6_DPN for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 15:39:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6E00560732
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789486745;
 b=b+MYu4mtM2e+GJyviqcXqRjA8Ag9xCraJSxsWsf+hOhf5AQHEArwi9yYk5Cs00bjia8u
 2ejpO9eqSt5FkWS5Q4vwBUHgdIVlQVl7efImjKTpM/JJnCygKJ2hN56BvPDt9ZH9aCFSo
 CnACEudFnngx6Ki2cSH0KiVEtOE/kHgOm7HqP0XB93BTL0q2vGgsidtRFlITT99A4KN/P
 cUX9yqn60tBv5JX0itQ3QWbiPuavMZ1SVqwyppG8k8nkHNmX+mtdZDYID8Hqj+AuhJs3A
 e7NrhAv/Wh8Zi7asKcZ5V2J4v/2/1aAKRuybPsiNn2nKaLySqMe+tZZA3vNcGrcIXcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789486745;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
 X-HM-Spam-Status:DKIM-Signature;
 bh=rmJRg/Am0hi7AntLZKSZ2ty+PuBbNEcVd9oFLNxQpA0=;
 b=JneEnB7FpmbgmNFDp47YKOgBTebJxn14JjVk8Q9s5SuzT7+73znH1rYsMx+fVbjYBSwA
 GTg7s9TkzQtFt+ggpyB0jm8X7LgAyBeoo9dl3La7dhvobZOF9Zna+ZVFRo+Ey7MsPcBB0
 uM0vSNa2ZfqyVkDGjMScTqXTPlTS0J0/MSzvh8co7CBr6D3u/4Q4YD1/qOq+EgllOYLFe
 aslLBKxEbHMbdvNzNDmBVV3yzKyEgRMI/H8/56rmePS0FJnAGNro38Nr+8eBxJ4as8D5s
 /lELRK2Q7fUa72AHSNkk7qlxB2lPHGln9i2Ki7yCcKc4fQoz/yiM9OK7QiqcmPEBB7Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=seu.edu.cn; 
 dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=l4KoP7F1; 
 arc=none smtp.remote-ip=45.254.49.197
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.254.49.197;
 helo=mail-m49197.qiye.163.com; envelope-from=runyu.xiao@seu.edu.cn;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=l4KoP7F1
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E00560732
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 15:39:02 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4ddda0bb6;
 Tue, 15 Sep 2026 23:38:57 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bruce.w.allan@intel.com,
 jgarzik@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, aleksandr.loktionov@intel.com,
 runyu.xiao@seu.edu.cn, jianhao.xu@seu.edu.cn
Subject: [PATCH net v2] e1000e: roll back registered MSI-X IRQs on failure
Date: Tue, 15 Sep 2026 23:38:50 +0800
Message-Id: <20260915153850.1704903-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0a5b8aa0b03a1kunmde9de9ca2e1844
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQhpCVkkaSxgaSkpPGUweH1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=l4KoP7F1ccZ19J9s9emNvOtdcSGqFZ0nySjWd4Axv+n8q/+epu5SUdlj8eLSOMI9y0H2LLDeIb0TvP1+GT4MwrN0lw5krh9nTY+TvHkTM/6AxeKqXcolZNN/PiGr+kPsc6FJUEKeXz0S8pDBQP5/tKrUMD4DcdnA+nnEMB9fbWo=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=rmJRg/Am0hi7AntLZKSZ2ty+PuBbNEcVd9oFLNxQpA0=;
 h=date:mime-version:subject:message-id:from;
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

e1000_request_msix() requests the RX, TX, and other-cause interrupt
handlers sequentially. If a later request_irq() fails, the function
returns without releasing handlers that were registered earlier. The
caller then disables MSI-X and falls back to MSI or legacy interrupts,
leaving those handlers registered against disabled MSI-X vectors.

Free all handlers registered before the failing request in reverse order
before returning the error. The failed vector is not freed, and the
existing fallback path can then disable MSI-X without retaining stale
handlers.

This can be reproduced with a QEMU e1000e device and a kernel built with
CONFIG_E1000E=y, CONFIG_FAULT_INJECTION=y, CONFIG_FAILSLAB=y,
CONFIG_FAULT_INJECTION_DEBUG_FS=y,
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y, and CONFIG_KALLSYMS_ALL=y.
Start QEMU with an e1000e device, for example using the
-device e1000e option, then run the following commands as root inside
the guest. Replace <e1000e-iface> with the actual interface name, such
as enp0s3:

    mount -t debugfs none /sys/kernel/debug
    ip link set <e1000e-iface> down
    failslab=/sys/kernel/debug/failslab
    req=$(awk '$3 == "request_threaded_irq" { print $1; exit }' \
        /proc/kallsyms)
    req_end=$(printf '%x' $((0x$req + 0x2000)))
    echo N > "$failslab/ignore-gfp-wait"
    echo 0 > "$failslab/probability"
    echo 0 > "$failslab/interval"
    echo 0 > "$failslab/times"
    echo 32 > "$failslab/stacktrace-depth"
    echo "0x$req" > "$failslab/require-start"
    echo "0x$req_end" > "$failslab/require-end"
    echo 3 > "$failslab/interval"
    echo 1 > "$failslab/times"
    echo 100 > "$failslab/probability"
    echo 2 > "$failslab/verbose"
    ip link set <e1000e-iface> up
    dmesg | grep -E 'remove_proc_entry|WARNING: fs/proc/generic.c'

The third qualifying allocation in request_threaded_irq() then fails,
after the RX and TX handlers have been installed. On an unfixed kernel,
the last command reports a warning such as:

    remove_proc_entry: removing non-empty directory 'irq/<n>'
    WARNING: fs/proc/generic.c:<line> at remove_proc_entry

The fixed kernel reaches the MSI or legacy interrupt fallback without
this warning. The failure is deliberately injected to exercise the
error path; it does not claim that a third request_irq() failure occurs
spontaneously during normal operation.

Fixes: 4662e82b2cb4 ("e1000e: add support for new 82574L part")
Cc: stable@vger.kernel.org
Assisted-by: LLM Codex
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

---
v2:
- Add exact QEMU/failslab reproduction steps and the expected warning.
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad4..f55aec340342b 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2139,7 +2139,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 			  e1000_intr_msix_tx, 0, adapter->tx_ring->name,
 			  netdev);
 	if (err)
-		return err;
+		goto err_irq;
 	adapter->tx_ring->itr_register = adapter->hw.hw_addr +
 	    E1000_EITR_82574(vector);
 	adapter->tx_ring->itr_val = adapter->itr;
@@ -2148,11 +2148,16 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 	err = request_irq(adapter->msix_entries[vector].vector,
 			  e1000_msix_other, 0, netdev->name, netdev);
 	if (err)
-		return err;
+		goto err_irq;
 
 	e1000_configure_msix(adapter);
 
 	return 0;
+
+err_irq:
+	while (vector)
+		free_irq(adapter->msix_entries[--vector].vector, netdev);
+	return err;
 }
 
 /**
-- 
2.34.1

