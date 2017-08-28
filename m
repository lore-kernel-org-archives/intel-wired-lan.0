From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 28 Aug 2017 10:00:54 -0700
Subject: [Intel-wired-lan] how to submit fixes for i40e/i40evf?
In-Reply-To: <20170826002852.751d5f07@elisabeth>
References: <20170825225215.35fc6b59@elisabeth>
 <CAKgT0UcLAw0958zJ4o9V9Vyamvd1mBQX1+9GAaZw-hZubMqXnw@mail.gmail.com>
 <20170826002852.751d5f07@elisabeth>
Message-ID: <CAKgT0UfjBqma9=71DMVJkxfHGMB15CmPw3uVFaj=-N6gqygE6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Aug 25, 2017 at 3:28 PM, Stefano Brivio <sbrivio@redhat.com> wrote:
> On Fri, 25 Aug 2017 15:10:08 -0700
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
>> On Fri, Aug 25, 2017 at 1:52 PM, Stefano Brivio <sbrivio@redhat.com> wrote:
>>
>> [...]
>>
>> > Once patches reach Intel's patchwork, will they need to wait for some
>> > kind of periodically scheduled pull request process?
>>
>> Once in the patchwork they go through testing and after they have
>> passed testing Jeff will try to push them to Dave.
>
> Ok, the whole part above is clear, thanks a lot for clarifying.
>
>> > I don't know if a process is actually defined at this level of detail,
>> > but still I feel it's wrong that an obvious fix for a potential crash is
>> > waiting in some sort of limbo for 10 days now. Sure, worse things
>> > happen in the world, but I can't understand what this patch is waiting
>> > for.
>>
>> Well in the case of your patch it was rejected as it didn't apply to
>> Jeff's tree
>
> It actually did when I posted it.
>
>> and conflicted with Jacob Keller's patch. He submitted a v2 on Tuesday
>> which has only been applied for a few days. Once it receives a
>> "Tested-by:"
>
> Which, if I understood correctly, only comes after some internal testing
> process, right?
>
>> it will be ready for submission assuming it passes testing.
>
> Now that patch is again in a v2 pull request for net-next, without the
> changes I suggested for the commit message. And the same exact code
> changes were around for two weeks. IMHO there's room for improvement,
> so to speak.
>
>> I hope that helps to clarify things.
>
> It did to some extent, and thanks again for that.

One other thing I forgot that adds to the confusion is that you will
probably want to base you patch on the dev-queue branch of those
trees, not the master branch. The master branch is what Jeff submits
to Dave if I am not mistaken, while dev-queue is the location for the
ongoing development.

- Alex
