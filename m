From: David Miller <davem@davemloft.net>
Date: Mon, 04 May 2020 11:20:56 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH] igb: Report speed and duplex as
 unknown when device is runtime suspended
In-Reply-To: <20200504173218.1724-1-kai.heng.feng@canonical.com>
References: <20200504173218.1724-1-kai.heng.feng@canonical.com>
Message-ID: <20200504.112056.1400711844642835898.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue,  5 May 2020 01:32:18 +0800

> igb device gets runtime suspended when there's no link partner. We can't
> get correct speed under that state:
> $ cat /sys/class/net/enp3s0/speed
> 1000
> 
> In addition to that, an error can also be spotted in dmesg:
> [  385.991957] igb 0000:03:00.0 enp3s0: PCIe link lost
> 
> Since device can only be runtime suspended when there's no link partner,
> we can directly report the speed and duplex as unknown.
> 
> The more generic approach will be wrap get_link_ksettings() with begin()
> and complete() callbacks. However, for this particular issue, begin()
> calls igb_runtime_resume() , which tries to rtnl_lock() while the lock
> is already hold by upper ethtool layer.
> 
> So let's take this approach until the igb_runtime_resume() no longer
> needs to hold rtnl_lock.
> 
> Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

I'm assuming I will get this from upstream via Jeff K.
