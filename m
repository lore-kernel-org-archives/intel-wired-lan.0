From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 15 Sep 2016 23:29:34 +0000
Subject: [Intel-wired-lan] [net-next PATCH v3 1/3] e1000: track BQL
 bytes regardless of skb or not
In-Reply-To: <20160915004353.GA63116@ast-mbp.thefacebook.com>
References: <20160912220312.5610.77528.stgit@john-Precision-Tower-5810>
 <20160912221327.5610.74333.stgit@john-Precision-Tower-5810>
 <309B89C4C689E141A5FF6A0C5FB2118B81F90268@ORSMSX101.amr.corp.intel.com>
 <20160915004353.GA63116@ast-mbp.thefacebook.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F90900@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 0 at net/sched/sch_generic.c:316
> dev_watchdog+0x1c2/0x1d0
> > NETDEV WATCHDOG: eth1 (e1000): transmit queue 0 timed out
> 
> Thanks a lot for the tests! Really appreciate it.

np, I needed to get my old compatibility systems back in running order anyway.
