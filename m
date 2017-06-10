From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 10 Jun 2017 16:44:36 -0700
Subject: [Intel-wired-lan] [PATCH] i40evf: remove redundant null check
	on key
In-Reply-To: <20170610113342.f4v5j3inpoxwqkhf@mwanda>
References: <20170606235407.6478-1-colin.king@canonical.com>
 <20170610113342.f4v5j3inpoxwqkhf@mwanda>
Message-ID: <CAKgT0UfZw5oYV_mbx6RFsC4n9grFGrEip8mWbbtrA1XMz-GWAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Jun 10, 2017 at 4:33 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This patch isn't right...
>
> On Wed, Jun 07, 2017 at 12:54:07AM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> key has previously been null checked so the subsequent null check
>> is redundant as key can never be null at that point, so remove it.
>>
>
> Actually, it's the reverse.  "key" is always NULL.  Probably the ||
> should be a &&?
>
> regards,
> dan carpenter

Actually the original code and the patched version are still both
broken, but it is more broken with the patch. With this change I am
pretty sure we will kernel panic if we use the ethtool ioctl for
ETHTOOL_SRXFHINDIR, or don't update the key when updating other fields
in the flow hash.

So the original logic here looks like a bad copy of code from igb.
There it doesn't support updating the key so if key is set we are
supposed to be returning an error since key update isn't currently
supported. So the check for key at the start of this function should
probably be dropped instead of the second check. From what I can tell
the original code prevents key from ever being updated since if key is
non-null it means we want to update the key.

- Alex
