From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 25 Aug 2017 15:10:08 -0700
Subject: [Intel-wired-lan] how to submit fixes for i40e/i40evf?
In-Reply-To: <20170825225215.35fc6b59@elisabeth>
References: <20170825225215.35fc6b59@elisabeth>
Message-ID: <CAKgT0UcLAw0958zJ4o9V9Vyamvd1mBQX1+9GAaZw-hZubMqXnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Aug 25, 2017 at 1:52 PM, Stefano Brivio <sbrivio@redhat.com> wrote:
> Hi,
>
> As I'm currently preparing another fix for i40e, and the last one I
> submitted has been stuck for about two weeks now, I would like to ask
> some details about the process to submit fixes for i40e/i40evf drivers,
> before I do something wrong again.
>
> Do all the patches have to go through Intel's patchwork, no matter
> what's the perceived severity of the issue? Should I still submit them
> to netdev anyway?

It is preferred if they go through Intel's patchwork as they should go
through some additional testing and review that way.

> Which trees should I check before submitting a patch? Is it enough to
> check the master branch of jkirsher/net-queue.git and
> jkirsher/next-queue.git?

It depends on if you want to see the patches end up in Dave's net tree
or his net-next tree. If the fix is high enough priority to be
accepted into Dave's net tree then you can submit it against Jeff's
net-queue, otherwise it should be the next-queue. You might want to
check the next-queue for a fix if you are seeing an issue though, as
there is a chance of a fix for an issue you deem critical ending up
there if somebody else judged it differently.

> Once patches reach Intel's patchwork, will they need to wait for some
> kind of periodically scheduled pull request process?

Once in the patchwork they go through testing and after they have
passed testing Jeff will try to push them to Dave.

> I don't know if a process is actually defined at this level of detail,
> but still I feel it's wrong that an obvious fix for a potential crash is
> waiting in some sort of limbo for 10 days now. Sure, worse things
> happen in the world, but I can't understand what this patch is waiting
> for.

Well in the case of your patch it was rejected as it didn't apply to
Jeff's tree and conflicted with Jacob Keller's patch. He submitted a
v2 on Tuesday which has only been applied for a few days. Once it
receives a "Tested-by:" it will be ready for submission assuming it
passes testing.

> Any answer is appreciated. Thanks,
>
> --
> Stefano

I hope that helps to clarify things.

- Alex
