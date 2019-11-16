From: Jan Janssen <medhefgo@web.de>
Date: Sat, 16 Nov 2019 12:50:38 +0100
Subject: [Intel-wired-lan] Regression: e1000e link not coming up
Message-ID: <3945198.J3aOToa6sv@minako>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

since 5.3 my I219-V network interface sometimes doesn't come up when booting
or resuming from suspend. This either forces me to use "ip link down/up" or
reloading the module to get working internet.

I reported this issue previously to netdev at vger.kernel.org where I initially
bisected to a wrong commit. After finding the right one nobody reacted to it,
so now I am trying this again here.

There is also a bugzilla entry for this, but it seems to be ignored by
maintainers too: https://bugzilla.kernel.org/show_bug.cgi?id=205067
For me, this happens with systemd-networkd, but the people in the bugzilla
report are observing this with NetworkManager.

The commit introducing the bug is 59653e6497d16f7ac1d9db088f3959f57ee8c3db
(e1000e: Make watchdog use delayed work) and reverting it did make this bug go
away. Though, it cannot be reverted automatically on the latest git tree from
Torvalds anymore.

I've also tried the master branch on jkirsher/net-queue.git  and
jkirsher/next-queue.git, but the bug is still present there too.

This bug is really annoying and inconvenient, so I would really appreciate if
somebody could fix this bug or at least have the offending commit reverted.

Regards,
Jan


