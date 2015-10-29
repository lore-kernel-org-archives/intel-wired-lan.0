From: Miller, Darin J <darin.j.miller@intel.com>
Date: Thu, 29 Oct 2015 01:41:57 +0000
Subject: [Intel-wired-lan] [PATCH] net: Fix warnings
	from	inet_timewait_sock.h
In-Reply-To: <20151022180310.105186.43189.stgit@mdrustad-wks.jf.intel.com>
References: <20151022180310.105186.43189.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <A91205FD8A6E14448BD4414C06E9C3D37520DF3E@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Thursday, October 22, 2015 11:03 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] net: Fix warnings from inet_timewait_sock.h

With W=1, inet_timewait_sock.h is generating the following warnings:

include/net/inet_timewait_sock.h:116:1: warning: <E2><80><98>inline<E2><80><99> is not at beginning of declaration [-Wold-style-declaration]  static void inline inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)  ^
include/net/inet_timewait_sock.h:121:1: warning: <E2><80><98>inline<E2><80><99> is not at beginning of declaration [-Wold-style-declaration]  static void inline inet_twsk_reschedule(struct inet_timewait_sock *tw, int timeo)  ^

Simply reorder the declaration to the proper order to resolve them.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 include/net/inet_timewait_sock.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Darin Miller <darin.j.miller@intel.com>

