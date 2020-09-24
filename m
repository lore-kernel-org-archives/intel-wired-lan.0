From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 24 Sep 2020 18:04:47 +0200
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Increase iteration on
 polling MDIC ready bit
In-Reply-To: <748efbf9-573f-ab2a-0c82-a7b2a11cda60@molgen.mpg.de>
References: <20200923074751.10527-1-kai.heng.feng@canonical.com>
 <20200924150958.18016-1-kai.heng.feng@canonical.com>
 <748efbf9-573f-ab2a-0c82-a7b2a11cda60@molgen.mpg.de>
Message-ID: <20200924160447.GD3821492@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 24, 2020 at 05:32:12PM +0200, Paul Menzel wrote:
> Dear Kai-Heng,
> 
> 
> Thank you for sending version 2.
> 
> Am 24.09.20 um 17:09 schrieb Kai-Heng Feng:
> > We are seeing the following error after S3 resume:
> 
> I?d be great if you added the system and used hardware, you are seeing this
> with.
> 
> > [  704.746874] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
> > [  704.844232] e1000e 0000:00:1f.6 eno1: MDI Write did not complete
> 
> A follow-up patch, should extend the message to include the timeout value.
> 
> > MDI Write did not complete did not complete in ? seconds.
> 
> According to the Linux timestamps it?s 98 ms, which makes sense, as (640 * 3
> * 50 ?s = 96 ms).
> 
> What crappy hardware is this, that it takes longer than 100 ms?

I'm speculating, but i guess this happens with just the first couple
of transfers after power up. After that, it probably takes a single
loop. It would be good to see some profile data for this. Completely
different MDIO driver and implementation, but this patch might give
some ideas how to do the profiling:

https://github.com/lunn/linux/commit/76c7810a7e2c1b1e28a7a95d08dd440a8f48a516

Look at the debugfs and num_loops/us parts.

     Andrew
