From: Stefano Brivio <sbrivio@redhat.com>
Date: Fri, 25 Aug 2017 22:52:15 +0200
Subject: [Intel-wired-lan] how to submit fixes for i40e/i40evf?
Message-ID: <20170825225215.35fc6b59@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

As I'm currently preparing another fix for i40e, and the last one I
submitted has been stuck for about two weeks now, I would like to ask
some details about the process to submit fixes for i40e/i40evf drivers,
before I do something wrong again.

Do all the patches have to go through Intel's patchwork, no matter
what's the perceived severity of the issue? Should I still submit them
to netdev anyway?

Which trees should I check before submitting a patch? Is it enough to
check the master branch of jkirsher/net-queue.git and
jkirsher/next-queue.git?

Once patches reach Intel's patchwork, will they need to wait for some
kind of periodically scheduled pull request process?

I don't know if a process is actually defined at this level of detail,
but still I feel it's wrong that an obvious fix for a potential crash is
waiting in some sort of limbo for 10 days now. Sure, worse things
happen in the world, but I can't understand what this patch is waiting
for.

Any answer is appreciated. Thanks,

--
Stefano
