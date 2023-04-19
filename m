Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06B7C77B75
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Apr 2023 15:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DBE5616BA;
	Wed, 19 Apr 2023 15:08:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DBE5616BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1681916899;
	bh=ZEJRgDmiSQWU/wGZvh22bcaVvTgQK/wfGME/UqsmgWQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=rl5I9VuHrjs6xaDI0I8qU+0OsL8sfCxrPBhscProg4HDzv1gegEK5eumvyR+D5Gog
	 vnNs5NjEjRnb93BjiYjiMmNRL6cACnQI4umoMNgCeoObVyzcNhNiJlxHQpYDOQTlLj
	 opYueXjWEF0MydvnX6jgfgdm0YrSPgXH7gmF0G3mAWFu0FeSIUVWzwx/0SKAjZJGyT
	 Z3nSprYHIgitLwMC5uUmTuUjogZoRdCEmNep9umUzLM4/3eGLgfpF5Z0OY9JKPQMiU
	 Jfu9t6LvqOJ4jNIRLgUkrBPDx6euH6gCbDWDXDyd70Iyoa/mwyF42mNhsaOuuD6HXx
	 EZ5SpCVpyIDGw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lv7_BQrDWBrX; Wed, 19 Apr 2023 15:08:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F8B3616B5;
	Wed, 19 Apr 2023 15:08:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F8B3616B5
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 79AA91C439B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Apr 2023 15:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5EC5D40608
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Apr 2023 15:08:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5EC5D40608
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4H-3zHDi2HA6 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Apr 2023 15:08:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 118B24049A
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com
 [115.236.118.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 118B24049A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Apr 2023 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [113.92.156.116])
 by mail-m11875.qiye.163.com (Hmail) with ESMTPA id A87DE280259;
 Wed, 19 Apr 2023 23:07:52 +0800 (CST)
From: Ding Hui <dinghui@sangfor.com.cn>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com
Date: Wed, 19 Apr 2023 23:07:07 +0800
Message-Id: <20230419150709.24810-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTR4aVkIfTExLTU4ZHktNSlUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpKSFVCSVVKTk1VSkpNWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Tid: 0a879a0eca282eb1kusna87de280259
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORg6Eio5OD0JQxdKUVFMS0MS
 ECJPCj9VSlVKTUNKQkpNQ0xITU1NVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
 QVlKSkhVQklVSk5NVUpKTVlXWQgBWUFJQkJINwY+
Subject: [Intel-wired-lan] [PATCH net v2 0/2] iavf: Fix issues when setting
 channels concurrency with removing
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
Cc: keescook@chromium.org, grzegorzx.szczurek@intel.com,
 mitch.a.williams@intel.com, Ding Hui <dinghui@sangfor.com.cn>,
 linux-kernel@vger.kernel.org, huangcun@sangfor.com.cn,
 gregory.v.rose@intel.com, michal.kubiak@intel.com, jeffrey.t.kirsher@intel.com,
 simon.horman@corigine.com, pengdonglin@sangfor.com.cn, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The patchset fix two issues which can be reproduced by the following script:

[root@host ~]# cat repro.sh
#!/bin/bash

pf_dbsf="0000:41:00.0"
vf0_dbsf="0000:41:02.0"
g_pids=()

function do_set_numvf()
{
    echo 2 >/sys/bus/pci/devices/${pf_dbsf}/sriov_numvfs
    sleep $((RANDOM%3+1))
    echo 0 >/sys/bus/pci/devices/${pf_dbsf}/sriov_numvfs
    sleep $((RANDOM%3+1))
}

function do_set_channel()
{
    local nic=$(ls -1 --indicator-style=none /sys/bus/pci/devices/${vf0_dbsf}/net/)
    [ -z "$nic" ] && { sleep $((RANDOM%3)) ; return 1; }
    ifconfig $nic 192.168.18.5 netmask 255.255.255.0
    ifconfig $nic up
    ethtool -L $nic combined 1
    ethtool -L $nic combined 4
    sleep $((RANDOM%3))
}

function on_exit()
{
    local pid
    for pid in "${g_pids[@]}"; do
        kill -0 "$pid" &>/dev/null && kill "$pid" &>/dev/null
    done
    g_pids=()
}

trap "on_exit; exit" EXIT

while :; do do_set_numvf ; done &
g_pids+=($!)
while :; do do_set_channel ; done &
g_pids+=($!)

wait


Ding Hui (2):
  iavf: Fix use-after-free in free_netdev
  iavf: Fix out-of-bounds when setting channels on remove

 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 4 +++-
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 6 +-----
 2 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
