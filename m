From: dan@coverfire.com <dan@coverfire.com>
Date: Fri, 05 Feb 2021 22:37:10 -0500
Subject: [Intel-wired-lan] 710/i40e, RSS and 802.1ad (double vlan)
Message-ID: <fc55ca6fb012c9e36e53d2ab80d47894c38e85a8.camel@coverfire.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When receiving 802.1ad traffic, the 710 puts it all on one queue by
default which limits the scalability.

The use case I care about is simply skipping both VLAN headers to get
the 5-tuple and select the RSS queue based on that.

I've tried to find a way to do this but have failed.

Can the hardware do this? Would a DDP package be able to do this?

Pointers appreciated.

