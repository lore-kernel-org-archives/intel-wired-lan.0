From: David Miller <davem@davemloft.net>
Date: Tue, 01 Dec 2015 21:23:42 -0500 (EST)
Subject: [Intel-wired-lan] [RFC 1/4] net: support per queue tx_usecs in
	sysfs
In-Reply-To: <565E1B8E.4040603@gmail.com>
References: <1448956892-15509-1-git-send-email-kan.liang@intel.com>
 <565E1B8E.4040603@gmail.com>
Message-ID: <20151201.212342.688373845088380112.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 01 Dec 2015 14:13:34 -0800

> The new interface you propose makes things inconsistent, since we have
> two separate configuration paths (sysfs and ethtool), and it would seem
> better to have per-queue awareness in ethtool, since there is a whole
> bunch of other parameters that could be configured on a per-queue basis.

Agreed, we have to extend ethtool to support this, in order to provide
a consistent interface.

We could even do this by encapsulating one ethtool command within
another, the outer ethtool command says "apply the inner op to
queue(s) N".
