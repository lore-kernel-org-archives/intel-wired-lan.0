From: Liang, Kan <kan.liang@intel.com>
Date: Mon, 18 Jul 2016 17:40:31 +0000
Subject: [Intel-wired-lan] [RFC PATCH 00/30] Kernel NET policy
In-Reply-To: <20160718161728.GB19066@breakpoint.cc>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
 <20160718151841.GA19066@breakpoint.cc>
 <37D7C6CF3E00A74B8858931C1DB2F07712C1968E@SHSMSX103.ccr.corp.intel.com>
 <20160718161728.GB19066@breakpoint.cc>
Message-ID: <37D7C6CF3E00A74B8858931C1DB2F07712C197A3@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> 
> > > It seems strange to me to add such policies to the kernel.
> >
> > But kernel is the only place which can merge all user's requests.
> 
> I don't think so.
> 
> If different requests conflict in a way that is possible to dosomething
> meaningful the I don't see why userspace tool cannot do the same thing...
> 

Yes, I should correct my expression.
I think kernel should be a better place to do those things.
Kernel should be more efficient to coordinate those requests to get good
performance.


Thanks,
Kan
