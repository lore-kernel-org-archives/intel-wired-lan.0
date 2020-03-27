From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 27 Mar 2020 11:15:00 +0800
Subject: [Intel-wired-lan] Please drop "igb: Use device_lock() insead of
 rtnl_lock()" "e1000e: Disable s0ix flow for X1 Carbon 7th"
Message-ID: <79788C8C-D645-4D67-87E7-F02F15DC4DDE@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeffrey,

"igb: Use device_lock() insead of rtnl_lock()" caused a regression, and I am taking a different approach as Alexander suggested.
"e1000e: Disable s0ix flow for X1 Carbon 7th" is superseded by "e1000e: bump up timeout to wait when ME un-configure ULP mode"

So please drop both of them from dev-queue, thanks!

Kai-Heng
