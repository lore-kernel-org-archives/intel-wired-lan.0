From: Liang, Kan <kan.liang@intel.com>
Date: Tue, 19 Jul 2016 13:43:26 +0000
Subject: [Intel-wired-lan] [RFC PATCH 00/30] Kernel NET policy
In-Reply-To: <20160718.220342.805963245855552246.davem@davemloft.net>
References: <20160718194357.GL5871@two.firstfloor.org>
 <1468878674.1778899.669950273.69750E32@webmail.messagingengine.com>
 <37D7C6CF3E00A74B8858931C1DB2F07712C19A4A@SHSMSX103.ccr.corp.intel.com>
 <20160718.220342.805963245855552246.davem@davemloft.net>
Message-ID: <37D7C6CF3E00A74B8858931C1DB2F07712C19F7C@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> > Yes, rtnl will bring some overheads. But the configuration is one time
> > thing for application or socket. It only happens on receiving first
> > packet.
> 
> Thanks for destroying our connection rates.
> 
> This kind of overhead is simply unacceptable.

If so, I think I can make the configuration asynchronized for next
version. The connection rate should not be destroyed.

Thanks,
Kan

