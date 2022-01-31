From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 31 Jan 2022 15:06:01 -0800
Subject: [Intel-wired-lan] [PATCH net-next] net: kbuild: Don't default
 net vendor configs to y
In-Reply-To: <20220131121027.4fe3e8dc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20220131172450.4905-1-saeed@kernel.org>
 <20220131095905.08722670@hermes.local>
 <CAMuHMdU17cBzivFm9q-VwF9EG5MX75Qct=is=F2h+Kc+VddZ4g@mail.gmail.com>
 <20220131183540.6ekn3z7tudy5ocdl@sx1>
 <30ed8220-e24d-4b40-c7a6-4b09c84f9a1f@gmail.com>
 <20220131121027.4fe3e8dc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <7dc930c6-4ffc-0dd0-8385-d7956e7d16ff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 1/31/2022 12:10 PM, Jakub Kicinski wrote:
> On Mon, 31 Jan 2022 10:40:38 -0800 Florian Fainelli wrote:
>>>> And changing the defaults means all defconfigs must be updated first,
>>>> else the user's configs will end up without drivers needed.
>>>>   
>>>
>>> As I understand correctly, at least for most common net drivers, having
>>> NET_VENDOR_XYZ=y doesn't actually build anything, we have flags per
>>> module for each vendor and those are defaulted to N.
>>
>> Right, but once you start hiding NET_VENDOR_DRIVER_XYZ under a
>> NET_VENDOR_XYZ Kconfig symbol dependency, if NET_VENDOR_XYZ is not set
>> to Y, then you have no way to select NET_VENDOR_DRIVER_XYZ and so your
>> old defconfig breaks.
> 
> To be clear do we actually care about *old* configs or *def* configs?

I think we care about oldconfig but maybe less so about defconfigs which 
are in tree and can be updated.

> 
> Breaking defconfigs seems bad, but I don't think we can break
> reasonable oldconfigs at this point?

No preference either way for me, just like Richard, all of the systems I 
typically work with either require a carefully curated configuration 
file to strip out unwanted features. I do like Geert's suggestion of 
adding default ARCH_ for slightly esoteric controllers that are not 
found in off the shelf hardware.

> 
>>>> It might make sense to tune some of the defaults (i.e. change to
>>>> "default y if ARCH_*") for drivers with clear platform dependencies.
>>>>   
>>>
>>> either set hard default to 'n' or just keep it as is, anything else is just
>>> more confusion.
>>
>> Maybe the rule should go like this: any new driver vendor defaults to n,
>> and existing ones remain set to y, until we deprecate doing that and
>> switching them all off to n by 5.18?
> 
> I'd be afraid that given the work of fixing up defconfigs is
> non-trivial we may end up never switching old drivers. And then we'd
> have a semi-random soup of defaults :(

Fair enough.
-- 
Florian
