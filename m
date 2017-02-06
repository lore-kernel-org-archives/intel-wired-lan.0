From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 6 Feb 2017 15:09:11 -0800
Subject: [Intel-wired-lan] [PATCH v4 0/4] i40e: Support for XDP
In-Reply-To: <5898F271.1000009@gmail.com>
References: <20161217134000.31640-1-bjorn.topel@gmail.com>
 <CAKgT0Ue5k8YGt1U_9vTM8ZKac-ryiDJ+zapZFuxLkRpdQKTTOw@mail.gmail.com>
 <CAJ+HfNjOBm5MMbAgUk4KRdKdmn66n+M807grhkJ5s+dZi3uAQA@mail.gmail.com>
 <CAKgT0UdZiMPPab-2v_0yvVqc7uA+uYNGAfu36WXvfETxah_B_A@mail.gmail.com>
 <5893B095.6030104@gmail.com>
 <CAKgT0UeLL4xyWVZH3Fvrsg7SpHZ-X-PGYz-NOP7NzgiagOGzow@mail.gmail.com>
 <5898F271.1000009@gmail.com>
Message-ID: <CAKgT0UecqgBDj9BGMGVoi0kNWQ35UbvpWpRb-iVE8TExcvAHzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Feb 6, 2017 at 2:02 PM, John Fastabend <john.fastabend@gmail.com> wrote:
> On 17-02-02 02:57 PM, Alexander Duyck wrote:
>> It would likely be several weeks.  I am still trying to finish up the
>> out-of-tree build_skb changes for i40e.  Once I have that then I can
>> start working on the XDP bits.
>>
>> My guess would be that these would probably end up in the 4.12 kernel
>> when everything is said and done.
>
> OK, iirc though ixgbe already has these changes and we can add XDP support
> without any delays there?
>
> I have a handful of folks wanting to test/use this with adjust_header support
> so for the time being I'm going to push a fork to my github branch for folks
> to pull. But the sooner the better for mainline support.
>
> Thanks,
> John
>

Agreed.  I will try to get this completed ASAP, and you can work with
the fork in the meantime.

Thanks.

- Alex
