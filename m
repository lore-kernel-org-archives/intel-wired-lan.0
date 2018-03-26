From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 26 Mar 2018 16:55:39 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v5 7/9] igb: Add MAC
 address support for ethtool nftuple filters
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B8C81BBB3@ORSMSX101.amr.corp.intel.com>
References: <20180322003353.29970-1-vinicius.gomes@intel.com>
 <20180322003353.29970-8-vinicius.gomes@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C81BBB3@ORSMSX101.amr.corp.intel.com>
Message-ID: <87lgeecryc.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Aaron,

"Brown, Aaron F" <aaron.f.brown@intel.com> writes:

>
> Maybe not "this" patch, but this is the one that enables the ethtool commands, so replying here.
> The filters do not seem to take effect with this version (v5) of the
> series.  The commands are accepted for i210 and rejected with
> unsupported messages for the other adapters (as desired) and an
> ethtool -n shows the filter, however, with either the src or dst
> filter set I can run traffic (netperf) that should be caught by the
> filter and rather than being directed to the single queue it is spread
> across queues as would be expected without the filter set.
>
> The test system still has a kernel / driver with the v4 series of this
> patch set and the exact same filter commands / system setup does
> filter the traffic to the specified rx queue with the v4 series.

That's interesting. The only difference is that now non steering filters
(filters added by 'ip (m)addr', PACKET_ADD_MEMBERSHIP and the local MAC
address, for example) do not have the QSEL bit set.

On my tests I cannot detect any change in behaviour between those two
versions of the series, for example. trying to add a filter for the
local MAC address has no visible effect in both versions. (This raises a
question: should this be an error, or should this override the default
entry configuration, or this behaviour is fine?)

Can you share more information about your tests? so I can reproduce it here.


Thank you,
--
Vinicius
