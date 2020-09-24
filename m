From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 24 Sep 2020 17:53:55 +0200
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Increase iteration on
 polling MDIC ready bit
In-Reply-To: <20200924150958.18016-1-kai.heng.feng@canonical.com>
References: <20200923074751.10527-1-kai.heng.feng@canonical.com>
 <20200924150958.18016-1-kai.heng.feng@canonical.com>
Message-ID: <20200924155355.GC3821492@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 24, 2020 at 11:09:58PM +0800, Kai-Heng Feng wrote:
> We are seeing the following error after S3 resume:
> [  704.746874] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
> [  704.844232] e1000e 0000:00:1f.6 eno1: MDI Write did not complete
> [  704.902817] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
> [  704.903075] e1000e 0000:00:1f.6 eno1: reading PHY page 769 (or 0x6020 shifted) reg 0x17
> [  704.903281] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
> [  704.903486] e1000e 0000:00:1f.6 eno1: writing PHY page 769 (or 0x6020 shifted) reg 0x17
> [  704.943155] e1000e 0000:00:1f.6 eno1: MDI Error
> ...
> [  705.108161] e1000e 0000:00:1f.6 eno1: Hardware Error
> 
> As Andrew Lunn pointed out, MDIO has nothing to do with phy, and indeed
> increase polling iteration can resolve the issue.
> 
> While at it, also move the delay to the end of loop, to potentially save
> 50 us.

You are unlikely to save any time. 64 bits at 2.5MHz is 25.6uS. So it
is very unlikely doing a read directly after setting is going is going
to have E1000_MDIC_READY set. So this change likely causes an addition
read on MDIC. Did you profile this at all, for the normal case?

I also don't fully understand the fix. You are now looping up to 6400
times, each with a delay of 50uS. So that is around 12800 times more
than it actually needs to transfer the 64 bits! I've no idea how this
hardware works, but my guess would be, something is wrong with the
clock setup?

     Andrew
