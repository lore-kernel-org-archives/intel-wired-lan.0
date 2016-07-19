From: Liang, Kan <kan.liang@intel.com>
Date: Tue, 19 Jul 2016 01:49:41 +0000
Subject: [Intel-wired-lan] [RFC PATCH 00/30] Kernel NET policy
In-Reply-To: <1468878674.1778899.669950273.69750E32@webmail.messagingengine.com>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
 <20160718151841.GA19066@breakpoint.cc>
 <20160718154512.GK5871@two.firstfloor.org>
 <7a03a353-4c1e-2bb4-2550-f84fc4cc79ac@stressinduktion.org>
 <20160718194357.GL5871@two.firstfloor.org>
 <1468878674.1778899.669950273.69750E32@webmail.messagingengine.com>
Message-ID: <37D7C6CF3E00A74B8858931C1DB2F07712C19A4A@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> 
> > Also of course it would be fundamentally less efficient than kernel
> > code doing that, just because of the additional context switches
> > needed.
> 
> Synchronizing or configuring any kind of queues already requires rtnl_mutex.
> I didn't test it but acquiring rtnl mutex in inet_recvmsg is unlikely to fly
> performance wise and

Yes, rtnl will bring some overheads. But the configuration is one time thing for
application or socket. It only happens on receiving first packet.
Unless the application/socket only transmit few packets, the overhead
could be ignored. If they only transmit few packets, why they care about
performance?

> might even be very dangerous under DoS attacks (like
> I see in 24/30).
> 
Patch 29/30 tries to prevent such case.

Thanks,
Kan
