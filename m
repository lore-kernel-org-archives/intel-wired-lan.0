From: Patel, Vedang <vedang.patel@intel.com>
Date: Wed, 29 May 2019 20:05:16 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 3/7] taprio: Add the
 skeleton to enable hardware offloading
In-Reply-To: <20190529121440.46c40967@cakuba.netronome.com>
References: <1559065608-27888-1-git-send-email-vedang.patel@intel.com>
 <1559065608-27888-4-git-send-email-vedang.patel@intel.com>
 <20190528154510.41b50723@cakuba.netronome.com>
 <62E2DD49-AC21-46DE-8E5B-EBC67230FA7D@intel.com>
 <20190529121440.46c40967@cakuba.netronome.com>
Message-ID: <A9D05E0B-FC24-4904-B3E5-1E069C92A3DA@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

[Sending the email again since the last one was rejected by netdev because it was html.]

> On May 29, 2019, at 12:14 PM, Jakub Kicinski <jakub.kicinski@netronome.com> wrote:
> 
> On Wed, 29 May 2019 17:06:49 +0000, Patel, Vedang wrote:
>>> On May 28, 2019, at 3:45 PM, Jakub Kicinski <jakub.kicinski@netronome.com> wrote:
>>> On Tue, 28 May 2019 10:46:44 -0700, Vedang Patel wrote:  
>>>> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>>>> 
>>>> This adds the UAPI and the core bits necessary for userspace to
>>>> request hardware offloading to be enabled.
>>>> 
>>>> The future commits will enable hybrid or full offloading for taprio. This
>>>> commit sets up the infrastructure to enable it via the netlink interface.
>>>> 
>>>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>>>> Signed-off-by: Vedang Patel <vedang.patel@intel.com>  
>>> 
>>> Other qdiscs offload by default, this offload-level selection here is a
>>> little bit inconsistent with that :(
>>> 
>> There are 2 different offload modes introduced in this patch.
>> 
>> 1. Txtime offload mode: This mode depends on skip_sock_check flag being set in the etf qdisc. Also, it requires some manual configuration which might be specific to the network adapter card. For example, for the i210 card, the user will have to route all the traffic to the highest priority queue and install etf qdisc with offload enabled on that queue. So, I don?t think this mode should be enabled by default.
> 
> Excellent, it looks like there will be driver patches necessary for
> this offload to function, also it seems your offload enable function
> still contains this after the series:
> 
> 	/* FIXME: enable offloading */
> 
> Please only post offload infrastructure when fully fleshed out and with
> driver patches making use of it.
> 
The above comment refers to the full offload mode described below. It is not needed for txtime offload mode. Txtime offload mode is essentially setting the transmit time for each packet  depending on what interval it is going to be transmitted instead of relying on the hrtimers to open gates and send packets. More details about why exactly this is done is mentioned in patch #5[1] of this series.

What we can do is just add the txtime offload related flag and add the full offload flag whenever the driver bits are ready. Does that address your concern?

Thanks,
Vedang
>> 2. Full offload mode: This mode is currently not supported by any network driver. The support for this will be coming soon. But, we can enable this mode by default. 
>> 
>> Also, from what Vinicius tells me, offload modes for cbs, etf and mqprio are also disabled by default. So, it will make more sense to keep it disabled to be consistent with other qdiscs similar to this one.

