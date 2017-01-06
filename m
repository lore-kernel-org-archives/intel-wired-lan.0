From: David Miller <davem@davemloft.net>
Date: Fri, 06 Jan 2017 16:41:16 -0500 (EST)
Subject: [Intel-wired-lan] [next PATCH 00/11] ixgbe: Add support for
 writable pages and build_skb
In-Reply-To: <20170106155448.1501.31298.stgit@localhost.localdomain>
References: <20170106155448.1501.31298.stgit@localhost.localdomain>
Message-ID: <20170106.164116.1871412141301427533.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 06 Jan 2017 08:06:16 -0800

> The testing matrix for all of these patches is going to be pretty
> extensive.  Basically we want to test these patches on as many platforms
> and architectures as possible with as many features being toggled as
> possible including RSC, FCoE, SR-IOV, and Jumbo Frames all while receiving
> traffic.

Overall looks very nice to me.

I am assuming that I will get a formal submission once the necessary
amount of testing is performed.
