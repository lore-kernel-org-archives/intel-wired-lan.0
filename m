From: Kees Cook <keescook@chromium.org>
Date: Tue, 12 Feb 2019 09:54:38 -0800
Subject: [Intel-wired-lan] [PATCH 0/3] gcc-plugins: Introduce stackinit
 plugin
In-Reply-To: <874b8c23-068b-f8e7-2168-12947c06e145@linux.com>
References: <20190123110349.35882-1-keescook@chromium.org>
 <874b8c23-068b-f8e7-2168-12947c06e145@linux.com>
Message-ID: <CAGXu5j+xz8_wkY2rVRML_iq1o7ZoF1jVp2mi73LjxaKuMNw1cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jan 28, 2019 at 4:12 PM Alexander Popov <alex.popov@linux.com> wrote:
>
> On 23.01.2019 14:03, Kees Cook wrote:
> > This adds a new plugin "stackinit" that attempts to perform unconditional
> > initialization of all stack variables
>
> Hello Kees! Hello everyone!
>
> I was curious about the performance impact of the initialization of all stack
> variables. So I did a very brief test with this plugin on top of 4.20.5.
>
> hackbench on Intel Core i7-4770 showed ~0.7% slowdown.
> hackbench on Kirin 620 (ARM Cortex-A53 Octa-core 1.2GHz) showed ~1.3% slowdown.

Thanks for looking at this! I'll be including my hackbench
measurements for the v2 here in a moment.

> This test involves the kernel scheduler and allocator. I can't say whether they
> use stack aggressively. Maybe performance tests of other subsystems (e.g.
> network subsystem) can show different numbers. Did you try?

I haven't found a stable network test yet. If someone can find a
reasonable workload, I'd love to hear about it.

> I've heard a hypothesis that the initialization of all stack variables would
> pollute CPU caches, which is critical for some types of computations. Maybe some
> micro-benchmarks can disprove/confirm that?

I kind of think micro-benchmarks aren't so useful because they don't
represent a real-world workload. I've heard people talk about SAP-HANA
as a good test, but I can't get my hands on it. I wonder if anyone has
tried "mysqlslap"?

-- 
Kees Cook
