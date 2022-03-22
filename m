From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 22 Mar 2022 18:39:54 +0000
Subject: [Intel-wired-lan] [PATCH net-next] Revert "ice: Hide bus-info
 in ethtool for PRs in switchdev mode"
In-Reply-To: <3cbd7420-3803-e830-9347-652e53a3dd02@linux.intel.com>
References: <20220321144731.3935-1-marcin.szycik@linux.intel.com>
 <a7dcc837-e24e-86d6-059c-416ad3357fe0@molgen.mpg.de>
 <3cbd7420-3803-e830-9347-652e53a3dd02@linux.intel.com>
Message-ID: <f6ccd848-1dd8-764f-2b73-981a49e6a024@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/21/2022 9:14 AM, Marcin Szycik wrote:
> 
> 
> On 21-Mar-22 15:57, Paul Menzel wrote:
>> Dear Marcin,
>>
>>
>> Am 21.03.22 um 15:47 schrieb Marcin Szycik:
>>> This reverts commit bfaaba99e680bf82bf2cbf69866c3f37434ff766.
>>>
>>> Commit bfaaba99e680 ("ice: Hide bus-info in ethtool for PRs in switchdev
>>> mode") was a workaround for lshw tool displaying incorrect
>>> descriptions for port representors and PF in switchdev mode. Now the issue
>>> has been fixed in the lshw tool itself [1].
>>>
>>> [1] https://ezix.org/src/pkg/lshw/commit/9bf4e4c9c1
>>
>> As you cannot know what lshw version users have installed, I am afraid the workaround (part of Linux 5.16. and 5.17) has to stay in the Linux kernel to not violate Linux? no-regression policy.
>>
>> What are the downsides of keeping the workaround around?
> 
> The only downside of leaving this workaround is that PCI number won't be shown in ethtool for port representor netdevs. I'm not aware of any applications (other than lshw) that depend on this information, but there might be some.
> 

That's not quite correct. If you don't include this information, then at
least systemd based distributions won't generate the expected altname.

If we keep the workaround, these netdevs remain with their default
generic ethX device names. (eth0, eth1, etc).

If we remove the workaround, the netdevs get altnamed using a scheme
which matches the existing PF netdev schemes like eno0, enp24s0f0 etc.

For example, the netdev will get an altname such as enp24s0f0npf0vf0

This indicates that the netdev is a representor for VF 0 on the
enp24s0f0 main netdev.

Thanks,
Jake
