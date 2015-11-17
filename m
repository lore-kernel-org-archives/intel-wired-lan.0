From: Tom Herbert <tom@herbertland.com>
Date: Tue, 17 Nov 2015 11:11:15 -0800
Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Handle extended IPv6
	headers in tx path
In-Reply-To: <1D9F24F0-E5CA-41AD-981D-0CB688F06AB5@intel.com>
References: <20151117002647.49052.40409.stgit@mdrustad-wks.jf.intel.com>
 <CALx6S34wd9_qX7sTM=7tx3w+bfhg+rA-J42sjdCos8Jy-cNLwA@mail.gmail.com>
 <CAKgT0UdpoPF2e9cD8mS=hgPdvrZ-suVqx4bCrmjxf9BVqRfcMA@mail.gmail.com>
 <CALx6S34KEGEJXtd2BzgnzyexAzfdF+FvaaYXUhcxAM7hiLgEdg@mail.gmail.com>
 <CAKgT0Udmcd6H_2xSirv_EDK5Bp0vrvm1d6DLx973bCHxFA-8zg@mail.gmail.com>
 <6B2F1AEA-F9E0-466B-8E80-142E5DC9AE85@intel.com>
 <CALx6S34Fv_Beo8a_vh8PP1NYH9VFLcfM2AGDkzY_bJJaxATP3g@mail.gmail.com>
 <1D9F24F0-E5CA-41AD-981D-0CB688F06AB5@intel.com>
Message-ID: <CALx6S35jOK3xUGAMYiikspsHt9=Jzc0LZM=WAvw6nojyE7onnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 17, 2015 at 11:02 AM, Rustad, Mark D
<mark.d.rustad@intel.com> wrote:
> Tom Herbert <tom@herbertland.com> wrote:
>
>> The _only_ thing that is authoritative in checksum offload are the
>> values of csum_start and csum_offset. If a driver ensures that
>> checksum is properly calculated from start and set at the offset, then
>> driver is implementing correct behavior and has no additional
>> requirements as far as the stack is concerned. Neither does the stack
>> does not care if this is done with offload to the device or by calling
>> skb_checksum_help.
>>
>>>>>> The problem is there are scenarios here where a checksum shouldn't be
>>>>>> computed.  If for example the frame is fragmented we should be
>>>>>> displaying some sort of error message and not computing the checksum
>>>>>> because no matter what we compute it isn't going to be valid.
>>>>> If the stack is sending fragments with CHECKSUM_PARTIAL set then that
>>>>> is a bug higher in the stack-- the driver does not need to worry about
>>>>> that.
>>>>
>>>> Right, but it is still something that needs to get fixed.  By
>>>> triggering the dev_warn here we at least create visibility that
>>>> something has gone horribly wrong.
>>>
>>> Right. It needs to be fixed one way or another. In some cases it would be the stack that needs a fix, in some cases a call to skb_checksum_help might be needed or maybe something else.
>>
>> Are you actually seeing fragments with CHECKSUM_PARTIAL set?
>
> I haven't seen any yet and I don't expect to. But the dev_warn that was in this area prior to the current patch was triggered when I first sent IPv6 packets with extended headers. Yes, the checksum was not computed, but there also was a warning in the log. Likewise when I didn't have the encapsulation working for this case, when I tried it I got a warning in the log. So it does indicate when things are broken and so is useful. Of course these were fixed by the driver patch because they were the result of deficiencies in the driver, which you first spotted by code inspection.
>
This does not entirely fix the problem though. It is a valid use case
that someone can send an UDP packet with an extension header that is
unknown to ipv6_skip_exthdr. The driver can do a dev_warn if it wants
to in this case I suppose, but sending out the packet without setting
the checksum is incorrect. The rule is simple: if the drive cannot
offload a checksum then call skb_checksum_help-- this as a default can
never make matters worse.

Tom

> --
> Mark Rustad, Networking Division, Intel Corporation
