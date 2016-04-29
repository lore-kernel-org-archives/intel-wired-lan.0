From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 29 Apr 2016 16:39:15 -0700
Subject: [Intel-wired-lan] [RFC PATCH 4/5] bnxt: Add support for
 segmentation of tunnels with outer checksums
In-Reply-To: <CACKFLik68GedLctO9cXoBZSrFR6RnRkCprn3h=xmBwn3-uojLg@mail.gmail.com>
References: <20160419185949.11723.50506.stgit@ahduyck-xeon-server>
 <20160419190615.11723.53966.stgit@ahduyck-xeon-server>
 <CACKFLi=2mHfOS1Rz5RbSdyhepdjBqM+dj7Nh=CzARcYSwUTcSw@mail.gmail.com>
 <CAKgT0UffVkQWWqgwYZy-AXEq=kofKiRx2D9pnu5nBQD+uSLS+g@mail.gmail.com>
 <CACKFLi=0ug=E++9prBjC7NsD67+DtLKXXwFtF-E0+trVNtMgbA@mail.gmail.com>
 <CAKgT0UeOPX22XipaSUsCgZ9oPsw1Q6KWGoEA+rpjANp6RQ+gnA@mail.gmail.com>
 <CACKFLinpYTDTxzBaijdSTE9q+5Ln4Sbo5fGxRbY+wv6bwP=vOQ@mail.gmail.com>
 <CAKgT0Ud3DWAB+se3nH2Ub+LB+UeMssyFkD=qaBdU3F6_E3u2-A@mail.gmail.com>
 <CACKFLik68GedLctO9cXoBZSrFR6RnRkCprn3h=xmBwn3-uojLg@mail.gmail.com>
Message-ID: <CAKgT0UfN1ECtTBRq8gvYbP_7v0GZDZMNzwpnPjng5QJdcph4FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Apr 29, 2016 at 4:29 PM, Michael Chan <michael.chan@broadcom.com> wrote:
> On Fri, Apr 29, 2016 at 2:31 PM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
>
>> Okay so if that is the case we may want to make it so that we ignore
>> checksum for both IPv4 and IPv6 and then we can just provide it via
>> GSO_PARTIAL in the case we want it.  Otherwise you are technically
>> mangling the frames by inserting a checksum on the outer header even
>> though the tunnel was not configured for it.  If you can point me
>> toward the point in the code where that is happening I can probably
>> make it a part of this patch.
>>
>
> All the chip settings are controlled by firmware.  I will check with
> the firmware team to disable them if they are not already disabled.
> When first developing the driver, before all the recent proposals, the
> intention was to not advertise NETIF_F_GSO_UDP_TUNNEL_CSUM and not
> support TSO with outer UDP checksum enabled.  Thanks.

Right.  But adding a checksum where there wasn't one could
theoretically be problematic if there was a implementation out there
where somebody was mandating that the tunnel checksum must be 0.  The
i40e driver was enabling the same thing in the driver for an upcoming
device that supported an outer checksum offload until I went in and
fixed it.  Generally if we can match what is expected that is
preferred so we don't have any unexpected conflicts in the event that
a VTEP expects the packets to come in with checksums or without.

I have submitted the patch and when the firmware gets updated the
behavior will be cleared up so you can have it either way depending on
what the tunnel itself requested.

Thanks.

- Alex
