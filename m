From: Benjamin Poirier <bpoirier@suse.com>
Date: Tue, 19 Sep 2017 21:41:02 +0200
Subject: [Intel-wired-lan] [5/5] e1000e: Avoid receiver overrun
	interrupt bursts
In-Reply-To: <DDD41C67-CDF2-4443-9F49-0DC5489D9243@redfish-solutions.com>
References: <20170721183627.13373-5-bpoirier@suse.com>
 <DDD41C67-CDF2-4443-9F49-0DC5489D9243@redfish-solutions.com>
Message-ID: <20170919194102.h2nu72evbqhpu765@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2017/09/19 12:38, Philip Prindeville wrote:
> Hi.
> 
> We?ve been running this patchset (all 5) for about as long as they?ve been under review? about 2 months.  And in a burn-in lab with heavy traffic.
> 
> We?ve not seen a single link-flap in hundreds of ours of saturated traffic.
> 
> Would love to see some resolution soon on this as we don?t want to ship a release with unsanctioned patches.
> 
> Is there an estimate on when that might be?

The patches have been added to Jeff Kirsher's next-queue tree. I guess
they will be submitted for v4.15 which might be released in early
2018...
http://phb-crystal-ball.org/
