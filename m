From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 22 Mar 2022 18:54:55 +0000
Subject: [Intel-wired-lan] [PATCH net-next] Revert "ice: Hide bus-info
 in ethtool for PRs in switchdev mode"
In-Reply-To: <a79731e9-4cbe-8827-f706-b69687f4d376@intel.com>
References: <20220321144731.3935-1-marcin.szycik@linux.intel.com>
 <a7dcc837-e24e-86d6-059c-416ad3357fe0@molgen.mpg.de>
 <a79731e9-4cbe-8827-f706-b69687f4d376@intel.com>
Message-ID: <4b47ebf2-9c29-4436-e674-611561a5802e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/22/2022 11:26 AM, Keller, Jacob E wrote:
> On 3/21/2022 7:57 AM, Paul Menzel wrote:
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
>> As you cannot know what lshw version users have installed, I am afraid 
>> the workaround (part of Linux 5.16. and 5.17) has to stay in the Linux 
>> kernel to not violate Linux? no-regression policy.
>>
>> What are the downsides of keeping the workaround around?
>>
> 
> 
> I understand wanting to avoid breaking userspace. However, I think its
> important to understand the context here.
> 
> lshw was making an incorrect assumption about how netdevs tie to PCI
> devices. This assumption caused a bug where representor netdevs would
> get mis-named by the utility, and then the real netdev would get a
> generic name.
> 
> This is akin to a userspace program reading some data reported by kernel
> and misinterpreting it. It's simply a bug in the application.
> 
> The ice driver was changed to stop reporting the PCI bus info with a
> representor. This itself is an actual regression in functionality:
> Without this information it isn't possible for userspace to know which
> PCI device this representor belongs to.
> 
> In particular, if the appropriate information is available and provided,
> user space will generally rename these devices:
> 
> without linking (i.e. with keeping the workaround:
> eth0
> 
> with linking (i.e. reverting this work around):
> enp24s0f0npf0vf0
> 
> The fact that we aren't providing this bus information is to me the
> actual regression, and removing this workaround fixes it.
> 
> If the workaround did not have such side effects, I would agree that it
> would be preferable to keep it. However, I believe that the correct view
> of the situation is that the original fix was a regression in behavior,
> and that we are fixing that regression by reverting this.
> 
> This should be made more explicit in the commit message so that its
> clear what we're actually fixing.
> 

I apologize. I was somewhat confused as I had thought this patch
included a change to also call SET_NETDEV_DEV as well. That is required
in order for the netdev renaming to work properly. This was being
discussed internally and I mixed up the patches.

However, doing that breaks lshw in the same way that reverting this
workaround would. If we don't include SET_NETDEV_DEV, we end up without
the nice representor names.

So the way I see it:

We discovered the bug in lshw, and had a workaround in ice (which
arguably we shouldn't have done at all, but alas its been done). This
workaround removes the bus information from ethtool and this hides the
fact that the representor device is linked to that PCI device.

We also haven't yet called SET_NETDEV_DEV, which also links the
netdevice to the PCI device.

The same bug in lshw causes it to mis-assign the name of the devices
regardless of whether we include that info from ethtool or from
SET_NETDEV_DEV.

However, if we *don't* include SET_NETDEV_DEV in the driver, we end up
with the situation I described above: we get poor device names instead
of the more useful altnames scheme which aligns with the PF name scheme
and similar.

I believe lack of SET_NETDEV_REG is a more significant regression and
lack of functionality than a minor display bug in lshw that is already
fixed.

Thus, I think we should remove this workaround *and* include the fix to
call SET_NETEDEV_DEV.

We may need to get some opinion on other vendors and implementations.
From my understanding other device vendors call SET_NETDEV_DEV for their
representors already.

I hope this clarifies my statements above and removes the confusion.

Perhaps we should submit both changes together in a series with this
context in the commit message?

>>
>> Kind regards,
>>
>> Paul
>>
>>
>>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>>> ---
>>>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 8 +++-----
>>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>>> index 24cda7e1f916..476bd1c83c87 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>>> @@ -190,19 +190,17 @@ __ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo,
>>>   	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
>>>   		 "%x.%02x 0x%x %d.%d.%d", nvm->major, nvm->minor,
>>>   		 nvm->eetrack, orom->major, orom->build, orom->patch);
>>> +
>>> +	strscpy(drvinfo->bus_info, pci_name(pf->pdev),
>>> +		sizeof(drvinfo->bus_info));
>>>   }
>>>   
>>>   static void
>>>   ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
>>>   {
>>>   	struct ice_netdev_priv *np = netdev_priv(netdev);
>>> -	struct ice_pf *pf = np->vsi->back;
>>>   
>>>   	__ice_get_drvinfo(netdev, drvinfo, np->vsi);
>>> -
>>> -	strscpy(drvinfo->bus_info, pci_name(pf->pdev),
>>> -		sizeof(drvinfo->bus_info));
>>> -
>>>   	drvinfo->n_priv_flags = ICE_PRIV_FLAG_ARRAY_SIZE;
>>>   }
>>>   
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

