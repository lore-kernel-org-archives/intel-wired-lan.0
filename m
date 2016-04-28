From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 27 Apr 2016 21:32:38 -0700
Subject: [Intel-wired-lan] [RFC PATCH 4/5] bnxt: Add support for
 segmentation of tunnels with outer checksums
In-Reply-To: <CAKgT0UffVkQWWqgwYZy-AXEq=kofKiRx2D9pnu5nBQD+uSLS+g@mail.gmail.com>
References: <20160419185949.11723.50506.stgit@ahduyck-xeon-server>
 <20160419190615.11723.53966.stgit@ahduyck-xeon-server>
 <CACKFLi=2mHfOS1Rz5RbSdyhepdjBqM+dj7Nh=CzARcYSwUTcSw@mail.gmail.com>
 <CAKgT0UffVkQWWqgwYZy-AXEq=kofKiRx2D9pnu5nBQD+uSLS+g@mail.gmail.com>
Message-ID: <CACKFLi=0ug=E++9prBjC7NsD67+DtLKXXwFtF-E0+trVNtMgbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Apr 27, 2016 at 8:21 AM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Tue, Apr 26, 2016 at 10:55 PM, Michael Chan
> <michael.chan@broadcom.com> wrote:
>> On Tue, Apr 19, 2016 at 12:06 PM, Alexander Duyck <aduyck@mirantis.com> wrote:
>>> This patch assumes that the bnxt hardware will ignore existing IPv4/v6
>>> header fields for length and checksum as well as the length and checksum
>>> fields for outer UDP and GRE headers.
>>>
>>> I have no means of testing this as I do not have any bnx2x hardware but
>>> thought I would submit it as an RFC to see if anyone out there wants to
>>> test this and see if this does in fact enable this functionality allowing
>>> us to to segment tunneled frames that have an outer checksum.
>>>
>>> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>>
>> Hi Alex, I just did a very quick test of this patch on our bnxt
>> hardware and it seemed to work.
>>
>> I created a vxlan endpoint with udpcsum enabled and I saw TSO packets
>> getting through.  I've verified that our hardware can be programmed to
>> either ignore outer UDP checksum or to calculate it.  Current default
>> is to ignore ipv4 UDP checksum and calculate ipv6 UDP checksum.
>> Thanks.
>
> Are you saying you can natively support UDP tunnel with outer checksum
> offload then?

Yes.  Calculate or ignore the outer UDP checksum.

>
> I'm just trying to sort out if you actually need to have the partial
> segmentation offload support or if we can handle it in hardware.  Also
> is there any documentation you could point me to that might help to
> clarify what the hardware does/doesn't support so that I could improve
> upon this patch in order to make sure we are getting the most bang for
> the buck in terms of the features that can be offloaded by hardware?

No public documentation yet.  I think the plan is to publish the
programmer's reference on our website at some point in the future.
