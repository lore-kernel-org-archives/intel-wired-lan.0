From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 20 Jan 2016 14:18:06 -0800
Subject: [Intel-wired-lan] [next PATCH 0/3] TSO and checksum fixes for
	i40e
In-Reply-To: <1453327950.2958.25.camel@intel.com>
References: <20160115043921.24270.62791.stgit@localhost.localdomain>
 <CAKgT0Udrbsi_bdC4hidjnY34c92E8+ezLahOk3Rtjqei89avjA@mail.gmail.com>
 <1453327950.2958.25.camel@intel.com>
Message-ID: <CAKgT0UdQeVa7c1vp3ZXvej30w3_29JoZFX35cWWyLvFpayJcfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 20, 2016 at 2:12 PM, Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
> On Wed, 2016-01-20 at 08:24 -0800, Alexander Duyck wrote:
>>
>> Between the fix from Arnd for the build issue and the sparse warnings
>> I will be submitting a v2 of my patches.  Could you please drop the
>> existing set from the tree?
>
> Yeah, I will drop it.  Are you wanting me to pick up Arnd's fix?  or
> Eric D's fix?  or neither and take your v2 build fix?

I was thinking Arnd's fix, I haven't seen Eric D's.  I just know that
mine was only partial compared to the patch Arnd provided.

Thanks.

- Alex
