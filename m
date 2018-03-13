From: David Miller <davem@davemloft.net>
Date: Tue, 13 Mar 2018 16:54:23 -0400 (EDT)
Subject: [Intel-wired-lan] [PATCH 12/15] ice: Add stats and ethtool
 support
In-Reply-To: <1520967916.696.21.camel@intel.com>
References: <20180309172136.9073-13-anirudh.venkataramanan@intel.com>
 <20180309151428.4d73358c@cakuba.netronome.com>
 <1520967916.696.21.camel@intel.com>
Message-ID: <20180313.165423.2187873106573894545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Date: Tue, 13 Mar 2018 19:05:19 +0000

> Thanks for the feedback. I am not sure I understand what's being asked
> here. Do you mean to say that standard netdev stats should not be
> printed when we do ethtool -S or something else?

Yes, that is what he is saying.

It is duplicating information already available with a normal
netdev statistics dump.
