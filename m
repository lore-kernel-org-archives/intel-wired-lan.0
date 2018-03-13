From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 13 Mar 2018 14:44:11 -0700
Subject: [Intel-wired-lan] [PATCH 12/15] ice: Add stats and ethtool
 support
In-Reply-To: <20180313141414.00007d11@intel.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-13-anirudh.venkataramanan@intel.com>
 <20180309151428.4d73358c@cakuba.netronome.com>
 <1520967916.696.21.camel@intel.com>
 <a6f3bd20-705e-2022-23c8-1e3b5a8c93a6@gmail.com>
 <20180313141414.00007d11@intel.com>
Message-ID: <6509601e-8fd4-d79a-731c-e4e4882ba19c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 03/13/2018 02:14 PM, Jesse Brandeburg wrote:
> On Tue, 13 Mar 2018 12:17:10 -0700
> Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>> Yes, this is a recurring mistake
>>
>> See commit
>> bf909456f6a89654cb65c01fe83a4f9b133bf978 Revert "net: hns3: Add packet
>> statistics of netdev"
> 
> Thanks for the pointer, that was a useful thread to review.  I
> understand the point that was made about not having the netdev stats
> shown in ethtool -S.  We definitely do provide per-queue stats as well
> as these regular stats in ethtool -S.
> 
> I do remember from the past discussions that it *is* useless for the
> driver to keep internally any stats that were already stored via the
> get_stats NDO, and we missed it in the internal review that this driver
> was doing that, so that will be fixed.
> 
> Maybe it's just that I've been doing this too long, but I regularly
> (and many other customers/users do as well) depend on the ethtool stats
> being atomically updated w.r.t. each other.  This means that if I'm
> getting the over rx_packets, as well as the per-queue rx_packets, and I
> read them all at once from the driver with ethtool, then I can check
> that things are working as expected.
> 
> If I have to gather the netdev stats from /proc/net/dev (which iproute2
> tool shows the /proc/net/dev stats?) and somehow atomically gather the
> ethtool -S stats.  What's the user to do in this brave new world where
> ethtool doesn't at least have rx/tx bytes and packets?

I do not believe ethtool -S provides an atomic snapshot of counters anyway.

Maybe some drivers/NIC implement such a feature, but it is not documented.

In any case, that could be implemented generically (by core networking 
stack), instead of being copied/pasted in many drivers, if this would be 
really needed.

core networking stack would append (or insert) ndo_stats.
(The atomicity rule if really needed would need to pass an extra struct 
rtnl_link_stats64 pointer to get_ethtool_stats() method)


