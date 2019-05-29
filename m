From: Patel, Vedang <vedang.patel@intel.com>
Date: Wed, 29 May 2019 17:06:49 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 3/7] taprio: Add the
 skeleton to enable hardware offloading
In-Reply-To: <20190528154510.41b50723@cakuba.netronome.com>
References: <1559065608-27888-1-git-send-email-vedang.patel@intel.com>
 <1559065608-27888-4-git-send-email-vedang.patel@intel.com>
 <20190528154510.41b50723@cakuba.netronome.com>
Message-ID: <62E2DD49-AC21-46DE-8E5B-EBC67230FA7D@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks Jacub for they inputs.

> On May 28, 2019, at 3:45 PM, Jakub Kicinski <jakub.kicinski@netronome.com> wrote:
> 
> On Tue, 28 May 2019 10:46:44 -0700, Vedang Patel wrote:
>> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> 
>> This adds the UAPI and the core bits necessary for userspace to
>> request hardware offloading to be enabled.
>> 
>> The future commits will enable hybrid or full offloading for taprio. This
>> commit sets up the infrastructure to enable it via the netlink interface.
>> 
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> 
> Other qdiscs offload by default, this offload-level selection here is a
> little bit inconsistent with that :(
> 
There are 2 different offload modes introduced in this patch.

1. Txtime offload mode: This mode depends on skip_sock_check flag being set in the etf qdisc. Also, it requires some manual configuration which might be specific to the network adapter card. For example, for the i210 card, the user will have to route all the traffic to the highest priority queue and install etf qdisc with offload enabled on that queue. So, I don?t think this mode should be enabled by default.
2. Full offload mode: This mode is currently not supported by any network driver. The support for this will be coming soon. But, we can enable this mode by default. 

Also, from what Vinicius tells me, offload modes for cbs, etf and mqprio are also disabled by default. So, it will make more sense to keep it disabled to be consistent with other qdiscs similar to this one.
>> @@ -731,6 +857,9 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
>> 	if (err < 0)
>> 		return err;
>> 
>> +	if (tb[TCA_TAPRIO_ATTR_OFFLOAD_FLAGS])
>> +		offload_flags = nla_get_u32(tb[TCA_TAPRIO_ATTR_OFFLOAD_FLAGS]);
> 
> You should make sure user doesn't set unknown bits.  Otherwise using
> other bits will not be possible in the future.
> 
Yes, I agree here, will include this in the next patchset.

Thanks,
Vedang
>> 	new_admin = kzalloc(sizeof(*new_admin), GFP_KERNEL);
>> 	if (!new_admin) {
>> 		NL_SET_ERR_MSG(extack, "Not enough memory for a new schedule");

