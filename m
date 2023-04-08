Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1843CC77B6C
	for <intel-wired-lan@archiver.kernel.org>; Sat,  8 Apr 2023 14:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C15441E19;
	Sat,  8 Apr 2023 14:07:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C15441E19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680962840;
	bh=xBXx911lqxGJu9QYcus3FA5YchSXjF/9nPD+6iMJYpE=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=a1ddTDbVQe9no132v3CNNjY9JpvEs+x3Lr5dVR0vkZaJ4ghzHeH/1gAwnhn2dJUy/
	 YESDeUHNq3eWxBk6RBHb8KiPVw+nsumDEZZ5IXIt3GdCRBR7r9sL1qeR7LMyAqr80C
	 D7N/yZtbXr00SOk0gRyCfVteGygtOF4gU50y08t6D0g9TrPWUhsaBjekejhTkzzgJB
	 LmgjDFW0r6WF0uVbSa33lrozdz31oDcg0+0zC1SnYjFM/cUCBLnsWdUn7GHcHTMikN
	 oV9O7M6qzUrygrd3UErKSH4IHNKuuTQnBcUi422iPisqQ0mHS9soKZMGMY8bPeM9vf
	 xSmxzJ2o+Oliw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bS0wkYiyo6TB; Sat,  8 Apr 2023 14:07:17 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE48A41E9D;
	Sat,  8 Apr 2023 14:07:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE48A41E9D
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 9B5161C32CF
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Apr 2023 14:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73017405C0
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Apr 2023 14:07:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73017405C0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HZtHpBvmlsji for <intel-wired-lan@lists.osuosl.org>;
 Sat,  8 Apr 2023 14:07:01 +0000 (UTC)
X-Greylist: delayed 00:05:39 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 12BFA40127
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com
 [115.236.118.80])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12BFA40127
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Apr 2023 14:07:00 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPV6:240e:3b7:3279:cf80:b96f:666f:20ca:bc83])
 by mail-m11880.qiye.163.com (Hmail) with ESMTPA id 60349201AB;
 Sat,  8 Apr 2023 22:01:12 +0800 (CST)
From: Ding Hui <dinghui@sangfor.com.cn>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Date: Sat,  8 Apr 2023 22:00:28 +0800
Message-Id: <20230408140030.5769-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSB1MVkkfQ0lDH09MShlNH1UTARMWGhIXJBQOD1
 lXWRgSC1lBWUlPSx5BSBlMQUhJTEJBGB1DS0EZQk0dQU1NTR1BSUsYGkEZGENIWVdZFhoPEhUdFF
 lBWU9LSFVKSktCSE5VSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PxQ6DQw5Pz0cTzcXSSo#HEox
 MzQaCi5VSlVKTUNLQk1JT0xISkJLVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
 QVlJT0seQUgZTEFISUxCQRgdQ0tBGUJNHUFNTU0dQUlLGBpBGRhDSFlXWQgBWUFJTUJLNwY+
X-HM-Tid: 0a87612bcb4d2eb6kusn60349201ab
X-HM-MType: 1
Subject: [Intel-wired-lan] [PATCH net 0/2] iavf: Fix issues when setting
 channels concurrency
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
 Ding Hui <dinghui@sangfor.com.cn>, jesse.brandeburg@intel.com,
 linux-kernel@vger.kernel.org, anthony.l.nguyen@intel.com,
 linux-hardening@vger.kernel.org, netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

There are two issues can be reproduced by the following script:

[root@host ~]# cat test-iavf-1.sh
#!/bin/bash

pf_dbsf="0000:40:01.1/0000:41:00.0"
vf0_dbsf="0000:40:01.1/0000:41:02.0"
g_pids=()

function do_set_numvf()
{
    echo "set 2 vfs"
    echo 2 >/sys/bus/pci/devices/${pf_dbsf}/sriov_numvfs
    sleep $((RANDOM%3+1))
    echo "set 0 vfs"
    echo 0 >/sys/bus/pci/devices/${pf_dbsf}/sriov_numvfs
    sleep $((RANDOM%3+1))
}

function do_nic_reset()
{
    local nic=$(ls -1 --indicator-style=none /sys/bus/pci/devices/${vf0_dbsf}/net/)
    [ -z "$nic" ] && { sleep $((RANDOM%3)) ; return 1; }
    ifconfig $nic 192.168.18.5 netmask 255.255.255.0
    ifconfig $nic up
    echo "set $nic 1 combined"
    ethtool -L $nic combined 1
    echo "set $nic 4 combined"
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
while :; do do_nic_reset ; done &
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
