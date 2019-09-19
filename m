From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 19 Sep 2019 15:56:41 +0300
Subject: [Intel-wired-lan] [PATCH v1] igc: Add set_rx_mode support
In-Reply-To: <c83ff718-22e6-996f-7dea-b16317e1a969@redhat.com>
References: <20190910070512.31391-1-sasha.neftin@intel.com>
 <d0ecf9ed-f12f-f204-5223-6f845150a56d@redhat.com>
 <CAKgT0Ue2rti-T1F9N02ejv2qgQuu7pM6aFCh7QJSys-B2MiNBw@mail.gmail.com>
 <6c527dc7-e4f4-0cee-657e-e35af31c91fd@intel.com>
 <c83ff718-22e6-996f-7dea-b16317e1a969@redhat.com>
Message-ID: <bedf2d12-9a0e-2633-2d02-27c35d03fc35@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/19/2019 14:49, David Arcari wrote:
> On 09/19/2019 01:48 AM, Neftin, Sasha wrote:
>> On 9/18/2019 23:29, Alexander Duyck wrote:
>>> On Wed, Sep 18, 2019 at 12:29 PM David Arcari <darcari@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 09/10/2019 03:05 AM, Sasha Neftin wrote:
>>>>> Add multicast addresses list to the MTA table.
>>>>> Implement promiscious mode and add basic rx mode support.
>>>>> Add option for ipv6 address settings.
>>>>>
>>>>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>>>>
>>>> This seems to break ipv4 communication over vlans:
>>>
>> Please, use follow commands for ipv6:
>> ip -6 addr add <ipv6address>/<prefixlength> dev <interface>
>>
>> Example:
>> sudo ip -6 addr add fe80::2a0:c9ff:fe00:2/64 dev enp5s0
>>
>> Remove ipv6 address:
>> sudo ip -6 addr del fe80::2a0:c9ff:fe00:2/64 dev enp5s0
>>
>> ping -6 -I <interface> <address>
>> Example:
>> ping -6 -I enp4s0 fe80::2a0:c9ff:fe00:1
>> I've checked it on my side and looks ipv4 and ipv6 works.
> 
> I'm no longer having connectivity issue with ipv6 with this commit applied.
> 
Thanks to confirming that.
>> Let me not agree with you in regards to break ipv4 communication over
>> vlan. Since vlan not supported yet it can not be broken.
> 
> Well - interestingly enough vlan connectivity was working for ipv4 before this
> commit.  I guess it was just good fortune.
> 
> -DA
> 
Interesting. Okay, anyway, I plan add vlan support in future and will 
share with you.
Sasha
> 
>> I am working to add VLAN support in my next patches.
>>
>>> Why is this code messing with the VLANs? The patch description says it
>>> is enabling multicast and the MTA but it is messing with the VFTA
>>> table as well. That is probably what broke the VLANs.
>>>
>>> I don't see the bits to support ndo_vlan_rx_[add|kill]_vid and without
>>> that it will break VLANs since the driver is filtering them unless
>>> promiscuous filtering is enabled. The VLAN changes should be moved
>>> into a separate patch.
>>>
>> You are right. Few lines related to VFTA present here. Sorry about that.
>> I did not mention add support for VLAN tagged frames in this patch. I
>> plan to add VLAN support in my next patches.
>> Sasha
>>
> 

