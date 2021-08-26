From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 26 Aug 2021 11:19:35 -0700
Subject: [Intel-wired-lan] [PATCH v4] ixgbe: let the xdpdrv work with
 more than 64 cpus
In-Reply-To: <CAL+tcoCovfAQmN_c43ScmjpO9D54CKP5XFTpx6VQpwJVxZhAdg@mail.gmail.com>
References: <20210826141623.8151-1-kerneljasonxing@gmail.com>
 <00890ff4-3264-337a-19cc-521a6434d1d0@gmail.com>
 <860ead37-87f4-22fa-e4f3-5cadd0f2c85c@intel.com>
 <CAL+tcoCovfAQmN_c43ScmjpO9D54CKP5XFTpx6VQpwJVxZhAdg@mail.gmail.com>
Message-ID: <da5da485-9dc7-e731-a8d9-f5ad7c7dffde@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 8/26/21 10:03 AM, Jason Xing wrote:

> 
> Honestly, I'm a little confused right now. @nr_cpu_ids is the fixed
> number which means the total number of cpus the machine has.
> I think, using @nr_cpu_ids is safe one way or the other regardless of
> whether the cpu goes offline or not. What do you think?
> 

More exactly, nr_cpu_ids is the max number cpu id can reach,
even in presence of holes.

I think that most/many num_online_cpus() in drivers/net are simply broken
and should be replaced by nr_cpu_ids.

The assumptions of cpus being nicely numbered from [0 to X-1],
with X==num_online_cpus() is wrong.

Same remark for num_possible_cpus(), see commit
88d4f0db7fa8 ("perf: Fix alloc_callchain_buffers()") for reference.
