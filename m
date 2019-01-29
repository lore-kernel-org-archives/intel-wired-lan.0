From: Alexander Popov <alex.popov@linux.com>
Date: Tue, 29 Jan 2019 03:12:24 +0300
Subject: [Intel-wired-lan] [PATCH 0/3] gcc-plugins: Introduce stackinit
 plugin
In-Reply-To: <20190123110349.35882-1-keescook@chromium.org>
References: <20190123110349.35882-1-keescook@chromium.org>
Message-ID: <874b8c23-068b-f8e7-2168-12947c06e145@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 23.01.2019 14:03, Kees Cook wrote:
> This adds a new plugin "stackinit" that attempts to perform unconditional
> initialization of all stack variables

Hello Kees! Hello everyone!

I was curious about the performance impact of the initialization of all stack
variables. So I did a very brief test with this plugin on top of 4.20.5.

hackbench on Intel Core i7-4770 showed ~0.7% slowdown.
hackbench on Kirin 620 (ARM Cortex-A53 Octa-core 1.2GHz) showed ~1.3% slowdown.

This test involves the kernel scheduler and allocator. I can't say whether they
use stack aggressively. Maybe performance tests of other subsystems (e.g.
network subsystem) can show different numbers. Did you try?

I've heard a hypothesis that the initialization of all stack variables would
pollute CPU caches, which is critical for some types of computations. Maybe some
micro-benchmarks can disprove/confirm that?

Thanks!
Best regards,
Alexander
