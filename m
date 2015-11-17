From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 17 Nov 2015 18:09:35 +0000
Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Handle extended IPv6
	headers in tx path
In-Reply-To: <CAKgT0Udmcd6H_2xSirv_EDK5Bp0vrvm1d6DLx973bCHxFA-8zg@mail.gmail.com>
References: <20151117002647.49052.40409.stgit@mdrustad-wks.jf.intel.com>
 <CALx6S34wd9_qX7sTM=7tx3w+bfhg+rA-J42sjdCos8Jy-cNLwA@mail.gmail.com>
 <CAKgT0UdpoPF2e9cD8mS=hgPdvrZ-suVqx4bCrmjxf9BVqRfcMA@mail.gmail.com>
 <CALx6S34KEGEJXtd2BzgnzyexAzfdF+FvaaYXUhcxAM7hiLgEdg@mail.gmail.com>
 <CAKgT0Udmcd6H_2xSirv_EDK5Bp0vrvm1d6DLx973bCHxFA-8zg@mail.gmail.com>
Message-ID: <6B2F1AEA-F9E0-466B-8E80-142E5DC9AE85@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck <alexander.duyck@gmail.com> wrote:

> On Tue, Nov 17, 2015 at 8:48 AM, Tom Herbert <tom@herbertland.com> wrote:
>> On Tue, Nov 17, 2015 at 8:41 AM, Alexander Duyck
>> <alexander.duyck@gmail.com> wrote:
>>> On Mon, Nov 16, 2015 at 9:21 PM, Tom Herbert <tom@herbertland.com> wrote:
>>>> 
>>>> Failures should not result in dev_warn, just call skb_checksum_help
>>>> instead. Ignoring CHECKSUM_PARTIAL is guaranteed to be sending a bad
>>>> checksum!

But calling skb_checksum_help I think is a false sense of security. In the case of fragmentation for example, it can't possibly help. I'd rather find out that it is failing and figure out what to do about it.

>>> The problem is there are scenarios here where a checksum shouldn't be
>>> computed.  If for example the frame is fragmented we should be
>>> displaying some sort of error message and not computing the checksum
>>> because no matter what we compute it isn't going to be valid.
>> If the stack is sending fragments with CHECKSUM_PARTIAL set then that
>> is a bug higher in the stack-- the driver does not need to worry about
>> that.
> 
> Right, but it is still something that needs to get fixed.  By
> triggering the dev_warn here we at least create visibility that
> something has gone horribly wrong.

Right. It needs to be fixed one way or another. In some cases it would be the stack that needs a fix, in some cases a call to skb_checksum_help might be needed or maybe something else.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151117/a6ec251f/attachment-0001.asc>
