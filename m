Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A58C77B75
	for <intel-wired-lan@archiver.kernel.org>; Wed,  3 May 2023 03:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D777A83AE0;
	Wed,  3 May 2023 03:16:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D777A83AE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1683083803;
	bh=ZEJRgDmiSQWU/wGZvh22bcaVvTgQK/wfGME/UqsmgWQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=EtoEE1tj17BRdokb5GBr17YiG8XOLKsrMFB23QNaPSCQcYMYajlm953TUeBXab8Z2
	 c04MFhtpSJG8yKZUDdc5CqXZi3qre4yXiC+JLQAdPaT3X5AugYfavVPB+Z2sWppnNQ
	 qbi9zAeEq96GRiP7oWGZIqDeoG4EogLn2QVw6cKHpoJFfn64mEu6P9AtN9n6aZ3SS4
	 MBemqgzuD0gNg7nIQ2VzGEPKNiRiP6ZmfdC0a9YCgOrdoI00Alc6sx5HoEmLg3b14n
	 4GdB1rcWJYmqQWnwn2/beYC6WOXLH+X4Fb2gLFeHS+3lgLRQ+JEJQTYMjcw2PruC6e
	 7wLiQXrACNoiQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wzjd0EwuMvNE; Wed,  3 May 2023 03:16:43 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id E41E983AE1;
	Wed,  3 May 2023 03:16:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E41E983AE1
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 921631BF470
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 May 2023 03:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77373401F3
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 May 2023 03:16:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 77373401F3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HkDTq44gYkc4 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  3 May 2023 03:16:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0FDD840120
Received: from mail-m11876.qiye.163.com (mail-m11876.qiye.163.com
 [115.236.118.76])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0FDD840120
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 May 2023 03:16:38 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPV6:240e:3b7:327f:5c30:95e8:3d27:11c5:1ee8])
 by mail-m11876.qiye.163.com (Hmail) with ESMTPA id 7D4DC3C0234;
 Wed,  3 May 2023 11:16:14 +0800 (CST)
From: Ding Hui <dinghui@sangfor.com.cn>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com
Date: Wed,  3 May 2023 11:15:39 +0800
Message-Id: <20230503031541.27855-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUlCVh1KHU9CTkpPSUpMHVUTARMWGhIXJBQOD1
 lXWRgSC1lBWUlPSx5BSBlMQUhJTB1BThhIS0FCTh5DQUgfSUxBSkoYTkFKHh5DWVdZFhoPEhUdFF
 lBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Tid: 0a87df9c4c802eb2kusn7d4dc3c0234
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N0k6Tgw6CD0OAToTMB8XQgIK
 DkoaFC1VSlVKTUNIS0NITExOTkpIVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
 QVlJT0seQUgZTEFISUwdQU4YSEtBQk4eQ0FIH0lMQUpKGE5BSh4eQ1lXWQgBWUFIS09ONwY+
Subject: [Intel-wired-lan] [PATCH net v4 0/2] iavf: Fix issues when setting
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
 mitch.a.williams@intel.com, linux-kernel@vger.kernel.org,
 huangcun@sangfor.com.cn, gregory.v.rose@intel.com, michal.kubiak@intel.com,
 jeffrey.t.kirsher@intel.com, simon.horman@corigine.com,
 pengdonglin@sangfor.com.cn, Ding Hui <dinghui@sangfor.com.cn>,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org
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
