From: Tom Herbert <tom@herbertland.com>
Date: Tue, 17 Nov 2015 10:22:21 -0800
Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Handle extended IPv6
	headers in tx path
In-Reply-To: <6B2F1AEA-F9E0-466B-8E80-142E5DC9AE85@intel.com>
References: <20151117002647.49052.40409.stgit@mdrustad-wks.jf.intel.com>
 <CALx6S34wd9_qX7sTM=7tx3w+bfhg+rA-J42sjdCos8Jy-cNLwA@mail.gmail.com>
 <CAKgT0UdpoPF2e9cD8mS=hgPdvrZ-suVqx4bCrmjxf9BVqRfcMA@mail.gmail.com>
 <CALx6S34KEGEJXtd2BzgnzyexAzfdF+FvaaYXUhcxAM7hiLgEdg@mail.gmail.com>
 <CAKgT0Udmcd6H_2xSirv_EDK5Bp0vrvm1d6DLx973bCHxFA-8zg@mail.gmail.com>
 <6B2F1AEA-F9E0-466B-8E80-142E5DC9AE85@intel.com>
Message-ID: <CALx6S34Fv_Beo8a_vh8PP1NYH9VFLcfM2AGDkzY_bJJaxATP3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 17, 2015 at 10:09 AM, Rustad, Mark D
<mark.d.rustad@intel.com> wrote:
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
>> On Tue, Nov 17, 2015 at 8:48 AM, Tom Herbert <tom@herbertland.com> wrote:
>>> On Tue, Nov 17, 2015 at 8:41 AM, Alexander Duyck
>>> <alexander.duyck@gmail.com> wrote:
>>>> On Mon, Nov 16, 2015 at 9:21 PM, Tom Herbert <tom@herbertland.com> wrote:
>>>>>
>>>>> Failures should not result in dev_warn, just call skb_checksum_help
>>>>> instead. Ignoring CHECKSUM_PARTIAL is guaranteed to be sending a bad
>>>>> checksum!
>
> But calling skb_checksum_help I think is a false sense of security. In the case of fragmentation for example, it can't possibly help. I'd rather find out that it is failing and figure out what to do about it.

The _only_ thing that is authoritative in checksum offload are the
values of csum_start and csum_offset. If a driver ensures that
checksum is properly calculated from start and set at the offset, then
driver is implementing correct behavior and has no additional
requirements as far as the stack is concerned. Neither does the stack
does not care if this is done with offload to the device or by calling
skb_checksum_help.

>
>>>> The problem is there are scenarios here where a checksum shouldn't be
>>>> computed.  If for example the frame is fragmented we should be
>>>> displaying some sort of error message and not computing the checksum
>>>> because no matter what we compute it isn't going to be valid.
>>> If the stack is sending fragments with CHECKSUM_PARTIAL set then that
>>> is a bug higher in the stack-- the driver does not need to worry about
>>> that.
>>
>> Right, but it is still something that needs to get fixed.  By
>> triggering the dev_warn here we at least create visibility that
>> something has gone horribly wrong.
>
> Right. It needs to be fixed one way or another. In some cases it would be the stack that needs a fix, in some cases a call to skb_checksum_help might be needed or maybe something else.

Are you actually seeing fragments with CHECKSUM_PARTIAL set?

Tom
