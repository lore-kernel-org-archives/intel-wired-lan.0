From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 18 Jul 2016 22:51:05 +0200
Subject: [Intel-wired-lan] [RFC PATCH 00/30] Kernel NET policy
In-Reply-To: <37D7C6CF3E00A74B8858931C1DB2F07712C197F1@SHSMSX103.ccr.corp.intel.com>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
 <578D0244.7010707@iogearbox.net>
 <37D7C6CF3E00A74B8858931C1DB2F07712C197F1@SHSMSX103.ccr.corp.intel.com>
Message-ID: <578D4139.7060201@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 07/18/2016 08:30 PM, Liang, Kan wrote:
>> On 07/18/2016 08:55 AM, kan.liang at intel.com wrote:
[...]
>> On a higher level picture, why for example, a new cgroup in combination
>> with tc shouldn't be the ones resolving these policies on resource usage?
>
> The NET policy doesn't support cgroup yet, but it's on my todo list.
> The granularity for the device resource is per queue. The packet will be
> redirected to the specific queue.
> I'm not sure if cgroup with tc can do that.

Did you have a look at sch_mqprio, which can be used along with either
netprio cgroup or netcls cgroup plus tc on clsact's egress side to set
the priority for mqprio mappings from application side? At leats ixgbe,
i40e, fm10k have offload support for it and a number of other nics. You
could also use cls_bpf for making the prio assignment if you need to
involve also other meta data from the skb (like mark or prio derived from
sockets, etc). Maybe it doesn't cover all of what you need, but could be
a start to extend upon?

Thanks,
Daniel
